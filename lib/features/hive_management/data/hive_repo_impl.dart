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
    for (THive rawHive in rawHives)
      hivesList.add(await _hiveFromHiveTable(rawHive));
    return hivesList;
  }

  @override
  fetchLastHiveNumber() async {
    try {
      var lastHive = (await this._appDatabase.getLastHives()).first;
      if (lastHive == null) return null;
      return lastHive.number;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> saveHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    var hiveId = this._idGen.generateId();
    var regularVisitId = this._idGen.generateId();
    var changeQueenId = this._idGen.generateId();
    var populationInfoId = this._idGen.generateId();
    var queenInfoId = this._idGen.generateId();
    RegularVisit completeRegularVisit =
        _generateCompleteRegularVisit(regularVisitId, hiveId, populationInfo);
    ChangeQueen completeChangeQueen =
        _generateCompleteChangeQueen(changeQueenId, hiveId, queenInfo);

    Hive completeHive = _generateCompleteHive(hiveId, hive, populationInfo,
        queenInfo, completeRegularVisit, completeChangeQueen);
    await _addHive(completeHive);
    await _addRegularVisitForHive(completeRegularVisit);
    await _addChangeQueenForHive(completeChangeQueen);
    await _addPopulationInfoForHive(
        populationInfoId, regularVisitId, populationInfo);
    await _addQueenInfoForHive(queenInfoId, changeQueenId, queenInfo);
  }

  @override
  Future<void> deleteHive(String hiveId) async {
    await this._appDatabase.deleteHive(hiveId);
  }

  @override
  Future<void> editHive(Hive hive) async {
    await this._appDatabase.updateHive(
          THive(
              id: hive.id,
              number: hive.number,
              annualHoney: hive.annualHoney,
              description: hive.description,
              picture: hive.picture),
        );
  }

  @override
  editPopulationInfo(PopulationInfo populationInfo) async {
    await this._appDatabase.updatePopulationInfo(
          TPopulationInfo(
              id: populationInfo.id,
              regularVisitId: populationInfo.regularVisitId,
              frames: populationInfo.frames,
              stairs: populationInfo.stairs,
              status: populationInfo.status),
        );
  }

  @override
  editQueenInfo(QueenInfo queenInfo) async {
    await this._appDatabase.updateQueenInfo(
          TQueenInfo(
              id: queenInfo.id,
              changeQueenId: queenInfo.changeQueenId,
              enterDate: queenInfo.enterDate,
              breed: queenInfo.breed,
              backColor: queenInfo.backColor),
        );
  }

  @override
  fetchHive(String hiveId) async {
    return await _hiveFromHiveTable(await this._appDatabase.getHive(hiveId));
  }

  Hive _generateCompleteHive(
      hiveId,
      Hive hive,
      PopulationInfo populationInfo,
      QueenInfo queenInfo,
      RegularVisit completeRegularVisit,
      ChangeQueen completeChangeQueen) {
    Hive completeHive = Hive(
        hiveId,
        hive.number,
        hive.annualHoney,
        hive.description,
        hive.picture,
        populationInfo,
        queenInfo,
        [completeRegularVisit, completeChangeQueen]);
    return completeHive;
  }

  ChangeQueen _generateCompleteChangeQueen(
      changeQueenId, hiveId, QueenInfo queenInfo) {
    ChangeQueen completeChangeQueen = ChangeQueen(changeQueenId, hiveId,
        this._dateTimeProvider.getCurrentDateTime(), [], '', queenInfo);
    return completeChangeQueen;
  }

  RegularVisit _generateCompleteRegularVisit(
      regularVisitId, hiveId, PopulationInfo populationInfo) {
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
    return completeRegularVisit;
  }

  Future<void> _addQueenInfoForHive(
      queenInfoId, changeQueenId, QueenInfo queenInfo) async {
    await this._appDatabase.addQueenInfo(TQueenInfosCompanion.insert(
        id: queenInfoId,
        changeQueenId: changeQueenId,
        enterDate: queenInfo.enterDate,
        breed: queenInfo.breed,
        backColor: queenInfo.backColor));
  }

  Future<void> _addPopulationInfoForHive(
      populationInfoId, regularVisitId, PopulationInfo populationInfo) async {
    await this._appDatabase.addPopulationInfo(TPopulationInfosCompanion.insert(
        id: populationInfoId,
        regularVisitId: regularVisitId,
        frames: populationInfo.frames,
        stairs: populationInfo.stairs,
        status: populationInfo.status));
  }

  Future<void> _addChangeQueenForHive(ChangeQueen completeChangeQueen) async {
    await this._appDatabase.addChangeQueen(TChangeQueensCompanion.insert(
        id: completeChangeQueen.id,
        hiveId: completeChangeQueen.hiveId,
        date: completeChangeQueen.date,
        pictures: json.encode(completeChangeQueen.pictures),
        description: completeChangeQueen.description));
  }

  Future<void> _addRegularVisitForHive(
      RegularVisit completeRegularVisit) async {
    await this._appDatabase.addRegularVisit(TRegularVisitsCompanion.insert(
        id: completeRegularVisit.id,
        hiveId: completeRegularVisit.hiveId,
        date: completeRegularVisit.date,
        pictures: json.encode(completeRegularVisit.pictures),
        description: completeRegularVisit.description,
        behavior: completeRegularVisit.behavior,
        queenSeen: completeRegularVisit.queenSeen,
        honeyMaking: completeRegularVisit.honeyMaking));
  }

  Future<void> _addHive(Hive completeHive) async {
    await this._appDatabase.addHive(THivesCompanion.insert(
        id: completeHive.id,
        number: completeHive.number,
        annualHoney: completeHive.annualHoney,
        description: completeHive.description,
        picture: completeHive.picture));
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
    for (TRegularVisit regularVisit in _rawRegularVisits)
      visits.add(RegularVisit(
          regularVisit.id,
          regularVisit.hiveId,
          regularVisit.date,
          (json.decode(regularVisit.pictures) as List<dynamic>).cast<String>(),
          regularVisit.description,
          regularVisit.behavior,
          regularVisit.queenSeen,
          regularVisit.honeyMaking,
          await getPopulationInfo(regularVisit.id)));

    for (TChangeQueen changeQueen in _rawChangeQueens)
      visits.add(ChangeQueen(
          changeQueen.id,
          changeQueen.hiveId,
          changeQueen.date,
          (json.decode(changeQueen.pictures) as List<dynamic>).cast<String>(),
          changeQueen.description,
          await getQueenInfo(changeQueen.id)));

    for (THarvestHoney harvestHoney in _rawHarvestHoneys)
      visits.add(HarvestHoney(
          harvestHoney.id,
          harvestHoney.hiveId,
          harvestHoney.date,
          (json.decode(harvestHoney.pictures) as List<dynamic>).cast<String>(),
          harvestHoney.description,
          harvestHoney.describedAmount,
          harvestHoney.frames,
          harvestHoney.weight,
          harvestHoney.quality));

    visits.sort((a, b) => a.date.compareTo(b.date));
    return visits;
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

  Future<Hive> _hiveFromHiveTable(THive hive) async {
    return Hive(
        hive.id,
        hive.number,
        hive.annualHoney,
        hive.description,
        hive.picture,
        await getHivePopulationInfo(hive.id),
        await getHiveQueenInfo(hive.id),
        await getHiveVisits(hive.id));
  }
}
