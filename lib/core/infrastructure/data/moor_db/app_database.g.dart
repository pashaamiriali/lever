// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TChangeQueen extends DataClass implements Insertable<TChangeQueen> {
  final String id;
  final String hiveId;
  final DateTime date;
  final String pictures;
  final String description;
  TChangeQueen(
      {@required this.id,
      @required this.hiveId,
      @required this.date,
      @required this.pictures,
      @required this.description});
  factory TChangeQueen.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return TChangeQueen(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      hiveId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hive_id']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      pictures: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pictures']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || hiveId != null) {
      map['hive_id'] = Variable<String>(hiveId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || pictures != null) {
      map['pictures'] = Variable<String>(pictures);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TChangeQueensCompanion toCompanion(bool nullToAbsent) {
    return TChangeQueensCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      hiveId:
          hiveId == null && nullToAbsent ? const Value.absent() : Value(hiveId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      pictures: pictures == null && nullToAbsent
          ? const Value.absent()
          : Value(pictures),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory TChangeQueen.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TChangeQueen(
      id: serializer.fromJson<String>(json['id']),
      hiveId: serializer.fromJson<String>(json['hiveId']),
      date: serializer.fromJson<DateTime>(json['date']),
      pictures: serializer.fromJson<String>(json['pictures']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hiveId': serializer.toJson<String>(hiveId),
      'date': serializer.toJson<DateTime>(date),
      'pictures': serializer.toJson<String>(pictures),
      'description': serializer.toJson<String>(description),
    };
  }

  TChangeQueen copyWith(
          {String id,
          String hiveId,
          DateTime date,
          String pictures,
          String description}) =>
      TChangeQueen(
        id: id ?? this.id,
        hiveId: hiveId ?? this.hiveId,
        date: date ?? this.date,
        pictures: pictures ?? this.pictures,
        description: description ?? this.description,
      );
  @override
  String toString() {
    return (StringBuffer('TChangeQueen(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('date: $date, ')
          ..write('pictures: $pictures, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          hiveId.hashCode,
          $mrjc(
              date.hashCode, $mrjc(pictures.hashCode, description.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TChangeQueen &&
          other.id == this.id &&
          other.hiveId == this.hiveId &&
          other.date == this.date &&
          other.pictures == this.pictures &&
          other.description == this.description);
}

class TChangeQueensCompanion extends UpdateCompanion<TChangeQueen> {
  final Value<String> id;
  final Value<String> hiveId;
  final Value<DateTime> date;
  final Value<String> pictures;
  final Value<String> description;
  const TChangeQueensCompanion({
    this.id = const Value.absent(),
    this.hiveId = const Value.absent(),
    this.date = const Value.absent(),
    this.pictures = const Value.absent(),
    this.description = const Value.absent(),
  });
  TChangeQueensCompanion.insert({
    @required String id,
    @required String hiveId,
    @required DateTime date,
    @required String pictures,
    @required String description,
  })  : id = Value(id),
        hiveId = Value(hiveId),
        date = Value(date),
        pictures = Value(pictures),
        description = Value(description);
  static Insertable<TChangeQueen> custom({
    Expression<String> id,
    Expression<String> hiveId,
    Expression<DateTime> date,
    Expression<String> pictures,
    Expression<String> description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hiveId != null) 'hive_id': hiveId,
      if (date != null) 'date': date,
      if (pictures != null) 'pictures': pictures,
      if (description != null) 'description': description,
    });
  }

  TChangeQueensCompanion copyWith(
      {Value<String> id,
      Value<String> hiveId,
      Value<DateTime> date,
      Value<String> pictures,
      Value<String> description}) {
    return TChangeQueensCompanion(
      id: id ?? this.id,
      hiveId: hiveId ?? this.hiveId,
      date: date ?? this.date,
      pictures: pictures ?? this.pictures,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hiveId.present) {
      map['hive_id'] = Variable<String>(hiveId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (pictures.present) {
      map['pictures'] = Variable<String>(pictures.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TChangeQueensCompanion(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('date: $date, ')
          ..write('pictures: $pictures, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $TChangeQueensTable extends TChangeQueens
    with TableInfo<$TChangeQueensTable, TChangeQueen> {
  final GeneratedDatabase _db;
  final String _alias;
  $TChangeQueensTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hiveIdMeta = const VerificationMeta('hiveId');
  GeneratedTextColumn _hiveId;
  @override
  GeneratedTextColumn get hiveId => _hiveId ??= _constructHiveId();
  GeneratedTextColumn _constructHiveId() {
    return GeneratedTextColumn(
      'hive_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _picturesMeta = const VerificationMeta('pictures');
  GeneratedTextColumn _pictures;
  @override
  GeneratedTextColumn get pictures => _pictures ??= _constructPictures();
  GeneratedTextColumn _constructPictures() {
    return GeneratedTextColumn(
      'pictures',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, hiveId, date, pictures, description];
  @override
  $TChangeQueensTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 't_change_queens';
  @override
  final String actualTableName = 't_change_queens';
  @override
  VerificationContext validateIntegrity(Insertable<TChangeQueen> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hive_id')) {
      context.handle(_hiveIdMeta,
          hiveId.isAcceptableOrUnknown(data['hive_id'], _hiveIdMeta));
    } else if (isInserting) {
      context.missing(_hiveIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('pictures')) {
      context.handle(_picturesMeta,
          pictures.isAcceptableOrUnknown(data['pictures'], _picturesMeta));
    } else if (isInserting) {
      context.missing(_picturesMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TChangeQueen map(Map<String, dynamic> data, {String tablePrefix}) {
    return TChangeQueen.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TChangeQueensTable createAlias(String alias) {
    return $TChangeQueensTable(_db, alias);
  }
}

class THarvestHoney extends DataClass implements Insertable<THarvestHoney> {
  final String id;
  final String hiveId;
  final DateTime date;
  final String pictures;
  final String description;
  final String describedAmount;
  final int frames;
  final int weight;
  final String quality;
  THarvestHoney(
      {@required this.id,
      @required this.hiveId,
      @required this.date,
      @required this.pictures,
      @required this.description,
      @required this.describedAmount,
      @required this.frames,
      @required this.weight,
      @required this.quality});
  factory THarvestHoney.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return THarvestHoney(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      hiveId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hive_id']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      pictures: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pictures']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      describedAmount: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}described_amount']),
      frames: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}frames']),
      weight: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}weight']),
      quality: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quality']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || hiveId != null) {
      map['hive_id'] = Variable<String>(hiveId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || pictures != null) {
      map['pictures'] = Variable<String>(pictures);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || describedAmount != null) {
      map['described_amount'] = Variable<String>(describedAmount);
    }
    if (!nullToAbsent || frames != null) {
      map['frames'] = Variable<int>(frames);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<String>(quality);
    }
    return map;
  }

  THarvestHoneysCompanion toCompanion(bool nullToAbsent) {
    return THarvestHoneysCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      hiveId:
          hiveId == null && nullToAbsent ? const Value.absent() : Value(hiveId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      pictures: pictures == null && nullToAbsent
          ? const Value.absent()
          : Value(pictures),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      describedAmount: describedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(describedAmount),
      frames:
          frames == null && nullToAbsent ? const Value.absent() : Value(frames),
      weight:
          weight == null && nullToAbsent ? const Value.absent() : Value(weight),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
    );
  }

  factory THarvestHoney.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return THarvestHoney(
      id: serializer.fromJson<String>(json['id']),
      hiveId: serializer.fromJson<String>(json['hiveId']),
      date: serializer.fromJson<DateTime>(json['date']),
      pictures: serializer.fromJson<String>(json['pictures']),
      description: serializer.fromJson<String>(json['description']),
      describedAmount: serializer.fromJson<String>(json['describedAmount']),
      frames: serializer.fromJson<int>(json['frames']),
      weight: serializer.fromJson<int>(json['weight']),
      quality: serializer.fromJson<String>(json['quality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hiveId': serializer.toJson<String>(hiveId),
      'date': serializer.toJson<DateTime>(date),
      'pictures': serializer.toJson<String>(pictures),
      'description': serializer.toJson<String>(description),
      'describedAmount': serializer.toJson<String>(describedAmount),
      'frames': serializer.toJson<int>(frames),
      'weight': serializer.toJson<int>(weight),
      'quality': serializer.toJson<String>(quality),
    };
  }

  THarvestHoney copyWith(
          {String id,
          String hiveId,
          DateTime date,
          String pictures,
          String description,
          String describedAmount,
          int frames,
          int weight,
          String quality}) =>
      THarvestHoney(
        id: id ?? this.id,
        hiveId: hiveId ?? this.hiveId,
        date: date ?? this.date,
        pictures: pictures ?? this.pictures,
        description: description ?? this.description,
        describedAmount: describedAmount ?? this.describedAmount,
        frames: frames ?? this.frames,
        weight: weight ?? this.weight,
        quality: quality ?? this.quality,
      );
  @override
  String toString() {
    return (StringBuffer('THarvestHoney(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('date: $date, ')
          ..write('pictures: $pictures, ')
          ..write('description: $description, ')
          ..write('describedAmount: $describedAmount, ')
          ..write('frames: $frames, ')
          ..write('weight: $weight, ')
          ..write('quality: $quality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          hiveId.hashCode,
          $mrjc(
              date.hashCode,
              $mrjc(
                  pictures.hashCode,
                  $mrjc(
                      description.hashCode,
                      $mrjc(
                          describedAmount.hashCode,
                          $mrjc(frames.hashCode,
                              $mrjc(weight.hashCode, quality.hashCode)))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is THarvestHoney &&
          other.id == this.id &&
          other.hiveId == this.hiveId &&
          other.date == this.date &&
          other.pictures == this.pictures &&
          other.description == this.description &&
          other.describedAmount == this.describedAmount &&
          other.frames == this.frames &&
          other.weight == this.weight &&
          other.quality == this.quality);
}

class THarvestHoneysCompanion extends UpdateCompanion<THarvestHoney> {
  final Value<String> id;
  final Value<String> hiveId;
  final Value<DateTime> date;
  final Value<String> pictures;
  final Value<String> description;
  final Value<String> describedAmount;
  final Value<int> frames;
  final Value<int> weight;
  final Value<String> quality;
  const THarvestHoneysCompanion({
    this.id = const Value.absent(),
    this.hiveId = const Value.absent(),
    this.date = const Value.absent(),
    this.pictures = const Value.absent(),
    this.description = const Value.absent(),
    this.describedAmount = const Value.absent(),
    this.frames = const Value.absent(),
    this.weight = const Value.absent(),
    this.quality = const Value.absent(),
  });
  THarvestHoneysCompanion.insert({
    @required String id,
    @required String hiveId,
    @required DateTime date,
    @required String pictures,
    @required String description,
    @required String describedAmount,
    @required int frames,
    @required int weight,
    @required String quality,
  })  : id = Value(id),
        hiveId = Value(hiveId),
        date = Value(date),
        pictures = Value(pictures),
        description = Value(description),
        describedAmount = Value(describedAmount),
        frames = Value(frames),
        weight = Value(weight),
        quality = Value(quality);
  static Insertable<THarvestHoney> custom({
    Expression<String> id,
    Expression<String> hiveId,
    Expression<DateTime> date,
    Expression<String> pictures,
    Expression<String> description,
    Expression<String> describedAmount,
    Expression<int> frames,
    Expression<int> weight,
    Expression<String> quality,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hiveId != null) 'hive_id': hiveId,
      if (date != null) 'date': date,
      if (pictures != null) 'pictures': pictures,
      if (description != null) 'description': description,
      if (describedAmount != null) 'described_amount': describedAmount,
      if (frames != null) 'frames': frames,
      if (weight != null) 'weight': weight,
      if (quality != null) 'quality': quality,
    });
  }

  THarvestHoneysCompanion copyWith(
      {Value<String> id,
      Value<String> hiveId,
      Value<DateTime> date,
      Value<String> pictures,
      Value<String> description,
      Value<String> describedAmount,
      Value<int> frames,
      Value<int> weight,
      Value<String> quality}) {
    return THarvestHoneysCompanion(
      id: id ?? this.id,
      hiveId: hiveId ?? this.hiveId,
      date: date ?? this.date,
      pictures: pictures ?? this.pictures,
      description: description ?? this.description,
      describedAmount: describedAmount ?? this.describedAmount,
      frames: frames ?? this.frames,
      weight: weight ?? this.weight,
      quality: quality ?? this.quality,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hiveId.present) {
      map['hive_id'] = Variable<String>(hiveId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (pictures.present) {
      map['pictures'] = Variable<String>(pictures.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (describedAmount.present) {
      map['described_amount'] = Variable<String>(describedAmount.value);
    }
    if (frames.present) {
      map['frames'] = Variable<int>(frames.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('THarvestHoneysCompanion(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('date: $date, ')
          ..write('pictures: $pictures, ')
          ..write('description: $description, ')
          ..write('describedAmount: $describedAmount, ')
          ..write('frames: $frames, ')
          ..write('weight: $weight, ')
          ..write('quality: $quality')
          ..write(')'))
        .toString();
  }
}

class $THarvestHoneysTable extends THarvestHoneys
    with TableInfo<$THarvestHoneysTable, THarvestHoney> {
  final GeneratedDatabase _db;
  final String _alias;
  $THarvestHoneysTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hiveIdMeta = const VerificationMeta('hiveId');
  GeneratedTextColumn _hiveId;
  @override
  GeneratedTextColumn get hiveId => _hiveId ??= _constructHiveId();
  GeneratedTextColumn _constructHiveId() {
    return GeneratedTextColumn(
      'hive_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _picturesMeta = const VerificationMeta('pictures');
  GeneratedTextColumn _pictures;
  @override
  GeneratedTextColumn get pictures => _pictures ??= _constructPictures();
  GeneratedTextColumn _constructPictures() {
    return GeneratedTextColumn(
      'pictures',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _describedAmountMeta =
      const VerificationMeta('describedAmount');
  GeneratedTextColumn _describedAmount;
  @override
  GeneratedTextColumn get describedAmount =>
      _describedAmount ??= _constructDescribedAmount();
  GeneratedTextColumn _constructDescribedAmount() {
    return GeneratedTextColumn(
      'described_amount',
      $tableName,
      false,
    );
  }

  final VerificationMeta _framesMeta = const VerificationMeta('frames');
  GeneratedIntColumn _frames;
  @override
  GeneratedIntColumn get frames => _frames ??= _constructFrames();
  GeneratedIntColumn _constructFrames() {
    return GeneratedIntColumn(
      'frames',
      $tableName,
      false,
    );
  }

  final VerificationMeta _weightMeta = const VerificationMeta('weight');
  GeneratedIntColumn _weight;
  @override
  GeneratedIntColumn get weight => _weight ??= _constructWeight();
  GeneratedIntColumn _constructWeight() {
    return GeneratedIntColumn(
      'weight',
      $tableName,
      false,
    );
  }

  final VerificationMeta _qualityMeta = const VerificationMeta('quality');
  GeneratedTextColumn _quality;
  @override
  GeneratedTextColumn get quality => _quality ??= _constructQuality();
  GeneratedTextColumn _constructQuality() {
    return GeneratedTextColumn(
      'quality',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        hiveId,
        date,
        pictures,
        description,
        describedAmount,
        frames,
        weight,
        quality
      ];
  @override
  $THarvestHoneysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 't_harvest_honeys';
  @override
  final String actualTableName = 't_harvest_honeys';
  @override
  VerificationContext validateIntegrity(Insertable<THarvestHoney> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hive_id')) {
      context.handle(_hiveIdMeta,
          hiveId.isAcceptableOrUnknown(data['hive_id'], _hiveIdMeta));
    } else if (isInserting) {
      context.missing(_hiveIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('pictures')) {
      context.handle(_picturesMeta,
          pictures.isAcceptableOrUnknown(data['pictures'], _picturesMeta));
    } else if (isInserting) {
      context.missing(_picturesMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('described_amount')) {
      context.handle(
          _describedAmountMeta,
          describedAmount.isAcceptableOrUnknown(
              data['described_amount'], _describedAmountMeta));
    } else if (isInserting) {
      context.missing(_describedAmountMeta);
    }
    if (data.containsKey('frames')) {
      context.handle(_framesMeta,
          frames.isAcceptableOrUnknown(data['frames'], _framesMeta));
    } else if (isInserting) {
      context.missing(_framesMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight'], _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(_qualityMeta,
          quality.isAcceptableOrUnknown(data['quality'], _qualityMeta));
    } else if (isInserting) {
      context.missing(_qualityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  THarvestHoney map(Map<String, dynamic> data, {String tablePrefix}) {
    return THarvestHoney.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $THarvestHoneysTable createAlias(String alias) {
    return $THarvestHoneysTable(_db, alias);
  }
}

class THive extends DataClass implements Insertable<THive> {
  final String id;
  final int number;
  final int annualHoney;
  final String description;
  final String picture;
  THive(
      {@required this.id,
      @required this.number,
      @required this.annualHoney,
      @required this.description,
      @required this.picture});
  factory THive.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return THive(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      number: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}number']),
      annualHoney: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}annual_honey']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      picture: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}picture']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<int>(number);
    }
    if (!nullToAbsent || annualHoney != null) {
      map['annual_honey'] = Variable<int>(annualHoney);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<String>(picture);
    }
    return map;
  }

  THivesCompanion toCompanion(bool nullToAbsent) {
    return THivesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      number:
          number == null && nullToAbsent ? const Value.absent() : Value(number),
      annualHoney: annualHoney == null && nullToAbsent
          ? const Value.absent()
          : Value(annualHoney),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
    );
  }

  factory THive.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return THive(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      annualHoney: serializer.fromJson<int>(json['annualHoney']),
      description: serializer.fromJson<String>(json['description']),
      picture: serializer.fromJson<String>(json['picture']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<int>(number),
      'annualHoney': serializer.toJson<int>(annualHoney),
      'description': serializer.toJson<String>(description),
      'picture': serializer.toJson<String>(picture),
    };
  }

  THive copyWith(
          {String id,
          int number,
          int annualHoney,
          String description,
          String picture}) =>
      THive(
        id: id ?? this.id,
        number: number ?? this.number,
        annualHoney: annualHoney ?? this.annualHoney,
        description: description ?? this.description,
        picture: picture ?? this.picture,
      );
  @override
  String toString() {
    return (StringBuffer('THive(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('annualHoney: $annualHoney, ')
          ..write('description: $description, ')
          ..write('picture: $picture')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          number.hashCode,
          $mrjc(annualHoney.hashCode,
              $mrjc(description.hashCode, picture.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is THive &&
          other.id == this.id &&
          other.number == this.number &&
          other.annualHoney == this.annualHoney &&
          other.description == this.description &&
          other.picture == this.picture);
}

class THivesCompanion extends UpdateCompanion<THive> {
  final Value<String> id;
  final Value<int> number;
  final Value<int> annualHoney;
  final Value<String> description;
  final Value<String> picture;
  const THivesCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.annualHoney = const Value.absent(),
    this.description = const Value.absent(),
    this.picture = const Value.absent(),
  });
  THivesCompanion.insert({
    @required String id,
    @required int number,
    @required int annualHoney,
    @required String description,
    @required String picture,
  })  : id = Value(id),
        number = Value(number),
        annualHoney = Value(annualHoney),
        description = Value(description),
        picture = Value(picture);
  static Insertable<THive> custom({
    Expression<String> id,
    Expression<int> number,
    Expression<int> annualHoney,
    Expression<String> description,
    Expression<String> picture,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (annualHoney != null) 'annual_honey': annualHoney,
      if (description != null) 'description': description,
      if (picture != null) 'picture': picture,
    });
  }

  THivesCompanion copyWith(
      {Value<String> id,
      Value<int> number,
      Value<int> annualHoney,
      Value<String> description,
      Value<String> picture}) {
    return THivesCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      annualHoney: annualHoney ?? this.annualHoney,
      description: description ?? this.description,
      picture: picture ?? this.picture,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (annualHoney.present) {
      map['annual_honey'] = Variable<int>(annualHoney.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('THivesCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('annualHoney: $annualHoney, ')
          ..write('description: $description, ')
          ..write('picture: $picture')
          ..write(')'))
        .toString();
  }
}

class $THivesTable extends THives with TableInfo<$THivesTable, THive> {
  final GeneratedDatabase _db;
  final String _alias;
  $THivesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _numberMeta = const VerificationMeta('number');
  GeneratedIntColumn _number;
  @override
  GeneratedIntColumn get number => _number ??= _constructNumber();
  GeneratedIntColumn _constructNumber() {
    return GeneratedIntColumn(
      'number',
      $tableName,
      false,
    );
  }

  final VerificationMeta _annualHoneyMeta =
      const VerificationMeta('annualHoney');
  GeneratedIntColumn _annualHoney;
  @override
  GeneratedIntColumn get annualHoney =>
      _annualHoney ??= _constructAnnualHoney();
  GeneratedIntColumn _constructAnnualHoney() {
    return GeneratedIntColumn(
      'annual_honey',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _pictureMeta = const VerificationMeta('picture');
  GeneratedTextColumn _picture;
  @override
  GeneratedTextColumn get picture => _picture ??= _constructPicture();
  GeneratedTextColumn _constructPicture() {
    return GeneratedTextColumn(
      'picture',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, number, annualHoney, description, picture];
  @override
  $THivesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 't_hives';
  @override
  final String actualTableName = 't_hives';
  @override
  VerificationContext validateIntegrity(Insertable<THive> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number'], _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('annual_honey')) {
      context.handle(
          _annualHoneyMeta,
          annualHoney.isAcceptableOrUnknown(
              data['annual_honey'], _annualHoneyMeta));
    } else if (isInserting) {
      context.missing(_annualHoneyMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture'], _pictureMeta));
    } else if (isInserting) {
      context.missing(_pictureMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  THive map(Map<String, dynamic> data, {String tablePrefix}) {
    return THive.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $THivesTable createAlias(String alias) {
    return $THivesTable(_db, alias);
  }
}

class TPopulationInfo extends DataClass implements Insertable<TPopulationInfo> {
  final String id;
  final String regularVisitId;
  final int frames;
  final int stairs;
  final String status;
  TPopulationInfo(
      {@required this.id,
      @required this.regularVisitId,
      @required this.frames,
      @required this.stairs,
      @required this.status});
  factory TPopulationInfo.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return TPopulationInfo(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      regularVisitId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}regular_visit_id']),
      frames: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}frames']),
      stairs: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}stairs']),
      status: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || regularVisitId != null) {
      map['regular_visit_id'] = Variable<String>(regularVisitId);
    }
    if (!nullToAbsent || frames != null) {
      map['frames'] = Variable<int>(frames);
    }
    if (!nullToAbsent || stairs != null) {
      map['stairs'] = Variable<int>(stairs);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    return map;
  }

  TPopulationInfosCompanion toCompanion(bool nullToAbsent) {
    return TPopulationInfosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      regularVisitId: regularVisitId == null && nullToAbsent
          ? const Value.absent()
          : Value(regularVisitId),
      frames:
          frames == null && nullToAbsent ? const Value.absent() : Value(frames),
      stairs:
          stairs == null && nullToAbsent ? const Value.absent() : Value(stairs),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
    );
  }

  factory TPopulationInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TPopulationInfo(
      id: serializer.fromJson<String>(json['id']),
      regularVisitId: serializer.fromJson<String>(json['regularVisitId']),
      frames: serializer.fromJson<int>(json['frames']),
      stairs: serializer.fromJson<int>(json['stairs']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'regularVisitId': serializer.toJson<String>(regularVisitId),
      'frames': serializer.toJson<int>(frames),
      'stairs': serializer.toJson<int>(stairs),
      'status': serializer.toJson<String>(status),
    };
  }

  TPopulationInfo copyWith(
          {String id,
          String regularVisitId,
          int frames,
          int stairs,
          String status}) =>
      TPopulationInfo(
        id: id ?? this.id,
        regularVisitId: regularVisitId ?? this.regularVisitId,
        frames: frames ?? this.frames,
        stairs: stairs ?? this.stairs,
        status: status ?? this.status,
      );
  @override
  String toString() {
    return (StringBuffer('TPopulationInfo(')
          ..write('id: $id, ')
          ..write('regularVisitId: $regularVisitId, ')
          ..write('frames: $frames, ')
          ..write('stairs: $stairs, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(regularVisitId.hashCode,
          $mrjc(frames.hashCode, $mrjc(stairs.hashCode, status.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TPopulationInfo &&
          other.id == this.id &&
          other.regularVisitId == this.regularVisitId &&
          other.frames == this.frames &&
          other.stairs == this.stairs &&
          other.status == this.status);
}

class TPopulationInfosCompanion extends UpdateCompanion<TPopulationInfo> {
  final Value<String> id;
  final Value<String> regularVisitId;
  final Value<int> frames;
  final Value<int> stairs;
  final Value<String> status;
  const TPopulationInfosCompanion({
    this.id = const Value.absent(),
    this.regularVisitId = const Value.absent(),
    this.frames = const Value.absent(),
    this.stairs = const Value.absent(),
    this.status = const Value.absent(),
  });
  TPopulationInfosCompanion.insert({
    @required String id,
    @required String regularVisitId,
    @required int frames,
    @required int stairs,
    @required String status,
  })  : id = Value(id),
        regularVisitId = Value(regularVisitId),
        frames = Value(frames),
        stairs = Value(stairs),
        status = Value(status);
  static Insertable<TPopulationInfo> custom({
    Expression<String> id,
    Expression<String> regularVisitId,
    Expression<int> frames,
    Expression<int> stairs,
    Expression<String> status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (regularVisitId != null) 'regular_visit_id': regularVisitId,
      if (frames != null) 'frames': frames,
      if (stairs != null) 'stairs': stairs,
      if (status != null) 'status': status,
    });
  }

  TPopulationInfosCompanion copyWith(
      {Value<String> id,
      Value<String> regularVisitId,
      Value<int> frames,
      Value<int> stairs,
      Value<String> status}) {
    return TPopulationInfosCompanion(
      id: id ?? this.id,
      regularVisitId: regularVisitId ?? this.regularVisitId,
      frames: frames ?? this.frames,
      stairs: stairs ?? this.stairs,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (regularVisitId.present) {
      map['regular_visit_id'] = Variable<String>(regularVisitId.value);
    }
    if (frames.present) {
      map['frames'] = Variable<int>(frames.value);
    }
    if (stairs.present) {
      map['stairs'] = Variable<int>(stairs.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TPopulationInfosCompanion(')
          ..write('id: $id, ')
          ..write('regularVisitId: $regularVisitId, ')
          ..write('frames: $frames, ')
          ..write('stairs: $stairs, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $TPopulationInfosTable extends TPopulationInfos
    with TableInfo<$TPopulationInfosTable, TPopulationInfo> {
  final GeneratedDatabase _db;
  final String _alias;
  $TPopulationInfosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _regularVisitIdMeta =
      const VerificationMeta('regularVisitId');
  GeneratedTextColumn _regularVisitId;
  @override
  GeneratedTextColumn get regularVisitId =>
      _regularVisitId ??= _constructRegularVisitId();
  GeneratedTextColumn _constructRegularVisitId() {
    return GeneratedTextColumn(
      'regular_visit_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _framesMeta = const VerificationMeta('frames');
  GeneratedIntColumn _frames;
  @override
  GeneratedIntColumn get frames => _frames ??= _constructFrames();
  GeneratedIntColumn _constructFrames() {
    return GeneratedIntColumn(
      'frames',
      $tableName,
      false,
    );
  }

  final VerificationMeta _stairsMeta = const VerificationMeta('stairs');
  GeneratedIntColumn _stairs;
  @override
  GeneratedIntColumn get stairs => _stairs ??= _constructStairs();
  GeneratedIntColumn _constructStairs() {
    return GeneratedIntColumn(
      'stairs',
      $tableName,
      false,
    );
  }

  final VerificationMeta _statusMeta = const VerificationMeta('status');
  GeneratedTextColumn _status;
  @override
  GeneratedTextColumn get status => _status ??= _constructStatus();
  GeneratedTextColumn _constructStatus() {
    return GeneratedTextColumn(
      'status',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, regularVisitId, frames, stairs, status];
  @override
  $TPopulationInfosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 't_population_infos';
  @override
  final String actualTableName = 't_population_infos';
  @override
  VerificationContext validateIntegrity(Insertable<TPopulationInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('regular_visit_id')) {
      context.handle(
          _regularVisitIdMeta,
          regularVisitId.isAcceptableOrUnknown(
              data['regular_visit_id'], _regularVisitIdMeta));
    } else if (isInserting) {
      context.missing(_regularVisitIdMeta);
    }
    if (data.containsKey('frames')) {
      context.handle(_framesMeta,
          frames.isAcceptableOrUnknown(data['frames'], _framesMeta));
    } else if (isInserting) {
      context.missing(_framesMeta);
    }
    if (data.containsKey('stairs')) {
      context.handle(_stairsMeta,
          stairs.isAcceptableOrUnknown(data['stairs'], _stairsMeta));
    } else if (isInserting) {
      context.missing(_stairsMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status'], _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TPopulationInfo map(Map<String, dynamic> data, {String tablePrefix}) {
    return TPopulationInfo.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TPopulationInfosTable createAlias(String alias) {
    return $TPopulationInfosTable(_db, alias);
  }
}

class TQueenInfo extends DataClass implements Insertable<TQueenInfo> {
  final String id;
  final String changeQueenId;
  final DateTime enterDate;
  final String breed;
  final String backColor;
  TQueenInfo(
      {@required this.id,
      @required this.changeQueenId,
      @required this.enterDate,
      @required this.breed,
      @required this.backColor});
  factory TQueenInfo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return TQueenInfo(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      changeQueenId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}change_queen_id']),
      enterDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}enter_date']),
      breed: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}breed']),
      backColor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}back_color']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || changeQueenId != null) {
      map['change_queen_id'] = Variable<String>(changeQueenId);
    }
    if (!nullToAbsent || enterDate != null) {
      map['enter_date'] = Variable<DateTime>(enterDate);
    }
    if (!nullToAbsent || breed != null) {
      map['breed'] = Variable<String>(breed);
    }
    if (!nullToAbsent || backColor != null) {
      map['back_color'] = Variable<String>(backColor);
    }
    return map;
  }

  TQueenInfosCompanion toCompanion(bool nullToAbsent) {
    return TQueenInfosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      changeQueenId: changeQueenId == null && nullToAbsent
          ? const Value.absent()
          : Value(changeQueenId),
      enterDate: enterDate == null && nullToAbsent
          ? const Value.absent()
          : Value(enterDate),
      breed:
          breed == null && nullToAbsent ? const Value.absent() : Value(breed),
      backColor: backColor == null && nullToAbsent
          ? const Value.absent()
          : Value(backColor),
    );
  }

  factory TQueenInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TQueenInfo(
      id: serializer.fromJson<String>(json['id']),
      changeQueenId: serializer.fromJson<String>(json['changeQueenId']),
      enterDate: serializer.fromJson<DateTime>(json['enterDate']),
      breed: serializer.fromJson<String>(json['breed']),
      backColor: serializer.fromJson<String>(json['backColor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'changeQueenId': serializer.toJson<String>(changeQueenId),
      'enterDate': serializer.toJson<DateTime>(enterDate),
      'breed': serializer.toJson<String>(breed),
      'backColor': serializer.toJson<String>(backColor),
    };
  }

  TQueenInfo copyWith(
          {String id,
          String changeQueenId,
          DateTime enterDate,
          String breed,
          String backColor}) =>
      TQueenInfo(
        id: id ?? this.id,
        changeQueenId: changeQueenId ?? this.changeQueenId,
        enterDate: enterDate ?? this.enterDate,
        breed: breed ?? this.breed,
        backColor: backColor ?? this.backColor,
      );
  @override
  String toString() {
    return (StringBuffer('TQueenInfo(')
          ..write('id: $id, ')
          ..write('changeQueenId: $changeQueenId, ')
          ..write('enterDate: $enterDate, ')
          ..write('breed: $breed, ')
          ..write('backColor: $backColor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          changeQueenId.hashCode,
          $mrjc(
              enterDate.hashCode, $mrjc(breed.hashCode, backColor.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TQueenInfo &&
          other.id == this.id &&
          other.changeQueenId == this.changeQueenId &&
          other.enterDate == this.enterDate &&
          other.breed == this.breed &&
          other.backColor == this.backColor);
}

class TQueenInfosCompanion extends UpdateCompanion<TQueenInfo> {
  final Value<String> id;
  final Value<String> changeQueenId;
  final Value<DateTime> enterDate;
  final Value<String> breed;
  final Value<String> backColor;
  const TQueenInfosCompanion({
    this.id = const Value.absent(),
    this.changeQueenId = const Value.absent(),
    this.enterDate = const Value.absent(),
    this.breed = const Value.absent(),
    this.backColor = const Value.absent(),
  });
  TQueenInfosCompanion.insert({
    @required String id,
    @required String changeQueenId,
    @required DateTime enterDate,
    @required String breed,
    @required String backColor,
  })  : id = Value(id),
        changeQueenId = Value(changeQueenId),
        enterDate = Value(enterDate),
        breed = Value(breed),
        backColor = Value(backColor);
  static Insertable<TQueenInfo> custom({
    Expression<String> id,
    Expression<String> changeQueenId,
    Expression<DateTime> enterDate,
    Expression<String> breed,
    Expression<String> backColor,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (changeQueenId != null) 'change_queen_id': changeQueenId,
      if (enterDate != null) 'enter_date': enterDate,
      if (breed != null) 'breed': breed,
      if (backColor != null) 'back_color': backColor,
    });
  }

  TQueenInfosCompanion copyWith(
      {Value<String> id,
      Value<String> changeQueenId,
      Value<DateTime> enterDate,
      Value<String> breed,
      Value<String> backColor}) {
    return TQueenInfosCompanion(
      id: id ?? this.id,
      changeQueenId: changeQueenId ?? this.changeQueenId,
      enterDate: enterDate ?? this.enterDate,
      breed: breed ?? this.breed,
      backColor: backColor ?? this.backColor,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (changeQueenId.present) {
      map['change_queen_id'] = Variable<String>(changeQueenId.value);
    }
    if (enterDate.present) {
      map['enter_date'] = Variable<DateTime>(enterDate.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (backColor.present) {
      map['back_color'] = Variable<String>(backColor.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TQueenInfosCompanion(')
          ..write('id: $id, ')
          ..write('changeQueenId: $changeQueenId, ')
          ..write('enterDate: $enterDate, ')
          ..write('breed: $breed, ')
          ..write('backColor: $backColor')
          ..write(')'))
        .toString();
  }
}

class $TQueenInfosTable extends TQueenInfos
    with TableInfo<$TQueenInfosTable, TQueenInfo> {
  final GeneratedDatabase _db;
  final String _alias;
  $TQueenInfosTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _changeQueenIdMeta =
      const VerificationMeta('changeQueenId');
  GeneratedTextColumn _changeQueenId;
  @override
  GeneratedTextColumn get changeQueenId =>
      _changeQueenId ??= _constructChangeQueenId();
  GeneratedTextColumn _constructChangeQueenId() {
    return GeneratedTextColumn(
      'change_queen_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _enterDateMeta = const VerificationMeta('enterDate');
  GeneratedDateTimeColumn _enterDate;
  @override
  GeneratedDateTimeColumn get enterDate => _enterDate ??= _constructEnterDate();
  GeneratedDateTimeColumn _constructEnterDate() {
    return GeneratedDateTimeColumn(
      'enter_date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _breedMeta = const VerificationMeta('breed');
  GeneratedTextColumn _breed;
  @override
  GeneratedTextColumn get breed => _breed ??= _constructBreed();
  GeneratedTextColumn _constructBreed() {
    return GeneratedTextColumn(
      'breed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _backColorMeta = const VerificationMeta('backColor');
  GeneratedTextColumn _backColor;
  @override
  GeneratedTextColumn get backColor => _backColor ??= _constructBackColor();
  GeneratedTextColumn _constructBackColor() {
    return GeneratedTextColumn(
      'back_color',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, changeQueenId, enterDate, breed, backColor];
  @override
  $TQueenInfosTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 't_queen_infos';
  @override
  final String actualTableName = 't_queen_infos';
  @override
  VerificationContext validateIntegrity(Insertable<TQueenInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('change_queen_id')) {
      context.handle(
          _changeQueenIdMeta,
          changeQueenId.isAcceptableOrUnknown(
              data['change_queen_id'], _changeQueenIdMeta));
    } else if (isInserting) {
      context.missing(_changeQueenIdMeta);
    }
    if (data.containsKey('enter_date')) {
      context.handle(_enterDateMeta,
          enterDate.isAcceptableOrUnknown(data['enter_date'], _enterDateMeta));
    } else if (isInserting) {
      context.missing(_enterDateMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
          _breedMeta, breed.isAcceptableOrUnknown(data['breed'], _breedMeta));
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('back_color')) {
      context.handle(_backColorMeta,
          backColor.isAcceptableOrUnknown(data['back_color'], _backColorMeta));
    } else if (isInserting) {
      context.missing(_backColorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TQueenInfo map(Map<String, dynamic> data, {String tablePrefix}) {
    return TQueenInfo.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TQueenInfosTable createAlias(String alias) {
    return $TQueenInfosTable(_db, alias);
  }
}

class TRegularVisit extends DataClass implements Insertable<TRegularVisit> {
  final String id;
  final String hiveId;
  final DateTime date;
  final String pictures;
  final String description;
  final String behavior;
  final bool queenSeen;
  final String honeyMaking;
  TRegularVisit(
      {@required this.id,
      @required this.hiveId,
      @required this.date,
      @required this.pictures,
      @required this.description,
      @required this.behavior,
      @required this.queenSeen,
      @required this.honeyMaking});
  factory TRegularVisit.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return TRegularVisit(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id']),
      hiveId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}hive_id']),
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      pictures: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pictures']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      behavior: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}behavior']),
      queenSeen: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}queen_seen']),
      honeyMaking: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}honey_making']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || hiveId != null) {
      map['hive_id'] = Variable<String>(hiveId);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || pictures != null) {
      map['pictures'] = Variable<String>(pictures);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || behavior != null) {
      map['behavior'] = Variable<String>(behavior);
    }
    if (!nullToAbsent || queenSeen != null) {
      map['queen_seen'] = Variable<bool>(queenSeen);
    }
    if (!nullToAbsent || honeyMaking != null) {
      map['honey_making'] = Variable<String>(honeyMaking);
    }
    return map;
  }

  TRegularVisitsCompanion toCompanion(bool nullToAbsent) {
    return TRegularVisitsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      hiveId:
          hiveId == null && nullToAbsent ? const Value.absent() : Value(hiveId),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      pictures: pictures == null && nullToAbsent
          ? const Value.absent()
          : Value(pictures),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      behavior: behavior == null && nullToAbsent
          ? const Value.absent()
          : Value(behavior),
      queenSeen: queenSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(queenSeen),
      honeyMaking: honeyMaking == null && nullToAbsent
          ? const Value.absent()
          : Value(honeyMaking),
    );
  }

  factory TRegularVisit.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TRegularVisit(
      id: serializer.fromJson<String>(json['id']),
      hiveId: serializer.fromJson<String>(json['hiveId']),
      date: serializer.fromJson<DateTime>(json['date']),
      pictures: serializer.fromJson<String>(json['pictures']),
      description: serializer.fromJson<String>(json['description']),
      behavior: serializer.fromJson<String>(json['behavior']),
      queenSeen: serializer.fromJson<bool>(json['queenSeen']),
      honeyMaking: serializer.fromJson<String>(json['honeyMaking']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hiveId': serializer.toJson<String>(hiveId),
      'date': serializer.toJson<DateTime>(date),
      'pictures': serializer.toJson<String>(pictures),
      'description': serializer.toJson<String>(description),
      'behavior': serializer.toJson<String>(behavior),
      'queenSeen': serializer.toJson<bool>(queenSeen),
      'honeyMaking': serializer.toJson<String>(honeyMaking),
    };
  }

  TRegularVisit copyWith(
          {String id,
          String hiveId,
          DateTime date,
          String pictures,
          String description,
          String behavior,
          bool queenSeen,
          String honeyMaking}) =>
      TRegularVisit(
        id: id ?? this.id,
        hiveId: hiveId ?? this.hiveId,
        date: date ?? this.date,
        pictures: pictures ?? this.pictures,
        description: description ?? this.description,
        behavior: behavior ?? this.behavior,
        queenSeen: queenSeen ?? this.queenSeen,
        honeyMaking: honeyMaking ?? this.honeyMaking,
      );
  @override
  String toString() {
    return (StringBuffer('TRegularVisit(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('date: $date, ')
          ..write('pictures: $pictures, ')
          ..write('description: $description, ')
          ..write('behavior: $behavior, ')
          ..write('queenSeen: $queenSeen, ')
          ..write('honeyMaking: $honeyMaking')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          hiveId.hashCode,
          $mrjc(
              date.hashCode,
              $mrjc(
                  pictures.hashCode,
                  $mrjc(
                      description.hashCode,
                      $mrjc(
                          behavior.hashCode,
                          $mrjc(
                              queenSeen.hashCode, honeyMaking.hashCode))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TRegularVisit &&
          other.id == this.id &&
          other.hiveId == this.hiveId &&
          other.date == this.date &&
          other.pictures == this.pictures &&
          other.description == this.description &&
          other.behavior == this.behavior &&
          other.queenSeen == this.queenSeen &&
          other.honeyMaking == this.honeyMaking);
}

class TRegularVisitsCompanion extends UpdateCompanion<TRegularVisit> {
  final Value<String> id;
  final Value<String> hiveId;
  final Value<DateTime> date;
  final Value<String> pictures;
  final Value<String> description;
  final Value<String> behavior;
  final Value<bool> queenSeen;
  final Value<String> honeyMaking;
  const TRegularVisitsCompanion({
    this.id = const Value.absent(),
    this.hiveId = const Value.absent(),
    this.date = const Value.absent(),
    this.pictures = const Value.absent(),
    this.description = const Value.absent(),
    this.behavior = const Value.absent(),
    this.queenSeen = const Value.absent(),
    this.honeyMaking = const Value.absent(),
  });
  TRegularVisitsCompanion.insert({
    @required String id,
    @required String hiveId,
    @required DateTime date,
    @required String pictures,
    @required String description,
    @required String behavior,
    @required bool queenSeen,
    @required String honeyMaking,
  })  : id = Value(id),
        hiveId = Value(hiveId),
        date = Value(date),
        pictures = Value(pictures),
        description = Value(description),
        behavior = Value(behavior),
        queenSeen = Value(queenSeen),
        honeyMaking = Value(honeyMaking);
  static Insertable<TRegularVisit> custom({
    Expression<String> id,
    Expression<String> hiveId,
    Expression<DateTime> date,
    Expression<String> pictures,
    Expression<String> description,
    Expression<String> behavior,
    Expression<bool> queenSeen,
    Expression<String> honeyMaking,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hiveId != null) 'hive_id': hiveId,
      if (date != null) 'date': date,
      if (pictures != null) 'pictures': pictures,
      if (description != null) 'description': description,
      if (behavior != null) 'behavior': behavior,
      if (queenSeen != null) 'queen_seen': queenSeen,
      if (honeyMaking != null) 'honey_making': honeyMaking,
    });
  }

  TRegularVisitsCompanion copyWith(
      {Value<String> id,
      Value<String> hiveId,
      Value<DateTime> date,
      Value<String> pictures,
      Value<String> description,
      Value<String> behavior,
      Value<bool> queenSeen,
      Value<String> honeyMaking}) {
    return TRegularVisitsCompanion(
      id: id ?? this.id,
      hiveId: hiveId ?? this.hiveId,
      date: date ?? this.date,
      pictures: pictures ?? this.pictures,
      description: description ?? this.description,
      behavior: behavior ?? this.behavior,
      queenSeen: queenSeen ?? this.queenSeen,
      honeyMaking: honeyMaking ?? this.honeyMaking,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hiveId.present) {
      map['hive_id'] = Variable<String>(hiveId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (pictures.present) {
      map['pictures'] = Variable<String>(pictures.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (behavior.present) {
      map['behavior'] = Variable<String>(behavior.value);
    }
    if (queenSeen.present) {
      map['queen_seen'] = Variable<bool>(queenSeen.value);
    }
    if (honeyMaking.present) {
      map['honey_making'] = Variable<String>(honeyMaking.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TRegularVisitsCompanion(')
          ..write('id: $id, ')
          ..write('hiveId: $hiveId, ')
          ..write('date: $date, ')
          ..write('pictures: $pictures, ')
          ..write('description: $description, ')
          ..write('behavior: $behavior, ')
          ..write('queenSeen: $queenSeen, ')
          ..write('honeyMaking: $honeyMaking')
          ..write(')'))
        .toString();
  }
}

class $TRegularVisitsTable extends TRegularVisits
    with TableInfo<$TRegularVisitsTable, TRegularVisit> {
  final GeneratedDatabase _db;
  final String _alias;
  $TRegularVisitsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _hiveIdMeta = const VerificationMeta('hiveId');
  GeneratedTextColumn _hiveId;
  @override
  GeneratedTextColumn get hiveId => _hiveId ??= _constructHiveId();
  GeneratedTextColumn _constructHiveId() {
    return GeneratedTextColumn(
      'hive_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      false,
    );
  }

  final VerificationMeta _picturesMeta = const VerificationMeta('pictures');
  GeneratedTextColumn _pictures;
  @override
  GeneratedTextColumn get pictures => _pictures ??= _constructPictures();
  GeneratedTextColumn _constructPictures() {
    return GeneratedTextColumn(
      'pictures',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _behaviorMeta = const VerificationMeta('behavior');
  GeneratedTextColumn _behavior;
  @override
  GeneratedTextColumn get behavior => _behavior ??= _constructBehavior();
  GeneratedTextColumn _constructBehavior() {
    return GeneratedTextColumn(
      'behavior',
      $tableName,
      false,
    );
  }

  final VerificationMeta _queenSeenMeta = const VerificationMeta('queenSeen');
  GeneratedBoolColumn _queenSeen;
  @override
  GeneratedBoolColumn get queenSeen => _queenSeen ??= _constructQueenSeen();
  GeneratedBoolColumn _constructQueenSeen() {
    return GeneratedBoolColumn(
      'queen_seen',
      $tableName,
      false,
    );
  }

  final VerificationMeta _honeyMakingMeta =
      const VerificationMeta('honeyMaking');
  GeneratedTextColumn _honeyMaking;
  @override
  GeneratedTextColumn get honeyMaking =>
      _honeyMaking ??= _constructHoneyMaking();
  GeneratedTextColumn _constructHoneyMaking() {
    return GeneratedTextColumn(
      'honey_making',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        hiveId,
        date,
        pictures,
        description,
        behavior,
        queenSeen,
        honeyMaking
      ];
  @override
  $TRegularVisitsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 't_regular_visits';
  @override
  final String actualTableName = 't_regular_visits';
  @override
  VerificationContext validateIntegrity(Insertable<TRegularVisit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('hive_id')) {
      context.handle(_hiveIdMeta,
          hiveId.isAcceptableOrUnknown(data['hive_id'], _hiveIdMeta));
    } else if (isInserting) {
      context.missing(_hiveIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('pictures')) {
      context.handle(_picturesMeta,
          pictures.isAcceptableOrUnknown(data['pictures'], _picturesMeta));
    } else if (isInserting) {
      context.missing(_picturesMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('behavior')) {
      context.handle(_behaviorMeta,
          behavior.isAcceptableOrUnknown(data['behavior'], _behaviorMeta));
    } else if (isInserting) {
      context.missing(_behaviorMeta);
    }
    if (data.containsKey('queen_seen')) {
      context.handle(_queenSeenMeta,
          queenSeen.isAcceptableOrUnknown(data['queen_seen'], _queenSeenMeta));
    } else if (isInserting) {
      context.missing(_queenSeenMeta);
    }
    if (data.containsKey('honey_making')) {
      context.handle(
          _honeyMakingMeta,
          honeyMaking.isAcceptableOrUnknown(
              data['honey_making'], _honeyMakingMeta));
    } else if (isInserting) {
      context.missing(_honeyMakingMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TRegularVisit map(Map<String, dynamic> data, {String tablePrefix}) {
    return TRegularVisit.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TRegularVisitsTable createAlias(String alias) {
    return $TRegularVisitsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TChangeQueensTable _tChangeQueens;
  $TChangeQueensTable get tChangeQueens =>
      _tChangeQueens ??= $TChangeQueensTable(this);
  $THarvestHoneysTable _tHarvestHoneys;
  $THarvestHoneysTable get tHarvestHoneys =>
      _tHarvestHoneys ??= $THarvestHoneysTable(this);
  $THivesTable _tHives;
  $THivesTable get tHives => _tHives ??= $THivesTable(this);
  $TPopulationInfosTable _tPopulationInfos;
  $TPopulationInfosTable get tPopulationInfos =>
      _tPopulationInfos ??= $TPopulationInfosTable(this);
  $TQueenInfosTable _tQueenInfos;
  $TQueenInfosTable get tQueenInfos => _tQueenInfos ??= $TQueenInfosTable(this);
  $TRegularVisitsTable _tRegularVisits;
  $TRegularVisitsTable get tRegularVisits =>
      _tRegularVisits ??= $TRegularVisitsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        tChangeQueens,
        tHarvestHoneys,
        tHives,
        tPopulationInfos,
        tQueenInfos,
        tRegularVisits
      ];
}
