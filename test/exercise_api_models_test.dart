import 'package:flutter_test/flutter_test.dart';
import 'package:primegym/data/api/exercise_api_models.dart';

void main() {
  group('ExerciseDto.fromJson', () {
    test('parses the documented sample payload', () {
      final json = <String, dynamic>{
        'id': '01m53nt59kw9dtzpdq74w0bwgq',
        'external_id': '2ORFMoR',
        'slug': 'hack-calf-raise',
        'name_en': 'hack calf raise',
        'name_am': 'hack calf raise',
        'name_om': 'hack calf raise',
        'instructions_en':
            'Step:1 Adjust the sled machine to a comfortable weight.\n\nStep:2 Stand on the sled machine with your toes on the platform and your heels hanging off.',
        'instructions_am': '...',
        'instructions_om': '...',
        'gif_url':
            'https://your-domain.com/storage/exercises/01m53nt59kw9dtzpdq74w0bwgq/gif.gif',
        'type': 'compound',
        'difficulty': 'beginner',
        'status': 'published',
        'published_at': '2026-10-17T00:00:00+00:00',
        'updated_at': '2026-10-17T00:00:00+00:00',
        'body_parts': [
          {
            'slug': 'lower-legs',
            'name_en': 'lower legs',
            'name_am': 'lower legs',
            'name_om': 'lower legs'
          }
        ],
        'muscles': [
          {
            'slug': 'calves',
            'name_en': 'calves',
            'name_am': 'calves',
            'name_om': 'calves',
            'role': 'primary'
          },
          {
            'slug': 'hamstrings',
            'name_en': 'hamstrings',
            'name_am': 'hamstrings',
            'name_om': 'hamstrings',
            'role': 'secondary'
          }
        ],
        'equipments': [
          {
            'slug': 'sled-machine',
            'name_en': 'sled machine',
            'name_am': 'sled machine',
            'name_om': 'sled machine'
          }
        ]
      };

      final dto = ExerciseDto.fromJson(json);

      expect(dto.id, '01m53nt59kw9dtzpdq74w0bwgq');
      expect(dto.externalId, '2ORFMoR');
      expect(dto.slug, 'hack-calf-raise');
      expect(dto.nameEn, 'hack calf raise');
      expect(dto.instructionsEn, startsWith('Step:1'));
      expect(dto.gifUrl, endsWith('gif.gif'));
      expect(dto.type, 'compound');
      expect(dto.difficulty, 'beginner');
      expect(dto.status, 'published');
      expect(dto.publishedAt, '2026-10-17T00:00:00+00:00');
      expect(dto.updatedAt, '2026-10-17T00:00:00+00:00');
      expect(dto.bodyParts.single.slug, 'lower-legs');
      expect(dto.muscles.length, 2);
      expect(dto.muscles[0].slug, 'calves');
      expect(dto.muscles[0].role, 'primary');
      expect(dto.muscles[1].slug, 'hamstrings');
      expect(dto.muscles[1].role, 'secondary');
      expect(dto.equipments.single.slug, 'sled-machine');
    });

    test('tolerates missing lists and null localized names', () {
      final dto = ExerciseDto.fromJson(<String, dynamic>{
        'id': 'x',
        'external_id': 'x',
        'slug': 'x',
        'name_en': 'name',
        'name_am': null,
        'name_om': null,
        'type': 'isolation',
        'difficulty': 'advanced',
        'status': 'published',
        'updated_at': '2026-01-01T00:00:00Z',
      });

      expect(dto.nameAm, 'name');
      expect(dto.nameOm, 'name');
      expect(dto.bodyParts, isEmpty);
      expect(dto.muscles, isEmpty);
      expect(dto.equipments, isEmpty);
      expect(dto.gifUrl, isNull);
      expect(dto.publishedAt, isNull);
    });
  });

  group('TaxonomyItemDto.fromJson', () {
    test('parses the documented taxonomy item', () {
      final item = TaxonomyItemDto.fromJson(<String, dynamic>{
        'id': 2,
        'slug': 'shoulders',
        'name_en': 'shoulders',
        'name_am': 'shoulders',
        'name_om': 'shoulders',
        'sort_order': 2,
      });

      expect(item.id, 2);
      expect(item.slug, 'shoulders');
      expect(item.nameEn, 'shoulders');
      expect(item.sortOrder, 2);
    });

    test('defaults sort_order to 0', () {
      final item = TaxonomyItemDto.fromJson(<String, dynamic>{
        'id': 1,
        'slug': 'neck',
        'name_en': 'neck',
        'name_am': 'neck',
        'name_om': 'neck',
      });
      expect(item.sortOrder, 0);
    });
  });
}
