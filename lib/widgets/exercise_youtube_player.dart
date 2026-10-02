import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../theme/app_colors.dart';

/// In-app YouTube embed.
///
/// Do not wrap this widget in [ClipRRect] / hard clips — clipping an Android
/// platform WebView frequently breaks playback.
class ExerciseYoutubePlayer extends StatefulWidget {
  const ExerciseYoutubePlayer({
    super.key,
    required this.videoId,
    this.borderRadius = 20,
    this.aspectRatio = 16 / 9,
  });

  final String videoId;
  final double borderRadius;
  final double aspectRatio;

  @override
  State<ExerciseYoutubePlayer> createState() => _ExerciseYoutubePlayerState();
}

class _ExerciseYoutubePlayerState extends State<ExerciseYoutubePlayer> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
        strictRelatedVideos: true,
        enableCaption: false,
        playsInline: true,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ExerciseYoutubePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.cueVideoById(videoId: widget.videoId);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: YoutubePlayerControllerProvider(
          controller: _controller,
          child: YoutubePlayer(
            controller: _controller,
            aspectRatio: widget.aspectRatio,
            backgroundColor: AppColors.surfaceElevated,
          ),
        ),
      ),
    );
  }
}
