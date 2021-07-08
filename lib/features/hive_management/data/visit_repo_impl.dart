import 'dart:convert';

import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/core/infrastructure/data/moor_db/app_database.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:moor_flutter/moor_flutter.dart';

class VisitRepoImpl implements VisitRepo {
  final AppDatabase _appDatabase;
  final IDGen _idGen;

  VisitRepoImpl(this._appDatabase, this._idGen);

  @override
  saveRegularVisit(RegularVisit regularVisit) async {
    var regularVisitId = _idGen.generateId();
    var populationInfoId = _idGen.generateId();
    await this
        ._appDatabase
        .addRegularVisit(_tableFromRegularVisit(regularVisitId, regularVisit));
    await _appDatabase.addPopulationInfo(_tableFromPopulationInfo(
        populationInfoId, regularVisitId, regularVisit.populationInfo));
  }

  @override
  saveHarvestHoney(HarvestHoney harvestHoney) async {
    var harvestHoneyId = _idGen.generateId();
    await this
        ._appDatabase
        .addHarvestHoney(_tableFromHarvestHoney(harvestHoney, harvestHoneyId));
  }

  @override
  saveChangeQueen(ChangeQueen changeQueen) async {
    var changeQueenId = this._idGen.generateId();
    var queenInfoId = this._idGen.generateId();
    await this
        ._appDatabase
        .addChangeQueen(_tableFromChangeQueen(changeQueen, changeQueenId));
    await this._appDatabase.addQueenInfo(
        _tableFromQueenInfo(changeQueen.queenInfo, queenInfoId, changeQueenId));
  }

  TPopulationInfosCompanion _tableFromPopulationInfo(String populationInfoId,
      String regularVisitId, PopulationInfo populationInfo) {
    return TPopulationInfosCompanion(
      id: Value(populationInfoId),
      regularVisitId: Value(regularVisitId),
      frames: Value(populationInfo.frames),
      stairs: Value(populationInfo.stairs),
      status: Value(populationInfo.status),
    );
  }

  TRegularVisitsCompanion _tableFromRegularVisit(
      String id, RegularVisit regularVisit) {
    return TRegularVisitsCompanion(
      id: Value(id),
      hiveId: Value(regularVisit.hiveId),
      behavior: Value(regularVisit.behavior),
      date: Value(regularVisit.date),
      description: Value(regularVisit.description),
      honeyMaking: Value(regularVisit.honeyMaking),
      pictures: Value(json.encode(regularVisit.pictures)),
      queenSeen: Value(regularVisit.queenSeen),
    );
  }

  THarvestHoneysCompanion _tableFromHarvestHoney(
      HarvestHoney harvestHoney, String harvestHoneyId) {
    return THarvestHoneysCompanion(
      id: Value(harvestHoneyId),
      date: Value(harvestHoney.date),
      frames: Value(harvestHoney.frames),
      description: Value(harvestHoney.description),
      hiveId: Value(harvestHoney.hiveId),
      describedAmount: Value(harvestHoney.describedAmount),
      pictures: Value(json.encode(harvestHoney.pictures)),
      quality: Value(harvestHoney.quality),
      weight: Value(harvestHoney.weight),
    );
  }

  TChangeQueensCompanion _tableFromChangeQueen(
      ChangeQueen changeQueen, String changeQueenId) {
    return TChangeQueensCompanion(
      id: Value(changeQueenId),
      hiveId: Value(changeQueen.hiveId),
      date: Value(changeQueen.date),
      description: Value(changeQueen.description),
      pictures: Value(json.encode(changeQueen.pictures)),
    );
  }

  TQueenInfosCompanion _tableFromQueenInfo(
      QueenInfo queenInfo, String queenInfoId, changeQueenId) {
    return TQueenInfosCompanion(
      id: Value(queenInfoId),
      changeQueenId: Value(changeQueenId),
      backColor: Value(queenInfo.backColor),
      breed: Value(queenInfo.breed),
      enterDate: Value(queenInfo.enterDate),
    );
  }
}
