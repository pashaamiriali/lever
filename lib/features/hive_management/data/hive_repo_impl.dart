import 'dart:convert';

import 'package:lever/core/infrastructure/data/date_time_provider.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/core/infrastructure/data/moor_db/app_database.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/entities/hive.dart';
import 'package:lever/features/hive_management/domain/entities/population_info.dart';
import 'package:lever/features/hive_management/domain/entities/queen_info.dart';

class HiveRepoImpl extends HiveRepo {
  final AppDatabase _appDatabase;
  final IDGen _idGen;
  final DateTimeProvider _dateTimeProvider;

  HiveRepoImpl(this._appDatabase, this._idGen, this._dateTimeProvider);

  @override
  Future<List<Hive>> fetchHives() async {
    List<Hive> hivesList = [];
    var rawHives = await this._appDatabase.allHives;
    rawHives.map((e) async {
      hivesList.add(Hive(
          e.id,
          e.number,
          e.annualHoney,
          e.description,
          e.picture,
          await getHivePopulationInfo(e.id),
          await getHiveQueenInfo(e.id),
          await getHiveVisits(e.id)));
    }).toList();
    return hivesList;
  }

  @override
  fetchLastHiveNumber() async {
    try {
      var lastHive = await this._appDatabase.getLastHive();
      if (lastHive == null) return null;
      return lastHive.number;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  saveHive(Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) {
    var hiveId = this._idGen.generateId();
    var regularVisitId = this._idGen.generateId();
    var changeQueenId = this._idGen.generateId();
    var populationInfoId = this._idGen.generateId();
    var queenInfoId = this._idGen.generateId();
    RegularVisit completeRegularVisit = RegularVisit(
        regularVisitId,
        hiveId,
        this._dateTimeProvider.getCurrentDateTime(),
        [],
        '',
        '',
        true,
        '',
        populationInfo);
    ChangeQueen completeChangeQueen = ChangeQueen(changeQueenId, hiveId,
        this._dateTimeProvider.getCurrentDateTime(), [], '', queenInfo);

    Hive completeHive = Hive(
        hiveId,
        hive.number,
        hive.annualHoney,
        hive.description,
        hive.picture,
        populationInfo,
        queenInfo,
        [completeRegularVisit, completeChangeQueen]);
    this._appDatabase.addHive(THivesCompanion.insert(
        id: completeHive.id,
        number: completeHive.number,
        annualHoney: completeHive.annualHoney,
        description: completeHive.description,
        picture: completeHive.picture));
    this._appDatabase.addRegularVisit(TRegularVisitsCompanion.insert(
        id: completeRegularVisit.id,
        hiveId: completeRegularVisit.hiveId,
        date: completeRegularVisit.date,
        pictures: json.encode(completeRegularVisit.pictures),
        description: completeRegularVisit.description,
        behavior: completeRegularVisit.behavior,
        queenSeen: completeRegularVisit.queenSeen,
        honeyMaking: completeRegularVisit.honeyMaking));
    this._appDatabase.addChangeQueen(TChangeQueensCompanion.insert(
        id: completeChangeQueen.id,
        hiveId: completeChangeQueen.hiveId,
        date: completeChangeQueen.date,
        pictures: json.encode(completeChangeQueen.pictures),
        description: completeChangeQueen.description));
    this._appDatabase.addPopulationInfo(TPopulationInfosCompanion.insert(
        id: populationInfoId,
        regularVisitId: regularVisitId,
        frames: populationInfo.frames,
        stairs: populationInfo.stairs,
        status: populationInfo.status));
    this._appDatabase.addQueenInfo(TQueenInfosCompanion.insert(
        id: queenInfoId,
        changeQueenId: changeQueenId,
        enterDate: queenInfo.enterDate,
        breed: queenInfo.breed,
        backColor: queenInfo.backColor));
  }

  Future<PopulationInfo> getHivePopulationInfo(String hiveId) async {
    var _rawPopulationInfo =
        await this._appDatabase.getLastPopulationInfo(hiveId);
    return PopulationInfo(
        _rawPopulationInfo.id,
        _rawPopulationInfo.regularVisitId,
        _rawPopulationInfo.frames,
        _rawPopulationInfo.stairs,
        _rawPopulationInfo.status);
  }

  Future<QueenInfo> getHiveQueenInfo(String hiveId) async {
    var _rawQueenInfo = await this._appDatabase.getLastQueenInfo(hiveId);
    return QueenInfo(_rawQueenInfo.id, _rawQueenInfo.changeQueenId,
        _rawQueenInfo.enterDate, _rawQueenInfo.breed, _rawQueenInfo.backColor);
  }

  Future<List<Visit>> getHiveVisits(String hiveId) async {
    List<Visit> visits = [];
    var _rawRegularVisits = await this._appDatabase.allRegularVisits;
    var _rawChangeQueens = await this._appDatabase.allChangeQueens;
    var _rawHarvestHoneys = await this._appDatabase.allHarvestHoneys;
    _rawRegularVisits.map((e) async {
      visits.add(RegularVisit(
          e.id,
          e.hiveId,
          e.date,
          (json.decode(e.pictures) as List<dynamic>).cast<String>(),
          e.description,
          e.behavior,
          e.queenSeen,
          e.honeyMaking,
          await getPopulationInfo(e.id)));
    }).toList();
    _rawChangeQueens.map((e) async {
      visits.add(ChangeQueen(
          e.id,
          e.hiveId,
          e.date,
          (json.decode(e.pictures) as List<dynamic>).cast<String>(),
          e.description,
          await getQueenInfo(e.id)));
    }).toList();
    _rawHarvestHoneys.map((e) async {
      visits.add(HarvestHoney(
          e.id,
          e.hiveId,
          e.date,
          (json.decode(e.pictures) as List<dynamic>).cast<String>(),
          e.description,
          e.describedAmount,
          e.frames,
          e.weight,
          e.quality));
    }).toList();
    visits.sort((a, b) => a.date.compareTo(b.date));
    return visits.reversed;
  }

  Future<PopulationInfo> getPopulationInfo(String regularVisitId) async {
    var _rawPopulationInfo =
        await this._appDatabase.getPopulationInfo(regularVisitId);
    return PopulationInfo(
        _rawPopulationInfo.id,
        _rawPopulationInfo.regularVisitId,
        _rawPopulationInfo.frames,
        _rawPopulationInfo.stairs,
        _rawPopulationInfo.status);
  }

  Future<QueenInfo> getQueenInfo(String changeQueenId) async {
    var _rawQueenInfo = await this._appDatabase.getQueenInfo(changeQueenId);
    return QueenInfo(_rawQueenInfo.id, _rawQueenInfo.changeQueenId,
        _rawQueenInfo.enterDate, _rawQueenInfo.breed, _rawQueenInfo.backColor);
  }
}
