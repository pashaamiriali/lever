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

  Future<List<TRegularVisit>> getHiveRegularVisits(hiveId) async {
    return await (select(tRegularVisits)
          ..where((tbl) => tbl.hiveId.equals(hiveId)))
        .get();
  }

  Future<List<TChangeQueen>> getHiveChangeQueens(hiveId) async {
    return await (select(tChangeQueens)
          ..where((tbl) => tbl.hiveId.equals(hiveId)))
        .get();
  }

  Future<List<THarvestHoney>> getHiveHarvestHoneys(hiveId) async {
    return await (select(tHarvestHoneys)
          ..where((tbl) => tbl.hiveId.equals(hiveId)))
        .get();
  }

  Future<TPopulationInfo> getLastPopulationInfo(String hiveId) async {
    var regularVisits = await (select(tRegularVisits)
          ..where((tbl) => tbl.hiveId.equals(hiveId))
          ..orderBy(
            [(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)],
          ))
        .get();

    return await (select(tPopulationInfos)
          ..where((tbl) => tbl.regularVisitId.equals(regularVisits.first.id)))
        .getSingle();
  }

  Future<TPopulationInfo> getPopulationInfo(String regularVisitId) async {
    return await (select(tPopulationInfos)
          ..where((tbl) => tbl.regularVisitId.equals(regularVisitId)))
        .getSingle();
  }

  Future<TQueenInfo> getLastQueenInfo(String hiveId) async {
    var changeQueens = await (select(tChangeQueens)
          ..where((tbl) => tbl.hiveId.equals(hiveId))
          ..orderBy(
            [(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)],
          ))
        .get();
    return await (select(tQueenInfos)
          ..where((tbl) => tbl.changeQueenId.equals(changeQueens.first.id)))
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

  Future<int> addHarvestHoney(THarvestHoneysCompanion harvestHoney) {
    return into(tHarvestHoneys).insert(harvestHoney);
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

  Future<void> updateHive(THive hive) async {
    await update(tHives).replace(hive);
  }

  Future<void> updatePopulationInfo(TPopulationInfo populationInfo) async {
    await update(tPopulationInfos).replace(populationInfo);
  }

  Future<void> updateQueenInfo(TQueenInfo queenInfo) async {
    await update(tQueenInfos).replace(queenInfo);
  }

  Future<THive> getHive(String hiveId) async {
    return await (select(tHives)..where((tbl) => tbl.id.equals(hiveId)))
        .getSingle();
  }
}
