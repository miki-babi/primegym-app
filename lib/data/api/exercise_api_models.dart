class TaxonomyRefDto {
  TaxonomyRefDto({
    required this.slug,
    required this.nameEn,
    required this.nameAm,
    required this.nameOm,
  });

  final String slug;
  final String nameEn;
  final String nameAm;
  final String nameOm;

  factory TaxonomyRefDto.fromJson(Map<String, dynamic> json) {
    final nameEn = json['name_en'] as String;
    return TaxonomyRefDto(
      slug: json['slug'] as String,
      nameEn: nameEn,
      nameAm: json['name_am'] as String? ?? nameEn,
      nameOm: json['name_om'] as String? ?? nameEn,
    );
  }
}

class MuscleRefDto extends TaxonomyRefDto {
  MuscleRefDto({
    required super.slug,
    required super.nameEn,
    required super.nameAm,
    required super.nameOm,
    this.role = 'primary',
  });

  final String role;

  factory MuscleRefDto.fromJson(Map<String, dynamic> json) {
    final nameEn = json['name_en'] as String;
    return MuscleRefDto(
      slug: json['slug'] as String,
      nameEn: nameEn,
      nameAm: json['name_am'] as String? ?? nameEn,
      nameOm: json['name_om'] as String? ?? nameEn,
      role: json['role'] as String? ?? 'primary',
    );
  }
}

class TaxonomyItemDto {
  TaxonomyItemDto({
    required this.id,
    required this.slug,
    required this.nameEn,
    required this.nameAm,
    required this.nameOm,
    this.sortOrder = 0,
  });

  final int id;
  final String slug;
  final String nameEn;
  final String nameAm;
  final String nameOm;
  final int sortOrder;

  factory TaxonomyItemDto.fromJson(Map<String, dynamic> json) {
    final nameEn = json['name_en'] as String;
    return TaxonomyItemDto(
      id: json['id'] as int,
      slug: json['slug'] as String,
      nameEn: nameEn,
      nameAm: json['name_am'] as String? ?? nameEn,
      nameOm: json['name_om'] as String? ?? nameEn,
      sortOrder: json['sort_order'] as int? ?? 0,
    );
  }
}

class ExerciseDto {
  ExerciseDto({
    required this.id,
    required this.externalId,
    required this.slug,
    required this.nameEn,
    required this.nameAm,
    required this.nameOm,
    this.instructionsEn,
    this.instructionsAm,
    this.instructionsOm,
    this.gifUrl,
    required this.type,
    required this.difficulty,
    required this.status,
    this.publishedAt,
    required this.updatedAt,
    this.bodyParts = const [],
    this.muscles = const [],
    this.equipments = const [],
  });

  final String id;
  final String externalId;
  final String slug;
  final String nameEn;
  final String nameAm;
  final String nameOm;
  final String? instructionsEn;
  final String? instructionsAm;
  final String? instructionsOm;
  final String? gifUrl;
  final String type;
  final String difficulty;
  final String status;
  final String? publishedAt;
  final String updatedAt;
  final List<TaxonomyRefDto> bodyParts;
  final List<MuscleRefDto> muscles;
  final List<TaxonomyRefDto> equipments;

  factory ExerciseDto.fromJson(Map<String, dynamic> json) {
    final nameEn = json['name_en'] as String;
    return ExerciseDto(
      id: json['id'] as String,
      externalId: json['external_id'] as String? ?? '',
      slug: json['slug'] as String,
      nameEn: nameEn,
      nameAm: json['name_am'] as String? ?? nameEn,
      nameOm: json['name_om'] as String? ?? nameEn,
      instructionsEn: json['instructions_en'] as String?,
      instructionsAm: json['instructions_am'] as String?,
      instructionsOm: json['instructions_om'] as String?,
      gifUrl: json['gif_url'] as String?,
      type: json['type'] as String,
      difficulty: json['difficulty'] as String,
      status: json['status'] as String? ?? 'published',
      publishedAt: json['published_at'] as String?,
      updatedAt: json['updated_at'] as String,
      bodyParts: (json['body_parts'] as List<dynamic>? ?? [])
          .map((e) => TaxonomyRefDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      muscles: (json['muscles'] as List<dynamic>? ?? [])
          .map((e) => MuscleRefDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      equipments: (json['equipments'] as List<dynamic>? ?? [])
          .map((e) => TaxonomyRefDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
