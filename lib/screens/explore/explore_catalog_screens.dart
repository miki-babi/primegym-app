import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/mock_data.dart';
import '../../l10n/l10n_ext.dart';
import '../../l10n/localized_string.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/pg_button.dart';
import '../../widgets/pg_card.dart';
import '../../widgets/pg_progress_bar.dart';
import '../../widgets/section_header.dart';
import '../../widgets/user_avatar.dart';

class TrainersListScreen extends StatefulWidget {
  const TrainersListScreen({super.key});

  @override
  State<TrainersListScreen> createState() => _TrainersListScreenState();
}

class _TrainersListScreenState extends State<TrainersListScreen> {
  String _query = '';
  String _mode = 'All';
  String? _location;

  List<TrainerProfile> get _filtered {
    final q = _query.trim().toLowerCase();
    return MockData.trainers.where((trainer) {
      if (q.isNotEmpty &&
          !trainer.name.toLowerCase().contains(q) &&
          !trainer.specialization.en.toLowerCase().contains(q)) {
        return false;
      }
      if (_mode == 'In-person' && !trainer.offersInPerson) return false;
      if (_mode == 'Online' && !trainer.offersOnline) return false;
      if (_location != null && trainer.location.en != _location) return false;
      return true;
    }).toList();
  }

  Widget _chipRow(List<String> labels, String selectedLabel,
      ValueChanged<String> onSelect) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final label = labels[i];
          final selected = selectedLabel == label;
          return GestureDetector(
            onTap: () => onSelect(label),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: selected ? AppColors.accentSoft : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? AppColors.accent : AppColors.border,
                ),
              ),
              child: Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: selected
                      ? AppColors.accent
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final locations = {
      for (final trainer in MockData.trainers) trainer.location.en,
    }.toList();
    final modeLabels = {
      'All': l10n.filterAll,
      'In-person': l10n.filterInPerson,
      'Online': l10n.filterOnline,
    };
    final locationLabels = {
      for (final loc in locations) loc: MockData.trainers
          .firstWhere((t) => t.location.en == loc)
          .location,
    };
    final selectedLocationLabel = _location == null
        ? l10n.filterAllLocations
        : context.l10nStr(locationLabels[_location]!);
    final list = _filtered;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.trainersTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: l10n.searchTrainersHint,
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          _chipRow(
            [l10n.filterAll, l10n.filterInPerson, l10n.filterOnline],
            modeLabels[_mode]!,
            (label) => setState(() => _mode = modeLabels.entries
                .firstWhere((e) => e.value == label)
                .key),
          ),
          const SizedBox(height: 8),
          _chipRow(
            [
              l10n.filterAllLocations,
              for (final loc in locations)
                context.l10nStr(locationLabels[loc]!),
            ],
            selectedLocationLabel,
            (label) => setState(() {
              if (label == l10n.filterAllLocations) {
                _location = null;
              } else {
                _location = locations.firstWhere(
                  (loc) => context.l10nStr(locationLabels[loc]!) == label,
                );
              }
            }),
          ),
          const SizedBox(height: 20),
          if (list.isEmpty)
            PgCard(
              child: Text(
                l10n.noTrainersFound,
                style: textTheme.bodyMedium,
              ),
            )
          else
            for (final trainer in list) ...[
              PgCard(
                onTap: () => context.push('/trainer/${trainer.id}'),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    UserAvatar(name: trainer.name, size: 52),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(trainer.name, style: textTheme.titleMedium),
                          const SizedBox(height: 4),
                          Text(
                            context.l10nStr(trainer.specialization),
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            context.l10nStr(trainer.location),
                            style: textTheme.bodySmall,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  l10n.trainerPricePerSession(
                                    trainer.rating,
                                    '${trainer.pricePerSessionEtb} ETB',
                                  ),
                                  style: textTheme.bodySmall?.copyWith(
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                              if (trainer.offersOnline)
                                _ModeBadge(label: l10n.filterOnline),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}

class TrainerDetailScreen extends StatelessWidget {
  const TrainerDetailScreen({super.key, required this.trainerId});

  final String trainerId;

  @override
  Widget build(BuildContext context) {
    final trainer = MockData.trainerById(trainerId) ?? MockData.trainers.first;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.trainerDetailTitle),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.followingDemo(trainer.name))),
              );
            },
            child: Text(l10n.follow),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.3),
                  AppColors.surfaceElevated,
                ],
              ),
              border: Border.all(color: AppColors.border),
            ),
            child: Center(child: UserAvatar(name: trainer.name, size: 72)),
          ),
          const SizedBox(height: 20),
          Text(trainer.name, style: textTheme.headlineMedium),
          const SizedBox(height: 6),
          Text(
            context.l10nStr(trainer.specialization),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '${trainer.gym} · ${context.l10nStr(trainer.availability)}',
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                context.l10nStr(trainer.location),
                style: textTheme.bodySmall,
              ),
              if (trainer.offersInPerson)
                _ModeBadge(label: l10n.filterInPerson),
              if (trainer.offersOnline)
                _ModeBadge(label: l10n.filterOnline),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _StatTile(label: l10n.statRating, value: '${trainer.rating}'),
              const SizedBox(width: 8),
              _StatTile(
                label: l10n.statYears,
                value: '${trainer.yearsExperience}',
              ),
              const SizedBox(width: 8),
              _StatTile(
                label: l10n.statSession,
                value: '${trainer.pricePerSessionEtb}',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(context.l10nStr(trainer.bio), style: textTheme.bodyLarge),
          const SizedBox(height: 28),
          SectionHeader(title: l10n.sectionCertifications),
          const SizedBox(height: 12),
          for (final cert in trainer.certifications) ...[
            Row(
              children: [
                const Icon(
                  Icons.verified_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cert.name, style: textTheme.titleSmall),
                      const SizedBox(height: 2),
                      Text(
                        cert.year == null
                            ? cert.issuer
                            : '${cert.issuer} · ${cert.year}',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 18),
          SectionHeader(title: l10n.sectionPrograms),
          const SizedBox(height: 12),
          for (final program in trainer.programs) ...[
            PgCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.fitness_center_rounded,
                    color: AppColors.accent,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      context.l10nStr(program),
                      style: textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 18),
          SectionHeader(title: l10n.sectionTestimonials),
          const SizedBox(height: 12),
          for (final testimonial in trainer.testimonials) ...[
            PgCard(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        testimonial.author,
                        style: textTheme.titleSmall,
                      ),
                      const Spacer(),
                      Text(
                        '${testimonial.rating} ★',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l10nStr(testimonial.text),
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: PgButton(
            label: l10n.bookDemo,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.bookingDemoOnly)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.eventsTitle),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        itemCount: MockData.events.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final event = MockData.events[i];
          return PgCard(
            onTap: () => context.push('/event/${event.id}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        context.l10nStr(event.type).toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      context.l10nStr(event.dateLabel),
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  context.l10nStr(event.title),
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  context.l10nStr(event.venue),
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.eventAttendingMeta(
                    context.l10nStr(event.timeLabel),
                    event.attending,
                  ),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    final event = MockData.eventById(eventId) ?? MockData.events.first;
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.eventDetailTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.28),
                  AppColors.surfaceElevated,
                ],
              ),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Icon(
                Icons.event_rounded,
                size: 56,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            context.l10nStr(event.type).toUpperCase(),
            style: textTheme.labelMedium?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 8),
          Text(context.l10nStr(event.title), style: textTheme.headlineMedium),
          const SizedBox(height: 16),
          _InfoLine(
            icon: Icons.place_rounded,
            text: context.l10nStr(event.venue),
          ),
          const SizedBox(height: 10),
          _InfoLine(
            icon: Icons.schedule_rounded,
            text:
                '${context.l10nStr(event.dateLabel)} · ${context.l10nStr(event.timeLabel)}',
          ),
          const SizedBox(height: 10),
          _InfoLine(
            icon: Icons.groups_rounded,
            text: l10n.attendingCount(event.attending),
          ),
          const SizedBox(height: 24),
          SectionHeader(title: l10n.sectionAbout),
          const SizedBox(height: 12),
          Text(
            context.l10nStr(event.description),
            style: textTheme.bodyLarge,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: PgButton(
            label: l10n.joinEventDemo,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.joinedEventDemo)),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChallengesListScreen extends StatefulWidget {
  const ChallengesListScreen({super.key});

  @override
  State<ChallengesListScreen> createState() => _ChallengesListScreenState();
}

class _ChallengesListScreenState extends State<ChallengesListScreen> {
  String _filter = 'All';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final list = MockData.challengesForType(_filter);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.challengesTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: MockData.challengeFilters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final label = MockData.challengeFilters[i];
                final selected = _filter == label.en;
                return GestureDetector(
                  onTap: () => setState(() => _filter = label.en),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          selected ? AppColors.accentSoft : AppColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color:
                            selected ? AppColors.accent : AppColors.border,
                      ),
                    ),
                    child: Text(
                      context.l10nStr(label),
                      style: textTheme.labelLarge?.copyWith(
                        color: selected
                            ? AppColors.accent
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          if (list.isEmpty)
            PgCard(
              child: Text(
                l10n.noChallengesInFilter,
                style: textTheme.bodyMedium,
              ),
            )
          else
            for (final challenge in list) ...[
              _ChallengeCard(challenge: challenge),
              const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});

  final ChallengeInfo challenge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return PgCard(
      onTap: () => context.push('/challenge/${challenge.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10nStr(challenge.typeLabel).toUpperCase(),
            style: textTheme.labelSmall?.copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10nStr(challenge.title),
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            context.l10nStr(challenge.subtitle),
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          PgProgressBar(value: challenge.progress / challenge.goal),
          const SizedBox(height: 10),
          Text(
            l10n.challengeProgressMeta(
              challenge.progress,
              challenge.goal,
              challenge.daysLeft,
              challenge.participants,
            ),
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ModeBadge extends StatelessWidget {
  const _ModeBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.accent,
            ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(value, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.accent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ],
    );
  }
}
