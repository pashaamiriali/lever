//! all table classes get prefixed with "T" to distinguish them from the entities
import 'package:moor_flutter/moor_flutter.dart';

class TChangeQueens extends Table {
  TextColumn get id => text()();
  TextColumn get hiveId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get pictures => text()();
  TextColumn get description => text()();
    @override
  Set<Column> get primaryKey => {id};
}

class THarvestHoneys extends Table {
  TextColumn get id =>  text()();
  TextColumn get hiveId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get pictures => text()();
  TextColumn get description => text()();
  TextColumn get describedAmount => text()();
  IntColumn get frames => integer()();
  IntColumn get weight => integer()();
  TextColumn get quality => text()();
  @override
  Set<Column> get primaryKey => {id};
}

class THives extends Table {
  TextColumn get id => text()();
  IntColumn get number => integer()();
  IntColumn get annualHoney => integer()();
  TextColumn get description => text()();
  TextColumn get picture => text()();
    @override
  Set<Column> get primaryKey => {id};
}

class TPopulationInfos extends Table {
  TextColumn get id => text()();
  TextColumn get regularVisitId => text()();
  IntColumn get frames => integer()();
  IntColumn get stairs => integer()();
  TextColumn get status => text()();
    @override
  Set<Column> get primaryKey => {id};
}

class TQueenInfos extends Table {
  TextColumn get id => text()();
  TextColumn get changeQueenId => text()();
  DateTimeColumn get enterDate => dateTime()();
  TextColumn get breed => text()();
  TextColumn get backColor => text()();
    @override
  Set<Column> get primaryKey => {id};
}

class TRegularVisits extends Table {
  TextColumn get id => text()();
  TextColumn get hiveId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get pictures => text()();
  TextColumn get description => text()();
  TextColumn get behavior => text()();
  BoolColumn get queenSeen => boolean()();
  TextColumn get honeyMaking => text()();
    @override
  Set<Column> get primaryKey => {id};
}
