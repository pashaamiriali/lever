import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:moor/ffi.dart';
import './tables.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  TChangeQueens,
  THarvestHoneys,
  THives,
  TPopulationInfos,
  TQueenInfos,
  TRegularVisits
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<THive>> get allHives => select(tHives).get();
  Future<List<TRegularVisit>> get allRegularVisits =>
      select(tRegularVisits).get();
  Future<List<TChangeQueen>> get allChangeQueens => select(tChangeQueens).get();
  Future<List<THarvestHoney>> get allHarvestHoneys =>
      select(tHarvestHoneys).get();

  Future<TPopulationInfo> getLastPopulationInfo(String hiveId) async {
    var regularVisit = await (select(tRegularVisits)
          ..where((tbl) => tbl.hiveId.equals(hiveId))
          ..orderBy(
            [(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)],
          ))
        .getSingle();
    return (select(tPopulationInfos)
          ..where((tbl) => tbl.regularVisitId.equals(regularVisit.id)))
        .getSingle();
  }

  Future<TPopulationInfo> getPopulationInfo(String regularVisitId) async {
    return (select(tPopulationInfos)
          ..where((tbl) => tbl.regularVisitId.equals(regularVisitId)))
        .getSingle();
  }

  Future<TQueenInfo> getLastQueenInfo(String hiveId) async {
    var changeQueen = await (select(tChangeQueens)
          ..where((tbl) => tbl.hiveId.equals(hiveId))
          ..orderBy(
            [(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)],
          ))
        .getSingle();
    return (select(tQueenInfos)
          ..where((tbl) => tbl.changeQueenId.equals(changeQueen.id)))
        .getSingle();
  }

  Future<TQueenInfo> getQueenInfo(String changeQueenId) {
    return (select(tQueenInfos)
          ..where((tbl) => tbl.changeQueenId.equals(changeQueenId)))
        .getSingle();
  }

  Future<List<THive>> getLastHives() {
    var h = (select(tHives)
          ..orderBy(
            [
              (t) => OrderingTerm(expression: t.number, mode: OrderingMode.desc)
            ],
          ))
        .get();
    return h;
  }

  Future<int> addHive(THivesCompanion hive) {
    return into(tHives).insert(hive);
  }

  Future<int> addRegularVisit(TRegularVisitsCompanion regularVisit) {
    return into(tRegularVisits).insert(regularVisit);
  }

  Future<int> addChangeQueen(TChangeQueensCompanion changeQueen) {
    return into(tChangeQueens).insert(changeQueen);
  }

  Future<int> addPopulationInfo(TPopulationInfosCompanion populationInfo) {
    return into(tPopulationInfos).insert(populationInfo);
  }

  Future<int> addQueenInfo(TQueenInfosCompanion queenInfo) {
    return into(tQueenInfos).insert(queenInfo);
  }

  Future<void> deleteHive(String hiveId) async {
    await (delete(tHives)..where((tbl) => tbl.id.equals(hiveId))).go();
  }
}
