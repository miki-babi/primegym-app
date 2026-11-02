// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_database.dart';

// ignore_for_file: type=lint
class $LocalExercisesTable extends LocalExercises
    with TableInfo<$LocalExercisesTable, LocalExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameAmMeta = const VerificationMeta('nameAm');
  @override
  late final GeneratedColumn<String> nameAm = GeneratedColumn<String>(
    'name_am',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameOmMeta = const VerificationMeta('nameOm');
  @override
  late final GeneratedColumn<String> nameOm = GeneratedColumn<String>(
    'name_om',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionsEnMeta = const VerificationMeta(
    'instructionsEn',
  );
  @override
  late final GeneratedColumn<String> instructionsEn = GeneratedColumn<String>(
    'instructions_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsAmMeta = const VerificationMeta(
    'instructionsAm',
  );
  @override
  late final GeneratedColumn<String> instructionsAm = GeneratedColumn<String>(
    'instructions_am',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsOmMeta = const VerificationMeta(
    'instructionsOm',
  );
  @override
  late final GeneratedColumn<String> instructionsOm = GeneratedColumn<String>(
    'instructions_om',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gifUrlMeta = const VerificationMeta('gifUrl');
  @override
  late final GeneratedColumn<String> gifUrl = GeneratedColumn<String>(
    'gif_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gifLocalPathMeta = const VerificationMeta(
    'gifLocalPath',
  );
  @override
  late final GeneratedColumn<String> gifLocalPath = GeneratedColumn<String>(
    'gif_local_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gifLocalUrlMeta = const VerificationMeta(
    'gifLocalUrl',
  );
  @override
  late final GeneratedColumn<String> gifLocalUrl = GeneratedColumn<String>(
    'gif_local_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _publishedAtMeta = const VerificationMeta(
    'publishedAt',
  );
  @override
  late final GeneratedColumn<String> publishedAt = GeneratedColumn<String>(
    'published_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    externalId,
    slug,
    nameEn,
    nameAm,
    nameOm,
    instructionsEn,
    instructionsAm,
    instructionsOm,
    gifUrl,
    gifLocalPath,
    gifLocalUrl,
    type,
    difficulty,
    status,
    publishedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalExercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_am')) {
      context.handle(
        _nameAmMeta,
        nameAm.isAcceptableOrUnknown(data['name_am']!, _nameAmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameAmMeta);
    }
    if (data.containsKey('name_om')) {
      context.handle(
        _nameOmMeta,
        nameOm.isAcceptableOrUnknown(data['name_om']!, _nameOmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameOmMeta);
    }
    if (data.containsKey('instructions_en')) {
      context.handle(
        _instructionsEnMeta,
        instructionsEn.isAcceptableOrUnknown(
          data['instructions_en']!,
          _instructionsEnMeta,
        ),
      );
    }
    if (data.containsKey('instructions_am')) {
      context.handle(
        _instructionsAmMeta,
        instructionsAm.isAcceptableOrUnknown(
          data['instructions_am']!,
          _instructionsAmMeta,
        ),
      );
    }
    if (data.containsKey('instructions_om')) {
      context.handle(
        _instructionsOmMeta,
        instructionsOm.isAcceptableOrUnknown(
          data['instructions_om']!,
          _instructionsOmMeta,
        ),
      );
    }
    if (data.containsKey('gif_url')) {
      context.handle(
        _gifUrlMeta,
        gifUrl.isAcceptableOrUnknown(data['gif_url']!, _gifUrlMeta),
      );
    }
    if (data.containsKey('gif_local_path')) {
      context.handle(
        _gifLocalPathMeta,
        gifLocalPath.isAcceptableOrUnknown(
          data['gif_local_path']!,
          _gifLocalPathMeta,
        ),
      );
    }
    if (data.containsKey('gif_local_url')) {
      context.handle(
        _gifLocalUrlMeta,
        gifLocalUrl.isAcceptableOrUnknown(
          data['gif_local_url']!,
          _gifLocalUrlMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('published_at')) {
      context.handle(
        _publishedAtMeta,
        publishedAt.isAcceptableOrUnknown(
          data['published_at']!,
          _publishedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalExercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_am'],
      )!,
      nameOm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_om'],
      )!,
      instructionsEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions_en'],
      ),
      instructionsAm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions_am'],
      ),
      instructionsOm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions_om'],
      ),
      gifUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gif_url'],
      ),
      gifLocalPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gif_local_path'],
      ),
      gifLocalUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gif_local_url'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      publishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}published_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalExercisesTable createAlias(String alias) {
    return $LocalExercisesTable(attachedDatabase, alias);
  }
}

class LocalExercise extends DataClass implements Insertable<LocalExercise> {
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
  final String? gifLocalPath;
  final String? gifLocalUrl;
  final String type;
  final String difficulty;
  final String status;
  final String? publishedAt;
  final String updatedAt;
  const LocalExercise({
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
    this.gifLocalPath,
    this.gifLocalUrl,
    required this.type,
    required this.difficulty,
    required this.status,
    this.publishedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['external_id'] = Variable<String>(externalId);
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    map['name_am'] = Variable<String>(nameAm);
    map['name_om'] = Variable<String>(nameOm);
    if (!nullToAbsent || instructionsEn != null) {
      map['instructions_en'] = Variable<String>(instructionsEn);
    }
    if (!nullToAbsent || instructionsAm != null) {
      map['instructions_am'] = Variable<String>(instructionsAm);
    }
    if (!nullToAbsent || instructionsOm != null) {
      map['instructions_om'] = Variable<String>(instructionsOm);
    }
    if (!nullToAbsent || gifUrl != null) {
      map['gif_url'] = Variable<String>(gifUrl);
    }
    if (!nullToAbsent || gifLocalPath != null) {
      map['gif_local_path'] = Variable<String>(gifLocalPath);
    }
    if (!nullToAbsent || gifLocalUrl != null) {
      map['gif_local_url'] = Variable<String>(gifLocalUrl);
    }
    map['type'] = Variable<String>(type);
    map['difficulty'] = Variable<String>(difficulty);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || publishedAt != null) {
      map['published_at'] = Variable<String>(publishedAt);
    }
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  LocalExercisesCompanion toCompanion(bool nullToAbsent) {
    return LocalExercisesCompanion(
      id: Value(id),
      externalId: Value(externalId),
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameAm: Value(nameAm),
      nameOm: Value(nameOm),
      instructionsEn: instructionsEn == null && nullToAbsent
          ? const Value.absent()
          : Value(instructionsEn),
      instructionsAm: instructionsAm == null && nullToAbsent
          ? const Value.absent()
          : Value(instructionsAm),
      instructionsOm: instructionsOm == null && nullToAbsent
          ? const Value.absent()
          : Value(instructionsOm),
      gifUrl: gifUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(gifUrl),
      gifLocalPath: gifLocalPath == null && nullToAbsent
          ? const Value.absent()
          : Value(gifLocalPath),
      gifLocalUrl: gifLocalUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(gifLocalUrl),
      type: Value(type),
      difficulty: Value(difficulty),
      status: Value(status),
      publishedAt: publishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(publishedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalExercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalExercise(
      id: serializer.fromJson<String>(json['id']),
      externalId: serializer.fromJson<String>(json['externalId']),
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAm: serializer.fromJson<String>(json['nameAm']),
      nameOm: serializer.fromJson<String>(json['nameOm']),
      instructionsEn: serializer.fromJson<String?>(json['instructionsEn']),
      instructionsAm: serializer.fromJson<String?>(json['instructionsAm']),
      instructionsOm: serializer.fromJson<String?>(json['instructionsOm']),
      gifUrl: serializer.fromJson<String?>(json['gifUrl']),
      gifLocalPath: serializer.fromJson<String?>(json['gifLocalPath']),
      gifLocalUrl: serializer.fromJson<String?>(json['gifLocalUrl']),
      type: serializer.fromJson<String>(json['type']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      status: serializer.fromJson<String>(json['status']),
      publishedAt: serializer.fromJson<String?>(json['publishedAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'externalId': serializer.toJson<String>(externalId),
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAm': serializer.toJson<String>(nameAm),
      'nameOm': serializer.toJson<String>(nameOm),
      'instructionsEn': serializer.toJson<String?>(instructionsEn),
      'instructionsAm': serializer.toJson<String?>(instructionsAm),
      'instructionsOm': serializer.toJson<String?>(instructionsOm),
      'gifUrl': serializer.toJson<String?>(gifUrl),
      'gifLocalPath': serializer.toJson<String?>(gifLocalPath),
      'gifLocalUrl': serializer.toJson<String?>(gifLocalUrl),
      'type': serializer.toJson<String>(type),
      'difficulty': serializer.toJson<String>(difficulty),
      'status': serializer.toJson<String>(status),
      'publishedAt': serializer.toJson<String?>(publishedAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  LocalExercise copyWith({
    String? id,
    String? externalId,
    String? slug,
    String? nameEn,
    String? nameAm,
    String? nameOm,
    Value<String?> instructionsEn = const Value.absent(),
    Value<String?> instructionsAm = const Value.absent(),
    Value<String?> instructionsOm = const Value.absent(),
    Value<String?> gifUrl = const Value.absent(),
    Value<String?> gifLocalPath = const Value.absent(),
    Value<String?> gifLocalUrl = const Value.absent(),
    String? type,
    String? difficulty,
    String? status,
    Value<String?> publishedAt = const Value.absent(),
    String? updatedAt,
  }) => LocalExercise(
    id: id ?? this.id,
    externalId: externalId ?? this.externalId,
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameAm: nameAm ?? this.nameAm,
    nameOm: nameOm ?? this.nameOm,
    instructionsEn: instructionsEn.present
        ? instructionsEn.value
        : this.instructionsEn,
    instructionsAm: instructionsAm.present
        ? instructionsAm.value
        : this.instructionsAm,
    instructionsOm: instructionsOm.present
        ? instructionsOm.value
        : this.instructionsOm,
    gifUrl: gifUrl.present ? gifUrl.value : this.gifUrl,
    gifLocalPath: gifLocalPath.present ? gifLocalPath.value : this.gifLocalPath,
    gifLocalUrl: gifLocalUrl.present ? gifLocalUrl.value : this.gifLocalUrl,
    type: type ?? this.type,
    difficulty: difficulty ?? this.difficulty,
    status: status ?? this.status,
    publishedAt: publishedAt.present ? publishedAt.value : this.publishedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalExercise copyWithCompanion(LocalExercisesCompanion data) {
    return LocalExercise(
      id: data.id.present ? data.id.value : this.id,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAm: data.nameAm.present ? data.nameAm.value : this.nameAm,
      nameOm: data.nameOm.present ? data.nameOm.value : this.nameOm,
      instructionsEn: data.instructionsEn.present
          ? data.instructionsEn.value
          : this.instructionsEn,
      instructionsAm: data.instructionsAm.present
          ? data.instructionsAm.value
          : this.instructionsAm,
      instructionsOm: data.instructionsOm.present
          ? data.instructionsOm.value
          : this.instructionsOm,
      gifUrl: data.gifUrl.present ? data.gifUrl.value : this.gifUrl,
      gifLocalPath: data.gifLocalPath.present
          ? data.gifLocalPath.value
          : this.gifLocalPath,
      gifLocalUrl: data.gifLocalUrl.present
          ? data.gifLocalUrl.value
          : this.gifLocalUrl,
      type: data.type.present ? data.type.value : this.type,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      status: data.status.present ? data.status.value : this.status,
      publishedAt: data.publishedAt.present
          ? data.publishedAt.value
          : this.publishedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalExercise(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('instructionsEn: $instructionsEn, ')
          ..write('instructionsAm: $instructionsAm, ')
          ..write('instructionsOm: $instructionsOm, ')
          ..write('gifUrl: $gifUrl, ')
          ..write('gifLocalPath: $gifLocalPath, ')
          ..write('gifLocalUrl: $gifLocalUrl, ')
          ..write('type: $type, ')
          ..write('difficulty: $difficulty, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    externalId,
    slug,
    nameEn,
    nameAm,
    nameOm,
    instructionsEn,
    instructionsAm,
    instructionsOm,
    gifUrl,
    gifLocalPath,
    gifLocalUrl,
    type,
    difficulty,
    status,
    publishedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalExercise &&
          other.id == this.id &&
          other.externalId == this.externalId &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameAm == this.nameAm &&
          other.nameOm == this.nameOm &&
          other.instructionsEn == this.instructionsEn &&
          other.instructionsAm == this.instructionsAm &&
          other.instructionsOm == this.instructionsOm &&
          other.gifUrl == this.gifUrl &&
          other.gifLocalPath == this.gifLocalPath &&
          other.gifLocalUrl == this.gifLocalUrl &&
          other.type == this.type &&
          other.difficulty == this.difficulty &&
          other.status == this.status &&
          other.publishedAt == this.publishedAt &&
          other.updatedAt == this.updatedAt);
}

class LocalExercisesCompanion extends UpdateCompanion<LocalExercise> {
  final Value<String> id;
  final Value<String> externalId;
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String> nameAm;
  final Value<String> nameOm;
  final Value<String?> instructionsEn;
  final Value<String?> instructionsAm;
  final Value<String?> instructionsOm;
  final Value<String?> gifUrl;
  final Value<String?> gifLocalPath;
  final Value<String?> gifLocalUrl;
  final Value<String> type;
  final Value<String> difficulty;
  final Value<String> status;
  final Value<String?> publishedAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const LocalExercisesCompanion({
    this.id = const Value.absent(),
    this.externalId = const Value.absent(),
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAm = const Value.absent(),
    this.nameOm = const Value.absent(),
    this.instructionsEn = const Value.absent(),
    this.instructionsAm = const Value.absent(),
    this.instructionsOm = const Value.absent(),
    this.gifUrl = const Value.absent(),
    this.gifLocalPath = const Value.absent(),
    this.gifLocalUrl = const Value.absent(),
    this.type = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.status = const Value.absent(),
    this.publishedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalExercisesCompanion.insert({
    required String id,
    this.externalId = const Value.absent(),
    required String slug,
    required String nameEn,
    required String nameAm,
    required String nameOm,
    this.instructionsEn = const Value.absent(),
    this.instructionsAm = const Value.absent(),
    this.instructionsOm = const Value.absent(),
    this.gifUrl = const Value.absent(),
    this.gifLocalPath = const Value.absent(),
    this.gifLocalUrl = const Value.absent(),
    required String type,
    required String difficulty,
    required String status,
    this.publishedAt = const Value.absent(),
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       nameEn = Value(nameEn),
       nameAm = Value(nameAm),
       nameOm = Value(nameOm),
       type = Value(type),
       difficulty = Value(difficulty),
       status = Value(status),
       updatedAt = Value(updatedAt);
  static Insertable<LocalExercise> custom({
    Expression<String>? id,
    Expression<String>? externalId,
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameAm,
    Expression<String>? nameOm,
    Expression<String>? instructionsEn,
    Expression<String>? instructionsAm,
    Expression<String>? instructionsOm,
    Expression<String>? gifUrl,
    Expression<String>? gifLocalPath,
    Expression<String>? gifLocalUrl,
    Expression<String>? type,
    Expression<String>? difficulty,
    Expression<String>? status,
    Expression<String>? publishedAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (externalId != null) 'external_id': externalId,
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAm != null) 'name_am': nameAm,
      if (nameOm != null) 'name_om': nameOm,
      if (instructionsEn != null) 'instructions_en': instructionsEn,
      if (instructionsAm != null) 'instructions_am': instructionsAm,
      if (instructionsOm != null) 'instructions_om': instructionsOm,
      if (gifUrl != null) 'gif_url': gifUrl,
      if (gifLocalPath != null) 'gif_local_path': gifLocalPath,
      if (gifLocalUrl != null) 'gif_local_url': gifLocalUrl,
      if (type != null) 'type': type,
      if (difficulty != null) 'difficulty': difficulty,
      if (status != null) 'status': status,
      if (publishedAt != null) 'published_at': publishedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? externalId,
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String>? nameAm,
    Value<String>? nameOm,
    Value<String?>? instructionsEn,
    Value<String?>? instructionsAm,
    Value<String?>? instructionsOm,
    Value<String?>? gifUrl,
    Value<String?>? gifLocalPath,
    Value<String?>? gifLocalUrl,
    Value<String>? type,
    Value<String>? difficulty,
    Value<String>? status,
    Value<String?>? publishedAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalExercisesCompanion(
      id: id ?? this.id,
      externalId: externalId ?? this.externalId,
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameAm: nameAm ?? this.nameAm,
      nameOm: nameOm ?? this.nameOm,
      instructionsEn: instructionsEn ?? this.instructionsEn,
      instructionsAm: instructionsAm ?? this.instructionsAm,
      instructionsOm: instructionsOm ?? this.instructionsOm,
      gifUrl: gifUrl ?? this.gifUrl,
      gifLocalPath: gifLocalPath ?? this.gifLocalPath,
      gifLocalUrl: gifLocalUrl ?? this.gifLocalUrl,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
      publishedAt: publishedAt ?? this.publishedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAm.present) {
      map['name_am'] = Variable<String>(nameAm.value);
    }
    if (nameOm.present) {
      map['name_om'] = Variable<String>(nameOm.value);
    }
    if (instructionsEn.present) {
      map['instructions_en'] = Variable<String>(instructionsEn.value);
    }
    if (instructionsAm.present) {
      map['instructions_am'] = Variable<String>(instructionsAm.value);
    }
    if (instructionsOm.present) {
      map['instructions_om'] = Variable<String>(instructionsOm.value);
    }
    if (gifUrl.present) {
      map['gif_url'] = Variable<String>(gifUrl.value);
    }
    if (gifLocalPath.present) {
      map['gif_local_path'] = Variable<String>(gifLocalPath.value);
    }
    if (gifLocalUrl.present) {
      map['gif_local_url'] = Variable<String>(gifLocalUrl.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (publishedAt.present) {
      map['published_at'] = Variable<String>(publishedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalExercisesCompanion(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('instructionsEn: $instructionsEn, ')
          ..write('instructionsAm: $instructionsAm, ')
          ..write('instructionsOm: $instructionsOm, ')
          ..write('gifUrl: $gifUrl, ')
          ..write('gifLocalPath: $gifLocalPath, ')
          ..write('gifLocalUrl: $gifLocalUrl, ')
          ..write('type: $type, ')
          ..write('difficulty: $difficulty, ')
          ..write('status: $status, ')
          ..write('publishedAt: $publishedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalBodyPartsTable extends LocalBodyParts
    with TableInfo<$LocalBodyPartsTable, LocalBodyPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalBodyPartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameAmMeta = const VerificationMeta('nameAm');
  @override
  late final GeneratedColumn<String> nameAm = GeneratedColumn<String>(
    'name_am',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameOmMeta = const VerificationMeta('nameOm');
  @override
  late final GeneratedColumn<String> nameOm = GeneratedColumn<String>(
    'name_om',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    slug,
    nameEn,
    nameAm,
    nameOm,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_body_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalBodyPart> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_am')) {
      context.handle(
        _nameAmMeta,
        nameAm.isAcceptableOrUnknown(data['name_am']!, _nameAmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameAmMeta);
    }
    if (data.containsKey('name_om')) {
      context.handle(
        _nameOmMeta,
        nameOm.isAcceptableOrUnknown(data['name_om']!, _nameOmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameOmMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  LocalBodyPart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalBodyPart(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_am'],
      )!,
      nameOm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_om'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $LocalBodyPartsTable createAlias(String alias) {
    return $LocalBodyPartsTable(attachedDatabase, alias);
  }
}

class LocalBodyPart extends DataClass implements Insertable<LocalBodyPart> {
  final String slug;
  final String nameEn;
  final String nameAm;
  final String nameOm;
  final int sortOrder;
  const LocalBodyPart({
    required this.slug,
    required this.nameEn,
    required this.nameAm,
    required this.nameOm,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    map['name_am'] = Variable<String>(nameAm);
    map['name_om'] = Variable<String>(nameOm);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  LocalBodyPartsCompanion toCompanion(bool nullToAbsent) {
    return LocalBodyPartsCompanion(
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameAm: Value(nameAm),
      nameOm: Value(nameOm),
      sortOrder: Value(sortOrder),
    );
  }

  factory LocalBodyPart.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalBodyPart(
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAm: serializer.fromJson<String>(json['nameAm']),
      nameOm: serializer.fromJson<String>(json['nameOm']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAm': serializer.toJson<String>(nameAm),
      'nameOm': serializer.toJson<String>(nameOm),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  LocalBodyPart copyWith({
    String? slug,
    String? nameEn,
    String? nameAm,
    String? nameOm,
    int? sortOrder,
  }) => LocalBodyPart(
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameAm: nameAm ?? this.nameAm,
    nameOm: nameOm ?? this.nameOm,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  LocalBodyPart copyWithCompanion(LocalBodyPartsCompanion data) {
    return LocalBodyPart(
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAm: data.nameAm.present ? data.nameAm.value : this.nameAm,
      nameOm: data.nameOm.present ? data.nameOm.value : this.nameOm,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalBodyPart(')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, nameEn, nameAm, nameOm, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalBodyPart &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameAm == this.nameAm &&
          other.nameOm == this.nameOm &&
          other.sortOrder == this.sortOrder);
}

class LocalBodyPartsCompanion extends UpdateCompanion<LocalBodyPart> {
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String> nameAm;
  final Value<String> nameOm;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const LocalBodyPartsCompanion({
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAm = const Value.absent(),
    this.nameOm = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalBodyPartsCompanion.insert({
    required String slug,
    required String nameEn,
    required String nameAm,
    required String nameOm,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug),
       nameEn = Value(nameEn),
       nameAm = Value(nameAm),
       nameOm = Value(nameOm);
  static Insertable<LocalBodyPart> custom({
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameAm,
    Expression<String>? nameOm,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAm != null) 'name_am': nameAm,
      if (nameOm != null) 'name_om': nameOm,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalBodyPartsCompanion copyWith({
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String>? nameAm,
    Value<String>? nameOm,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return LocalBodyPartsCompanion(
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameAm: nameAm ?? this.nameAm,
      nameOm: nameOm ?? this.nameOm,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAm.present) {
      map['name_am'] = Variable<String>(nameAm.value);
    }
    if (nameOm.present) {
      map['name_om'] = Variable<String>(nameOm.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalBodyPartsCompanion(')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalMusclesTable extends LocalMuscles
    with TableInfo<$LocalMusclesTable, LocalMuscle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMusclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameAmMeta = const VerificationMeta('nameAm');
  @override
  late final GeneratedColumn<String> nameAm = GeneratedColumn<String>(
    'name_am',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameOmMeta = const VerificationMeta('nameOm');
  @override
  late final GeneratedColumn<String> nameOm = GeneratedColumn<String>(
    'name_om',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    slug,
    nameEn,
    nameAm,
    nameOm,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_muscles';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalMuscle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_am')) {
      context.handle(
        _nameAmMeta,
        nameAm.isAcceptableOrUnknown(data['name_am']!, _nameAmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameAmMeta);
    }
    if (data.containsKey('name_om')) {
      context.handle(
        _nameOmMeta,
        nameOm.isAcceptableOrUnknown(data['name_om']!, _nameOmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameOmMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  LocalMuscle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMuscle(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_am'],
      )!,
      nameOm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_om'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $LocalMusclesTable createAlias(String alias) {
    return $LocalMusclesTable(attachedDatabase, alias);
  }
}

class LocalMuscle extends DataClass implements Insertable<LocalMuscle> {
  final String slug;
  final String nameEn;
  final String nameAm;
  final String nameOm;
  final int sortOrder;
  const LocalMuscle({
    required this.slug,
    required this.nameEn,
    required this.nameAm,
    required this.nameOm,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    map['name_am'] = Variable<String>(nameAm);
    map['name_om'] = Variable<String>(nameOm);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  LocalMusclesCompanion toCompanion(bool nullToAbsent) {
    return LocalMusclesCompanion(
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameAm: Value(nameAm),
      nameOm: Value(nameOm),
      sortOrder: Value(sortOrder),
    );
  }

  factory LocalMuscle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMuscle(
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAm: serializer.fromJson<String>(json['nameAm']),
      nameOm: serializer.fromJson<String>(json['nameOm']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAm': serializer.toJson<String>(nameAm),
      'nameOm': serializer.toJson<String>(nameOm),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  LocalMuscle copyWith({
    String? slug,
    String? nameEn,
    String? nameAm,
    String? nameOm,
    int? sortOrder,
  }) => LocalMuscle(
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameAm: nameAm ?? this.nameAm,
    nameOm: nameOm ?? this.nameOm,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  LocalMuscle copyWithCompanion(LocalMusclesCompanion data) {
    return LocalMuscle(
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAm: data.nameAm.present ? data.nameAm.value : this.nameAm,
      nameOm: data.nameOm.present ? data.nameOm.value : this.nameOm,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMuscle(')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, nameEn, nameAm, nameOm, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMuscle &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameAm == this.nameAm &&
          other.nameOm == this.nameOm &&
          other.sortOrder == this.sortOrder);
}

class LocalMusclesCompanion extends UpdateCompanion<LocalMuscle> {
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String> nameAm;
  final Value<String> nameOm;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const LocalMusclesCompanion({
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAm = const Value.absent(),
    this.nameOm = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalMusclesCompanion.insert({
    required String slug,
    required String nameEn,
    required String nameAm,
    required String nameOm,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug),
       nameEn = Value(nameEn),
       nameAm = Value(nameAm),
       nameOm = Value(nameOm);
  static Insertable<LocalMuscle> custom({
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameAm,
    Expression<String>? nameOm,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAm != null) 'name_am': nameAm,
      if (nameOm != null) 'name_om': nameOm,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalMusclesCompanion copyWith({
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String>? nameAm,
    Value<String>? nameOm,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return LocalMusclesCompanion(
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameAm: nameAm ?? this.nameAm,
      nameOm: nameOm ?? this.nameOm,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAm.present) {
      map['name_am'] = Variable<String>(nameAm.value);
    }
    if (nameOm.present) {
      map['name_om'] = Variable<String>(nameOm.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMusclesCompanion(')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalEquipmentsTable extends LocalEquipments
    with TableInfo<$LocalEquipmentsTable, LocalEquipment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalEquipmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameAmMeta = const VerificationMeta('nameAm');
  @override
  late final GeneratedColumn<String> nameAm = GeneratedColumn<String>(
    'name_am',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameOmMeta = const VerificationMeta('nameOm');
  @override
  late final GeneratedColumn<String> nameOm = GeneratedColumn<String>(
    'name_om',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    slug,
    nameEn,
    nameAm,
    nameOm,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_equipments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalEquipment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_am')) {
      context.handle(
        _nameAmMeta,
        nameAm.isAcceptableOrUnknown(data['name_am']!, _nameAmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameAmMeta);
    }
    if (data.containsKey('name_om')) {
      context.handle(
        _nameOmMeta,
        nameOm.isAcceptableOrUnknown(data['name_om']!, _nameOmMeta),
      );
    } else if (isInserting) {
      context.missing(_nameOmMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {slug};
  @override
  LocalEquipment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalEquipment(
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_am'],
      )!,
      nameOm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_om'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $LocalEquipmentsTable createAlias(String alias) {
    return $LocalEquipmentsTable(attachedDatabase, alias);
  }
}

class LocalEquipment extends DataClass implements Insertable<LocalEquipment> {
  final String slug;
  final String nameEn;
  final String nameAm;
  final String nameOm;
  final int sortOrder;
  const LocalEquipment({
    required this.slug,
    required this.nameEn,
    required this.nameAm,
    required this.nameOm,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    map['name_am'] = Variable<String>(nameAm);
    map['name_om'] = Variable<String>(nameOm);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  LocalEquipmentsCompanion toCompanion(bool nullToAbsent) {
    return LocalEquipmentsCompanion(
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameAm: Value(nameAm),
      nameOm: Value(nameOm),
      sortOrder: Value(sortOrder),
    );
  }

  factory LocalEquipment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalEquipment(
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAm: serializer.fromJson<String>(json['nameAm']),
      nameOm: serializer.fromJson<String>(json['nameOm']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAm': serializer.toJson<String>(nameAm),
      'nameOm': serializer.toJson<String>(nameOm),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  LocalEquipment copyWith({
    String? slug,
    String? nameEn,
    String? nameAm,
    String? nameOm,
    int? sortOrder,
  }) => LocalEquipment(
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameAm: nameAm ?? this.nameAm,
    nameOm: nameOm ?? this.nameOm,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  LocalEquipment copyWithCompanion(LocalEquipmentsCompanion data) {
    return LocalEquipment(
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAm: data.nameAm.present ? data.nameAm.value : this.nameAm,
      nameOm: data.nameOm.present ? data.nameOm.value : this.nameOm,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalEquipment(')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(slug, nameEn, nameAm, nameOm, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalEquipment &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameAm == this.nameAm &&
          other.nameOm == this.nameOm &&
          other.sortOrder == this.sortOrder);
}

class LocalEquipmentsCompanion extends UpdateCompanion<LocalEquipment> {
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String> nameAm;
  final Value<String> nameOm;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const LocalEquipmentsCompanion({
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAm = const Value.absent(),
    this.nameOm = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalEquipmentsCompanion.insert({
    required String slug,
    required String nameEn,
    required String nameAm,
    required String nameOm,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : slug = Value(slug),
       nameEn = Value(nameEn),
       nameAm = Value(nameAm),
       nameOm = Value(nameOm);
  static Insertable<LocalEquipment> custom({
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameAm,
    Expression<String>? nameOm,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAm != null) 'name_am': nameAm,
      if (nameOm != null) 'name_om': nameOm,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalEquipmentsCompanion copyWith({
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String>? nameAm,
    Value<String>? nameOm,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return LocalEquipmentsCompanion(
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameAm: nameAm ?? this.nameAm,
      nameOm: nameOm ?? this.nameOm,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAm.present) {
      map['name_am'] = Variable<String>(nameAm.value);
    }
    if (nameOm.present) {
      map['name_om'] = Variable<String>(nameOm.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalEquipmentsCompanion(')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAm: $nameAm, ')
          ..write('nameOm: $nameOm, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalExerciseBodyPartsTable extends LocalExerciseBodyParts
    with TableInfo<$LocalExerciseBodyPartsTable, LocalExerciseBodyPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalExerciseBodyPartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyPartSlugMeta = const VerificationMeta(
    'bodyPartSlug',
  );
  @override
  late final GeneratedColumn<String> bodyPartSlug = GeneratedColumn<String>(
    'body_part_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseId, bodyPartSlug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_exercise_body_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalExerciseBodyPart> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('body_part_slug')) {
      context.handle(
        _bodyPartSlugMeta,
        bodyPartSlug.isAcceptableOrUnknown(
          data['body_part_slug']!,
          _bodyPartSlugMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bodyPartSlugMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalExerciseBodyPart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalExerciseBodyPart(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      bodyPartSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_part_slug'],
      )!,
    );
  }

  @override
  $LocalExerciseBodyPartsTable createAlias(String alias) {
    return $LocalExerciseBodyPartsTable(attachedDatabase, alias);
  }
}

class LocalExerciseBodyPart extends DataClass
    implements Insertable<LocalExerciseBodyPart> {
  final int id;
  final String exerciseId;
  final String bodyPartSlug;
  const LocalExerciseBodyPart({
    required this.id,
    required this.exerciseId,
    required this.bodyPartSlug,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['body_part_slug'] = Variable<String>(bodyPartSlug);
    return map;
  }

  LocalExerciseBodyPartsCompanion toCompanion(bool nullToAbsent) {
    return LocalExerciseBodyPartsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      bodyPartSlug: Value(bodyPartSlug),
    );
  }

  factory LocalExerciseBodyPart.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalExerciseBodyPart(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      bodyPartSlug: serializer.fromJson<String>(json['bodyPartSlug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'bodyPartSlug': serializer.toJson<String>(bodyPartSlug),
    };
  }

  LocalExerciseBodyPart copyWith({
    int? id,
    String? exerciseId,
    String? bodyPartSlug,
  }) => LocalExerciseBodyPart(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    bodyPartSlug: bodyPartSlug ?? this.bodyPartSlug,
  );
  LocalExerciseBodyPart copyWithCompanion(
    LocalExerciseBodyPartsCompanion data,
  ) {
    return LocalExerciseBodyPart(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      bodyPartSlug: data.bodyPartSlug.present
          ? data.bodyPartSlug.value
          : this.bodyPartSlug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalExerciseBodyPart(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('bodyPartSlug: $bodyPartSlug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, bodyPartSlug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalExerciseBodyPart &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.bodyPartSlug == this.bodyPartSlug);
}

class LocalExerciseBodyPartsCompanion
    extends UpdateCompanion<LocalExerciseBodyPart> {
  final Value<int> id;
  final Value<String> exerciseId;
  final Value<String> bodyPartSlug;
  const LocalExerciseBodyPartsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.bodyPartSlug = const Value.absent(),
  });
  LocalExerciseBodyPartsCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseId,
    required String bodyPartSlug,
  }) : exerciseId = Value(exerciseId),
       bodyPartSlug = Value(bodyPartSlug);
  static Insertable<LocalExerciseBodyPart> custom({
    Expression<int>? id,
    Expression<String>? exerciseId,
    Expression<String>? bodyPartSlug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (bodyPartSlug != null) 'body_part_slug': bodyPartSlug,
    });
  }

  LocalExerciseBodyPartsCompanion copyWith({
    Value<int>? id,
    Value<String>? exerciseId,
    Value<String>? bodyPartSlug,
  }) {
    return LocalExerciseBodyPartsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      bodyPartSlug: bodyPartSlug ?? this.bodyPartSlug,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (bodyPartSlug.present) {
      map['body_part_slug'] = Variable<String>(bodyPartSlug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalExerciseBodyPartsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('bodyPartSlug: $bodyPartSlug')
          ..write(')'))
        .toString();
  }
}

class $LocalExerciseMusclesTable extends LocalExerciseMuscles
    with TableInfo<$LocalExerciseMusclesTable, LocalExerciseMuscle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalExerciseMusclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _muscleSlugMeta = const VerificationMeta(
    'muscleSlug',
  );
  @override
  late final GeneratedColumn<String> muscleSlug = GeneratedColumn<String>(
    'muscle_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseId, muscleSlug, role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_exercise_muscles';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalExerciseMuscle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('muscle_slug')) {
      context.handle(
        _muscleSlugMeta,
        muscleSlug.isAcceptableOrUnknown(data['muscle_slug']!, _muscleSlugMeta),
      );
    } else if (isInserting) {
      context.missing(_muscleSlugMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalExerciseMuscle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalExerciseMuscle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      muscleSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_slug'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
    );
  }

  @override
  $LocalExerciseMusclesTable createAlias(String alias) {
    return $LocalExerciseMusclesTable(attachedDatabase, alias);
  }
}

class LocalExerciseMuscle extends DataClass
    implements Insertable<LocalExerciseMuscle> {
  final int id;
  final String exerciseId;
  final String muscleSlug;
  final String role;
  const LocalExerciseMuscle({
    required this.id,
    required this.exerciseId,
    required this.muscleSlug,
    required this.role,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['muscle_slug'] = Variable<String>(muscleSlug);
    map['role'] = Variable<String>(role);
    return map;
  }

  LocalExerciseMusclesCompanion toCompanion(bool nullToAbsent) {
    return LocalExerciseMusclesCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      muscleSlug: Value(muscleSlug),
      role: Value(role),
    );
  }

  factory LocalExerciseMuscle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalExerciseMuscle(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      muscleSlug: serializer.fromJson<String>(json['muscleSlug']),
      role: serializer.fromJson<String>(json['role']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'muscleSlug': serializer.toJson<String>(muscleSlug),
      'role': serializer.toJson<String>(role),
    };
  }

  LocalExerciseMuscle copyWith({
    int? id,
    String? exerciseId,
    String? muscleSlug,
    String? role,
  }) => LocalExerciseMuscle(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    muscleSlug: muscleSlug ?? this.muscleSlug,
    role: role ?? this.role,
  );
  LocalExerciseMuscle copyWithCompanion(LocalExerciseMusclesCompanion data) {
    return LocalExerciseMuscle(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      muscleSlug: data.muscleSlug.present
          ? data.muscleSlug.value
          : this.muscleSlug,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalExerciseMuscle(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleSlug: $muscleSlug, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, muscleSlug, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalExerciseMuscle &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.muscleSlug == this.muscleSlug &&
          other.role == this.role);
}

class LocalExerciseMusclesCompanion
    extends UpdateCompanion<LocalExerciseMuscle> {
  final Value<int> id;
  final Value<String> exerciseId;
  final Value<String> muscleSlug;
  final Value<String> role;
  const LocalExerciseMusclesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.muscleSlug = const Value.absent(),
    this.role = const Value.absent(),
  });
  LocalExerciseMusclesCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseId,
    required String muscleSlug,
    required String role,
  }) : exerciseId = Value(exerciseId),
       muscleSlug = Value(muscleSlug),
       role = Value(role);
  static Insertable<LocalExerciseMuscle> custom({
    Expression<int>? id,
    Expression<String>? exerciseId,
    Expression<String>? muscleSlug,
    Expression<String>? role,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (muscleSlug != null) 'muscle_slug': muscleSlug,
      if (role != null) 'role': role,
    });
  }

  LocalExerciseMusclesCompanion copyWith({
    Value<int>? id,
    Value<String>? exerciseId,
    Value<String>? muscleSlug,
    Value<String>? role,
  }) {
    return LocalExerciseMusclesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      muscleSlug: muscleSlug ?? this.muscleSlug,
      role: role ?? this.role,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (muscleSlug.present) {
      map['muscle_slug'] = Variable<String>(muscleSlug.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalExerciseMusclesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('muscleSlug: $muscleSlug, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }
}

class $LocalExerciseEquipmentsTable extends LocalExerciseEquipments
    with TableInfo<$LocalExerciseEquipmentsTable, LocalExerciseEquipment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalExerciseEquipmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentSlugMeta = const VerificationMeta(
    'equipmentSlug',
  );
  @override
  late final GeneratedColumn<String> equipmentSlug = GeneratedColumn<String>(
    'equipment_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, exerciseId, equipmentSlug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_exercise_equipments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalExerciseEquipment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('equipment_slug')) {
      context.handle(
        _equipmentSlugMeta,
        equipmentSlug.isAcceptableOrUnknown(
          data['equipment_slug']!,
          _equipmentSlugMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentSlugMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalExerciseEquipment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalExerciseEquipment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      equipmentSlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_slug'],
      )!,
    );
  }

  @override
  $LocalExerciseEquipmentsTable createAlias(String alias) {
    return $LocalExerciseEquipmentsTable(attachedDatabase, alias);
  }
}

class LocalExerciseEquipment extends DataClass
    implements Insertable<LocalExerciseEquipment> {
  final int id;
  final String exerciseId;
  final String equipmentSlug;
  const LocalExerciseEquipment({
    required this.id,
    required this.exerciseId,
    required this.equipmentSlug,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['equipment_slug'] = Variable<String>(equipmentSlug);
    return map;
  }

  LocalExerciseEquipmentsCompanion toCompanion(bool nullToAbsent) {
    return LocalExerciseEquipmentsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      equipmentSlug: Value(equipmentSlug),
    );
  }

  factory LocalExerciseEquipment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalExerciseEquipment(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      equipmentSlug: serializer.fromJson<String>(json['equipmentSlug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'equipmentSlug': serializer.toJson<String>(equipmentSlug),
    };
  }

  LocalExerciseEquipment copyWith({
    int? id,
    String? exerciseId,
    String? equipmentSlug,
  }) => LocalExerciseEquipment(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    equipmentSlug: equipmentSlug ?? this.equipmentSlug,
  );
  LocalExerciseEquipment copyWithCompanion(
    LocalExerciseEquipmentsCompanion data,
  ) {
    return LocalExerciseEquipment(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      equipmentSlug: data.equipmentSlug.present
          ? data.equipmentSlug.value
          : this.equipmentSlug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalExerciseEquipment(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('equipmentSlug: $equipmentSlug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, equipmentSlug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalExerciseEquipment &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.equipmentSlug == this.equipmentSlug);
}

class LocalExerciseEquipmentsCompanion
    extends UpdateCompanion<LocalExerciseEquipment> {
  final Value<int> id;
  final Value<String> exerciseId;
  final Value<String> equipmentSlug;
  const LocalExerciseEquipmentsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.equipmentSlug = const Value.absent(),
  });
  LocalExerciseEquipmentsCompanion.insert({
    this.id = const Value.absent(),
    required String exerciseId,
    required String equipmentSlug,
  }) : exerciseId = Value(exerciseId),
       equipmentSlug = Value(equipmentSlug);
  static Insertable<LocalExerciseEquipment> custom({
    Expression<int>? id,
    Expression<String>? exerciseId,
    Expression<String>? equipmentSlug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (equipmentSlug != null) 'equipment_slug': equipmentSlug,
    });
  }

  LocalExerciseEquipmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? exerciseId,
    Value<String>? equipmentSlug,
  }) {
    return LocalExerciseEquipmentsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      equipmentSlug: equipmentSlug ?? this.equipmentSlug,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (equipmentSlug.present) {
      map['equipment_slug'] = Variable<String>(equipmentSlug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalExerciseEquipmentsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('equipmentSlug: $equipmentSlug')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<String> lastSyncedAt = GeneratedColumn<String>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, lastSyncedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaData extends DataClass implements Insertable<SyncMetaData> {
  final int id;
  final String? lastSyncedAt;
  const SyncMetaData({required this.id, this.lastSyncedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt);
    }
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(
      id: Value(id),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory SyncMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaData(
      id: serializer.fromJson<int>(json['id']),
      lastSyncedAt: serializer.fromJson<String?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastSyncedAt': serializer.toJson<String?>(lastSyncedAt),
    };
  }

  SyncMetaData copyWith({
    int? id,
    Value<String?> lastSyncedAt = const Value.absent(),
  }) => SyncMetaData(
    id: id ?? this.id,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  SyncMetaData copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaData(
      id: data.id.present ? data.id.value : this.id,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaData(')
          ..write('id: $id, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastSyncedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaData &&
          other.id == this.id &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaData> {
  final Value<int> id;
  final Value<String?> lastSyncedAt;
  const SyncMetaCompanion({
    this.id = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    this.id = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  });
  static Insertable<SyncMetaData> custom({
    Expression<int>? id,
    Expression<String>? lastSyncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
    });
  }

  SyncMetaCompanion copyWith({Value<int>? id, Value<String?>? lastSyncedAt}) {
    return SyncMetaCompanion(
      id: id ?? this.id,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<String>(lastSyncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('id: $id, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$ExerciseDatabase extends GeneratedDatabase {
  _$ExerciseDatabase(QueryExecutor e) : super(e);
  $ExerciseDatabaseManager get managers => $ExerciseDatabaseManager(this);
  late final $LocalExercisesTable localExercises = $LocalExercisesTable(this);
  late final $LocalBodyPartsTable localBodyParts = $LocalBodyPartsTable(this);
  late final $LocalMusclesTable localMuscles = $LocalMusclesTable(this);
  late final $LocalEquipmentsTable localEquipments = $LocalEquipmentsTable(
    this,
  );
  late final $LocalExerciseBodyPartsTable localExerciseBodyParts =
      $LocalExerciseBodyPartsTable(this);
  late final $LocalExerciseMusclesTable localExerciseMuscles =
      $LocalExerciseMusclesTable(this);
  late final $LocalExerciseEquipmentsTable localExerciseEquipments =
      $LocalExerciseEquipmentsTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localExercises,
    localBodyParts,
    localMuscles,
    localEquipments,
    localExerciseBodyParts,
    localExerciseMuscles,
    localExerciseEquipments,
    syncMeta,
  ];
}

typedef $$LocalExercisesTableCreateCompanionBuilder =
    LocalExercisesCompanion Function({
      required String id,
      Value<String> externalId,
      required String slug,
      required String nameEn,
      required String nameAm,
      required String nameOm,
      Value<String?> instructionsEn,
      Value<String?> instructionsAm,
      Value<String?> instructionsOm,
      Value<String?> gifUrl,
      Value<String?> gifLocalPath,
      Value<String?> gifLocalUrl,
      required String type,
      required String difficulty,
      required String status,
      Value<String?> publishedAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$LocalExercisesTableUpdateCompanionBuilder =
    LocalExercisesCompanion Function({
      Value<String> id,
      Value<String> externalId,
      Value<String> slug,
      Value<String> nameEn,
      Value<String> nameAm,
      Value<String> nameOm,
      Value<String?> instructionsEn,
      Value<String?> instructionsAm,
      Value<String?> instructionsOm,
      Value<String?> gifUrl,
      Value<String?> gifLocalPath,
      Value<String?> gifLocalUrl,
      Value<String> type,
      Value<String> difficulty,
      Value<String> status,
      Value<String?> publishedAt,
      Value<String> updatedAt,
      Value<int> rowid,
    });

class $$LocalExercisesTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalExercisesTable> {
  $$LocalExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructionsEn => $composableBuilder(
    column: $table.instructionsEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructionsAm => $composableBuilder(
    column: $table.instructionsAm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructionsOm => $composableBuilder(
    column: $table.instructionsOm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gifUrl => $composableBuilder(
    column: $table.gifUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gifLocalPath => $composableBuilder(
    column: $table.gifLocalPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gifLocalUrl => $composableBuilder(
    column: $table.gifLocalUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalExercisesTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalExercisesTable> {
  $$LocalExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructionsEn => $composableBuilder(
    column: $table.instructionsEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructionsAm => $composableBuilder(
    column: $table.instructionsAm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructionsOm => $composableBuilder(
    column: $table.instructionsOm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gifUrl => $composableBuilder(
    column: $table.gifUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gifLocalPath => $composableBuilder(
    column: $table.gifLocalPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gifLocalUrl => $composableBuilder(
    column: $table.gifLocalUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalExercisesTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalExercisesTable> {
  $$LocalExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAm =>
      $composableBuilder(column: $table.nameAm, builder: (column) => column);

  GeneratedColumn<String> get nameOm =>
      $composableBuilder(column: $table.nameOm, builder: (column) => column);

  GeneratedColumn<String> get instructionsEn => $composableBuilder(
    column: $table.instructionsEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructionsAm => $composableBuilder(
    column: $table.instructionsAm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructionsOm => $composableBuilder(
    column: $table.instructionsOm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gifUrl =>
      $composableBuilder(column: $table.gifUrl, builder: (column) => column);

  GeneratedColumn<String> get gifLocalPath => $composableBuilder(
    column: $table.gifLocalPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gifLocalUrl => $composableBuilder(
    column: $table.gifLocalUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get publishedAt => $composableBuilder(
    column: $table.publishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalExercisesTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalExercisesTable,
          LocalExercise,
          $$LocalExercisesTableFilterComposer,
          $$LocalExercisesTableOrderingComposer,
          $$LocalExercisesTableAnnotationComposer,
          $$LocalExercisesTableCreateCompanionBuilder,
          $$LocalExercisesTableUpdateCompanionBuilder,
          (
            LocalExercise,
            BaseReferences<
              _$ExerciseDatabase,
              $LocalExercisesTable,
              LocalExercise
            >,
          ),
          LocalExercise,
          PrefetchHooks Function()
        > {
  $$LocalExercisesTableTableManager(
    _$ExerciseDatabase db,
    $LocalExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> externalId = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAm = const Value.absent(),
                Value<String> nameOm = const Value.absent(),
                Value<String?> instructionsEn = const Value.absent(),
                Value<String?> instructionsAm = const Value.absent(),
                Value<String?> instructionsOm = const Value.absent(),
                Value<String?> gifUrl = const Value.absent(),
                Value<String?> gifLocalPath = const Value.absent(),
                Value<String?> gifLocalUrl = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> publishedAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalExercisesCompanion(
                id: id,
                externalId: externalId,
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                instructionsEn: instructionsEn,
                instructionsAm: instructionsAm,
                instructionsOm: instructionsOm,
                gifUrl: gifUrl,
                gifLocalPath: gifLocalPath,
                gifLocalUrl: gifLocalUrl,
                type: type,
                difficulty: difficulty,
                status: status,
                publishedAt: publishedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> externalId = const Value.absent(),
                required String slug,
                required String nameEn,
                required String nameAm,
                required String nameOm,
                Value<String?> instructionsEn = const Value.absent(),
                Value<String?> instructionsAm = const Value.absent(),
                Value<String?> instructionsOm = const Value.absent(),
                Value<String?> gifUrl = const Value.absent(),
                Value<String?> gifLocalPath = const Value.absent(),
                Value<String?> gifLocalUrl = const Value.absent(),
                required String type,
                required String difficulty,
                required String status,
                Value<String?> publishedAt = const Value.absent(),
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LocalExercisesCompanion.insert(
                id: id,
                externalId: externalId,
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                instructionsEn: instructionsEn,
                instructionsAm: instructionsAm,
                instructionsOm: instructionsOm,
                gifUrl: gifUrl,
                gifLocalPath: gifLocalPath,
                gifLocalUrl: gifLocalUrl,
                type: type,
                difficulty: difficulty,
                status: status,
                publishedAt: publishedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalExercisesTable, LocalExercise>(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalExercisesTable,
                    LocalExercise
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalExercisesTable,
      LocalExercise,
      $$LocalExercisesTableFilterComposer,
      $$LocalExercisesTableOrderingComposer,
      $$LocalExercisesTableAnnotationComposer,
      $$LocalExercisesTableCreateCompanionBuilder,
      $$LocalExercisesTableUpdateCompanionBuilder,
      (
        LocalExercise,
        BaseReferences<_$ExerciseDatabase, $LocalExercisesTable, LocalExercise>,
      ),
      LocalExercise,
      PrefetchHooks Function()
    >;
typedef $$LocalBodyPartsTableCreateCompanionBuilder =
    LocalBodyPartsCompanion Function({
      required String slug,
      required String nameEn,
      required String nameAm,
      required String nameOm,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$LocalBodyPartsTableUpdateCompanionBuilder =
    LocalBodyPartsCompanion Function({
      Value<String> slug,
      Value<String> nameEn,
      Value<String> nameAm,
      Value<String> nameOm,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$LocalBodyPartsTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalBodyPartsTable> {
  $$LocalBodyPartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalBodyPartsTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalBodyPartsTable> {
  $$LocalBodyPartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalBodyPartsTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalBodyPartsTable> {
  $$LocalBodyPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAm =>
      $composableBuilder(column: $table.nameAm, builder: (column) => column);

  GeneratedColumn<String> get nameOm =>
      $composableBuilder(column: $table.nameOm, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$LocalBodyPartsTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalBodyPartsTable,
          LocalBodyPart,
          $$LocalBodyPartsTableFilterComposer,
          $$LocalBodyPartsTableOrderingComposer,
          $$LocalBodyPartsTableAnnotationComposer,
          $$LocalBodyPartsTableCreateCompanionBuilder,
          $$LocalBodyPartsTableUpdateCompanionBuilder,
          (
            LocalBodyPart,
            BaseReferences<
              _$ExerciseDatabase,
              $LocalBodyPartsTable,
              LocalBodyPart
            >,
          ),
          LocalBodyPart,
          PrefetchHooks Function()
        > {
  $$LocalBodyPartsTableTableManager(
    _$ExerciseDatabase db,
    $LocalBodyPartsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalBodyPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalBodyPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalBodyPartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAm = const Value.absent(),
                Value<String> nameOm = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalBodyPartsCompanion(
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                required String nameEn,
                required String nameAm,
                required String nameOm,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalBodyPartsCompanion.insert(
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalBodyPartsTable, LocalBodyPart>(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalBodyPartsTable,
                    LocalBodyPart
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalBodyPartsTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalBodyPartsTable,
      LocalBodyPart,
      $$LocalBodyPartsTableFilterComposer,
      $$LocalBodyPartsTableOrderingComposer,
      $$LocalBodyPartsTableAnnotationComposer,
      $$LocalBodyPartsTableCreateCompanionBuilder,
      $$LocalBodyPartsTableUpdateCompanionBuilder,
      (
        LocalBodyPart,
        BaseReferences<_$ExerciseDatabase, $LocalBodyPartsTable, LocalBodyPart>,
      ),
      LocalBodyPart,
      PrefetchHooks Function()
    >;
typedef $$LocalMusclesTableCreateCompanionBuilder =
    LocalMusclesCompanion Function({
      required String slug,
      required String nameEn,
      required String nameAm,
      required String nameOm,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$LocalMusclesTableUpdateCompanionBuilder =
    LocalMusclesCompanion Function({
      Value<String> slug,
      Value<String> nameEn,
      Value<String> nameAm,
      Value<String> nameOm,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$LocalMusclesTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalMusclesTable> {
  $$LocalMusclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalMusclesTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalMusclesTable> {
  $$LocalMusclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalMusclesTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalMusclesTable> {
  $$LocalMusclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAm =>
      $composableBuilder(column: $table.nameAm, builder: (column) => column);

  GeneratedColumn<String> get nameOm =>
      $composableBuilder(column: $table.nameOm, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$LocalMusclesTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalMusclesTable,
          LocalMuscle,
          $$LocalMusclesTableFilterComposer,
          $$LocalMusclesTableOrderingComposer,
          $$LocalMusclesTableAnnotationComposer,
          $$LocalMusclesTableCreateCompanionBuilder,
          $$LocalMusclesTableUpdateCompanionBuilder,
          (
            LocalMuscle,
            BaseReferences<_$ExerciseDatabase, $LocalMusclesTable, LocalMuscle>,
          ),
          LocalMuscle,
          PrefetchHooks Function()
        > {
  $$LocalMusclesTableTableManager(
    _$ExerciseDatabase db,
    $LocalMusclesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMusclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMusclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalMusclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAm = const Value.absent(),
                Value<String> nameOm = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalMusclesCompanion(
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                required String nameEn,
                required String nameAm,
                required String nameOm,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalMusclesCompanion.insert(
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalMusclesTable, LocalMuscle>(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalMusclesTable,
                    LocalMuscle
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalMusclesTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalMusclesTable,
      LocalMuscle,
      $$LocalMusclesTableFilterComposer,
      $$LocalMusclesTableOrderingComposer,
      $$LocalMusclesTableAnnotationComposer,
      $$LocalMusclesTableCreateCompanionBuilder,
      $$LocalMusclesTableUpdateCompanionBuilder,
      (
        LocalMuscle,
        BaseReferences<_$ExerciseDatabase, $LocalMusclesTable, LocalMuscle>,
      ),
      LocalMuscle,
      PrefetchHooks Function()
    >;
typedef $$LocalEquipmentsTableCreateCompanionBuilder =
    LocalEquipmentsCompanion Function({
      required String slug,
      required String nameEn,
      required String nameAm,
      required String nameOm,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$LocalEquipmentsTableUpdateCompanionBuilder =
    LocalEquipmentsCompanion Function({
      Value<String> slug,
      Value<String> nameEn,
      Value<String> nameAm,
      Value<String> nameOm,
      Value<int> sortOrder,
      Value<int> rowid,
    });

class $$LocalEquipmentsTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalEquipmentsTable> {
  $$LocalEquipmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalEquipmentsTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalEquipmentsTable> {
  $$LocalEquipmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAm => $composableBuilder(
    column: $table.nameAm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameOm => $composableBuilder(
    column: $table.nameOm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalEquipmentsTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalEquipmentsTable> {
  $$LocalEquipmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAm =>
      $composableBuilder(column: $table.nameAm, builder: (column) => column);

  GeneratedColumn<String> get nameOm =>
      $composableBuilder(column: $table.nameOm, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$LocalEquipmentsTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalEquipmentsTable,
          LocalEquipment,
          $$LocalEquipmentsTableFilterComposer,
          $$LocalEquipmentsTableOrderingComposer,
          $$LocalEquipmentsTableAnnotationComposer,
          $$LocalEquipmentsTableCreateCompanionBuilder,
          $$LocalEquipmentsTableUpdateCompanionBuilder,
          (
            LocalEquipment,
            BaseReferences<
              _$ExerciseDatabase,
              $LocalEquipmentsTable,
              LocalEquipment
            >,
          ),
          LocalEquipment,
          PrefetchHooks Function()
        > {
  $$LocalEquipmentsTableTableManager(
    _$ExerciseDatabase db,
    $LocalEquipmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalEquipmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalEquipmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalEquipmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAm = const Value.absent(),
                Value<String> nameOm = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalEquipmentsCompanion(
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String slug,
                required String nameEn,
                required String nameAm,
                required String nameOm,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalEquipmentsCompanion.insert(
                slug: slug,
                nameEn: nameEn,
                nameAm: nameAm,
                nameOm: nameOm,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalEquipmentsTable, LocalEquipment>(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalEquipmentsTable,
                    LocalEquipment
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalEquipmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalEquipmentsTable,
      LocalEquipment,
      $$LocalEquipmentsTableFilterComposer,
      $$LocalEquipmentsTableOrderingComposer,
      $$LocalEquipmentsTableAnnotationComposer,
      $$LocalEquipmentsTableCreateCompanionBuilder,
      $$LocalEquipmentsTableUpdateCompanionBuilder,
      (
        LocalEquipment,
        BaseReferences<
          _$ExerciseDatabase,
          $LocalEquipmentsTable,
          LocalEquipment
        >,
      ),
      LocalEquipment,
      PrefetchHooks Function()
    >;
typedef $$LocalExerciseBodyPartsTableCreateCompanionBuilder =
    LocalExerciseBodyPartsCompanion Function({
      Value<int> id,
      required String exerciseId,
      required String bodyPartSlug,
    });
typedef $$LocalExerciseBodyPartsTableUpdateCompanionBuilder =
    LocalExerciseBodyPartsCompanion Function({
      Value<int> id,
      Value<String> exerciseId,
      Value<String> bodyPartSlug,
    });

class $$LocalExerciseBodyPartsTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseBodyPartsTable> {
  $$LocalExerciseBodyPartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyPartSlug => $composableBuilder(
    column: $table.bodyPartSlug,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalExerciseBodyPartsTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseBodyPartsTable> {
  $$LocalExerciseBodyPartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyPartSlug => $composableBuilder(
    column: $table.bodyPartSlug,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalExerciseBodyPartsTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseBodyPartsTable> {
  $$LocalExerciseBodyPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyPartSlug => $composableBuilder(
    column: $table.bodyPartSlug,
    builder: (column) => column,
  );
}

class $$LocalExerciseBodyPartsTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalExerciseBodyPartsTable,
          LocalExerciseBodyPart,
          $$LocalExerciseBodyPartsTableFilterComposer,
          $$LocalExerciseBodyPartsTableOrderingComposer,
          $$LocalExerciseBodyPartsTableAnnotationComposer,
          $$LocalExerciseBodyPartsTableCreateCompanionBuilder,
          $$LocalExerciseBodyPartsTableUpdateCompanionBuilder,
          (
            LocalExerciseBodyPart,
            BaseReferences<
              _$ExerciseDatabase,
              $LocalExerciseBodyPartsTable,
              LocalExerciseBodyPart
            >,
          ),
          LocalExerciseBodyPart,
          PrefetchHooks Function()
        > {
  $$LocalExerciseBodyPartsTableTableManager(
    _$ExerciseDatabase db,
    $LocalExerciseBodyPartsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalExerciseBodyPartsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalExerciseBodyPartsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalExerciseBodyPartsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> bodyPartSlug = const Value.absent(),
              }) => LocalExerciseBodyPartsCompanion(
                id: id,
                exerciseId: exerciseId,
                bodyPartSlug: bodyPartSlug,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String exerciseId,
                required String bodyPartSlug,
              }) => LocalExerciseBodyPartsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                bodyPartSlug: bodyPartSlug,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $LocalExerciseBodyPartsTable,
                    LocalExerciseBodyPart
                  >(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalExerciseBodyPartsTable,
                    LocalExerciseBodyPart
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalExerciseBodyPartsTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalExerciseBodyPartsTable,
      LocalExerciseBodyPart,
      $$LocalExerciseBodyPartsTableFilterComposer,
      $$LocalExerciseBodyPartsTableOrderingComposer,
      $$LocalExerciseBodyPartsTableAnnotationComposer,
      $$LocalExerciseBodyPartsTableCreateCompanionBuilder,
      $$LocalExerciseBodyPartsTableUpdateCompanionBuilder,
      (
        LocalExerciseBodyPart,
        BaseReferences<
          _$ExerciseDatabase,
          $LocalExerciseBodyPartsTable,
          LocalExerciseBodyPart
        >,
      ),
      LocalExerciseBodyPart,
      PrefetchHooks Function()
    >;
typedef $$LocalExerciseMusclesTableCreateCompanionBuilder =
    LocalExerciseMusclesCompanion Function({
      Value<int> id,
      required String exerciseId,
      required String muscleSlug,
      required String role,
    });
typedef $$LocalExerciseMusclesTableUpdateCompanionBuilder =
    LocalExerciseMusclesCompanion Function({
      Value<int> id,
      Value<String> exerciseId,
      Value<String> muscleSlug,
      Value<String> role,
    });

class $$LocalExerciseMusclesTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseMusclesTable> {
  $$LocalExerciseMusclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get muscleSlug => $composableBuilder(
    column: $table.muscleSlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalExerciseMusclesTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseMusclesTable> {
  $$LocalExerciseMusclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleSlug => $composableBuilder(
    column: $table.muscleSlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalExerciseMusclesTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseMusclesTable> {
  $$LocalExerciseMusclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get muscleSlug => $composableBuilder(
    column: $table.muscleSlug,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);
}

class $$LocalExerciseMusclesTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalExerciseMusclesTable,
          LocalExerciseMuscle,
          $$LocalExerciseMusclesTableFilterComposer,
          $$LocalExerciseMusclesTableOrderingComposer,
          $$LocalExerciseMusclesTableAnnotationComposer,
          $$LocalExerciseMusclesTableCreateCompanionBuilder,
          $$LocalExerciseMusclesTableUpdateCompanionBuilder,
          (
            LocalExerciseMuscle,
            BaseReferences<
              _$ExerciseDatabase,
              $LocalExerciseMusclesTable,
              LocalExerciseMuscle
            >,
          ),
          LocalExerciseMuscle,
          PrefetchHooks Function()
        > {
  $$LocalExerciseMusclesTableTableManager(
    _$ExerciseDatabase db,
    $LocalExerciseMusclesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalExerciseMusclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalExerciseMusclesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalExerciseMusclesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> muscleSlug = const Value.absent(),
                Value<String> role = const Value.absent(),
              }) => LocalExerciseMusclesCompanion(
                id: id,
                exerciseId: exerciseId,
                muscleSlug: muscleSlug,
                role: role,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String exerciseId,
                required String muscleSlug,
                required String role,
              }) => LocalExerciseMusclesCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                muscleSlug: muscleSlug,
                role: role,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalExerciseMusclesTable, LocalExerciseMuscle>(
                    table,
                  ),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalExerciseMusclesTable,
                    LocalExerciseMuscle
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalExerciseMusclesTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalExerciseMusclesTable,
      LocalExerciseMuscle,
      $$LocalExerciseMusclesTableFilterComposer,
      $$LocalExerciseMusclesTableOrderingComposer,
      $$LocalExerciseMusclesTableAnnotationComposer,
      $$LocalExerciseMusclesTableCreateCompanionBuilder,
      $$LocalExerciseMusclesTableUpdateCompanionBuilder,
      (
        LocalExerciseMuscle,
        BaseReferences<
          _$ExerciseDatabase,
          $LocalExerciseMusclesTable,
          LocalExerciseMuscle
        >,
      ),
      LocalExerciseMuscle,
      PrefetchHooks Function()
    >;
typedef $$LocalExerciseEquipmentsTableCreateCompanionBuilder =
    LocalExerciseEquipmentsCompanion Function({
      Value<int> id,
      required String exerciseId,
      required String equipmentSlug,
    });
typedef $$LocalExerciseEquipmentsTableUpdateCompanionBuilder =
    LocalExerciseEquipmentsCompanion Function({
      Value<int> id,
      Value<String> exerciseId,
      Value<String> equipmentSlug,
    });

class $$LocalExerciseEquipmentsTableFilterComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseEquipmentsTable> {
  $$LocalExerciseEquipmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentSlug => $composableBuilder(
    column: $table.equipmentSlug,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocalExerciseEquipmentsTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseEquipmentsTable> {
  $$LocalExerciseEquipmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentSlug => $composableBuilder(
    column: $table.equipmentSlug,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalExerciseEquipmentsTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $LocalExerciseEquipmentsTable> {
  $$LocalExerciseEquipmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipmentSlug => $composableBuilder(
    column: $table.equipmentSlug,
    builder: (column) => column,
  );
}

class $$LocalExerciseEquipmentsTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $LocalExerciseEquipmentsTable,
          LocalExerciseEquipment,
          $$LocalExerciseEquipmentsTableFilterComposer,
          $$LocalExerciseEquipmentsTableOrderingComposer,
          $$LocalExerciseEquipmentsTableAnnotationComposer,
          $$LocalExerciseEquipmentsTableCreateCompanionBuilder,
          $$LocalExerciseEquipmentsTableUpdateCompanionBuilder,
          (
            LocalExerciseEquipment,
            BaseReferences<
              _$ExerciseDatabase,
              $LocalExerciseEquipmentsTable,
              LocalExerciseEquipment
            >,
          ),
          LocalExerciseEquipment,
          PrefetchHooks Function()
        > {
  $$LocalExerciseEquipmentsTableTableManager(
    _$ExerciseDatabase db,
    $LocalExerciseEquipmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalExerciseEquipmentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalExerciseEquipmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalExerciseEquipmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> equipmentSlug = const Value.absent(),
              }) => LocalExerciseEquipmentsCompanion(
                id: id,
                exerciseId: exerciseId,
                equipmentSlug: equipmentSlug,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String exerciseId,
                required String equipmentSlug,
              }) => LocalExerciseEquipmentsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                equipmentSlug: equipmentSlug,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $LocalExerciseEquipmentsTable,
                    LocalExerciseEquipment
                  >(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $LocalExerciseEquipmentsTable,
                    LocalExerciseEquipment
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocalExerciseEquipmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $LocalExerciseEquipmentsTable,
      LocalExerciseEquipment,
      $$LocalExerciseEquipmentsTableFilterComposer,
      $$LocalExerciseEquipmentsTableOrderingComposer,
      $$LocalExerciseEquipmentsTableAnnotationComposer,
      $$LocalExerciseEquipmentsTableCreateCompanionBuilder,
      $$LocalExerciseEquipmentsTableUpdateCompanionBuilder,
      (
        LocalExerciseEquipment,
        BaseReferences<
          _$ExerciseDatabase,
          $LocalExerciseEquipmentsTable,
          LocalExerciseEquipment
        >,
      ),
      LocalExerciseEquipment,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder =
    SyncMetaCompanion Function({Value<int> id, Value<String?> lastSyncedAt});
typedef $$SyncMetaTableUpdateCompanionBuilder =
    SyncMetaCompanion Function({Value<int> id, Value<String?> lastSyncedAt});

class $$SyncMetaTableFilterComposer
    extends Composer<_$ExerciseDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$ExerciseDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$ExerciseDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$ExerciseDatabase,
          $SyncMetaTable,
          SyncMetaData,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaData,
            BaseReferences<_$ExerciseDatabase, $SyncMetaTable, SyncMetaData>,
          ),
          SyncMetaData,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$ExerciseDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
              }) => SyncMetaCompanion(id: id, lastSyncedAt: lastSyncedAt),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> lastSyncedAt = const Value.absent(),
              }) =>
                  SyncMetaCompanion.insert(id: id, lastSyncedAt: lastSyncedAt),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SyncMetaTable, SyncMetaData>(table),
                  BaseReferences<
                    _$ExerciseDatabase,
                    $SyncMetaTable,
                    SyncMetaData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$ExerciseDatabase,
      $SyncMetaTable,
      SyncMetaData,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (
        SyncMetaData,
        BaseReferences<_$ExerciseDatabase, $SyncMetaTable, SyncMetaData>,
      ),
      SyncMetaData,
      PrefetchHooks Function()
    >;

class $ExerciseDatabaseManager {
  final _$ExerciseDatabase _db;
  $ExerciseDatabaseManager(this._db);
  $$LocalExercisesTableTableManager get localExercises =>
      $$LocalExercisesTableTableManager(_db, _db.localExercises);
  $$LocalBodyPartsTableTableManager get localBodyParts =>
      $$LocalBodyPartsTableTableManager(_db, _db.localBodyParts);
  $$LocalMusclesTableTableManager get localMuscles =>
      $$LocalMusclesTableTableManager(_db, _db.localMuscles);
  $$LocalEquipmentsTableTableManager get localEquipments =>
      $$LocalEquipmentsTableTableManager(_db, _db.localEquipments);
  $$LocalExerciseBodyPartsTableTableManager get localExerciseBodyParts =>
      $$LocalExerciseBodyPartsTableTableManager(
        _db,
        _db.localExerciseBodyParts,
      );
  $$LocalExerciseMusclesTableTableManager get localExerciseMuscles =>
      $$LocalExerciseMusclesTableTableManager(_db, _db.localExerciseMuscles);
  $$LocalExerciseEquipmentsTableTableManager get localExerciseEquipments =>
      $$LocalExerciseEquipmentsTableTableManager(
        _db,
        _db.localExerciseEquipments,
      );
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
}
