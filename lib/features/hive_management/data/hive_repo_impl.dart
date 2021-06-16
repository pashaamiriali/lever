import 'dart:convert';

import 'package:lever/core/infrastructure/data/database_provider.dart';
import 'package:lever/core/infrastructure/data/date_time_provider.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/entities/hive.dart';
import 'package:lever/features/hive_management/domain/entities/population_info.dart';
import 'package:lever/features/hive_management/domain/entities/queen_info.dart';

class HiveRepoImpl extends HiveRepo {
  final DatabaseWrapper _databaseWrapper;
  final IDGen _idGen;
  final DateTimeProvider _dateTimeProvider;

  HiveRepoImpl(this._databaseWrapper, this._idGen, this._dateTimeProvider);

  @override
  Future<List<Hive>> fetchHives() async {
    List<Hive> hivesList = [];
    var rawHives = await this._databaseWrapper.select({'table': 'hives'});
    for (var rawHive in rawHives) {
      var rawRegularVisit = await fetchLastRegularVisit(rawHive);
      var rawPopulationInfo = await fetchLastPopulationInfo(rawRegularVisit);
      var rawChangeQueen = await fetchLastChangeQueen(rawHive);
      var rawQueenInfo = await fetchLastQueenInfo(rawChangeQueen);

      PopulationInfo populationInfo = PopulationInfo.fromMap(rawPopulationInfo);
      QueenInfo queenInfo = QueenInfo.fromMap(rawQueenInfo);

      RegularVisit regularVisit = RegularVisit.fromMap(
          {...rawRegularVisit, 'populationInfo': populationInfo.toMap()});

      ChangeQueen changeQueen = ChangeQueen.fromMap(
          {...rawChangeQueen, 'queenInfo': queenInfo.toMap()});

      hivesList.add(generateHive(
          rawHive, populationInfo, queenInfo, regularVisit, changeQueen));
    }
    return hivesList;
  }

  @override
  Future<Hive> saveHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    var hiveId = insertHive(hive);
    var regularVisitId = this._idGen.generateId();
    var regularVisitMap = insertRegularVisit(hiveId, regularVisitId);
    Map<String, dynamic> populationInfoMap =
        insertPopulationInfo(regularVisitId, populationInfo);
    var changeQueenId = this._idGen.generateId();
    Map<String, dynamic> changeQueenMap =
        insertChangeQueen(changeQueenId, hiveId);
    Map<String, dynamic> queenInfoMap =
        insertQueenInfo(changeQueenId, queenInfo);

    return generateReturnValues(
        populationInfoMap,
        regularVisitId,
        populationInfo,
        queenInfoMap,
        changeQueenId,
        queenInfo,
        regularVisitMap,
        changeQueenMap,
        hiveId,
        hive);
  }

  Hive generateHive(rawHive, PopulationInfo populationInfo, QueenInfo queenInfo,
      RegularVisit regularVisit, ChangeQueen changeQueen) {
    var newRawHive = {
      ...rawHive,
      'populationInfo': populationInfo.toMap(),
      'queenInfo': queenInfo.toMap()
    };
    return Hive(
        newRawHive['id'],
        newRawHive['number'],
        newRawHive['annualHoney'],
        newRawHive['description'],
        newRawHive['picture'],
        populationInfo,
        queenInfo,
        [regularVisit, changeQueen]);
  }

  Future<dynamic> fetchLastQueenInfo(rawChangeQueen) async {
    var rawQueenInfo = await this._databaseWrapper.selectFirst({
      'table': 'queenInfos',
      'where': 'changeQueenId = ?',
      'whereArgs': [rawChangeQueen['id']]
    });
    return rawQueenInfo;
  }

  Future<dynamic> fetchLastChangeQueen(rawHive) async {
    var rawChangeQueen = await this._databaseWrapper.selectFirst({
      'table': 'changeQueens',
      'where': 'hiveId = ?',
      'whereArgs': [rawHive['id']],
      'orderBy': 'date DESC',
    });
    return rawChangeQueen;
  }

  Future<dynamic> fetchLastPopulationInfo(rawRegularVisit) async {
    var rawPopulationInfo = await this._databaseWrapper.selectFirst({
      'table': 'populationInfos',
      'where': 'regularVisitId = ?',
      'whereArgs': [rawRegularVisit['id']],
    });
    return rawPopulationInfo;
  }

  Future<dynamic> fetchLastRegularVisit(rawHive) async {
    var rawRegularVisit = await this._databaseWrapper.selectFirst({
      'table': 'regularVisits',
      'where': 'hiveId = ?',
      'whereArgs': [rawHive['id']],
      'orderBy': 'date DESC',
    });
    return rawRegularVisit;
  }

  Hive generateReturnValues(
      Map<String, dynamic> populationInfoMap,
      regularVisitId,
      PopulationInfo populationInfo,
      Map<String, dynamic> queenInfoMap,
      changeQueenId,
      QueenInfo queenInfo,
      regularVisitMap,
      Map<String, dynamic> changeQueenMap,
      hiveId,
      Hive hive) {
    PopulationInfo returnPopulationInfo = generateReturnPopulationInfo(
        populationInfoMap, regularVisitId, populationInfo);
    QueenInfo returnQueenInfo =
        generateReturnQueenInfo(queenInfoMap, changeQueenId, queenInfo);
    RegularVisit returnRegularVisit =
        generateReturnRegularVisit(regularVisitMap, populationInfo);
    ChangeQueen returnChangeQueen =
        generateReturnChangeQueen(changeQueenMap, returnQueenInfo);
    return Hive(hiveId, hive.number, hive.annualHoney, hive.description,
        hive.picture, returnPopulationInfo, returnQueenInfo, [
      returnRegularVisit,
      returnChangeQueen,
    ]);
  }

  ChangeQueen generateReturnChangeQueen(
      Map<String, dynamic> changeQueenMap, QueenInfo returnQueenInfo) {
    var returnChangeQueen = ChangeQueen(
        changeQueenMap['tableData']['id'],
        changeQueenMap['tableData']['hiveId'],
        changeQueenMap['tableData']['date'],
        json.decode(changeQueenMap['tableData']['pictures']),
        changeQueenMap['tableData']['descriptions'],
        returnQueenInfo);
    return returnChangeQueen;
  }

  RegularVisit generateReturnRegularVisit(
      regularVisitMap, PopulationInfo populationInfo) {
    var returnRegularVisit = RegularVisit(
        regularVisitMap['tableData']['id'],
        regularVisitMap['tableData']['hiveId'],
        regularVisitMap['tableData']['date'],
        json.decode(regularVisitMap['tableData']['pictures']),
        regularVisitMap['tableData']['description'],
        regularVisitMap['tableData']['behavior'],
        regularVisitMap['tableData']['queenSeen'],
        regularVisitMap['tableData']['honeyMaking'],
        populationInfo);
    return returnRegularVisit;
  }

  QueenInfo generateReturnQueenInfo(
      Map<String, dynamic> queenInfoMap, changeQueenId, QueenInfo queenInfo) {
    var returnQueenInfo = QueenInfo(
        queenInfoMap['tableData']['id'],
        changeQueenId,
        queenInfo.enterDate,
        queenInfo.breed,
        queenInfo.backColor);
    return returnQueenInfo;
  }

  PopulationInfo generateReturnPopulationInfo(
      Map<String, dynamic> populationInfoMap,
      regularVisitId,
      PopulationInfo populationInfo) {
    var returnPopulationInfo = PopulationInfo(
        populationInfoMap['tableData']['id'],
        regularVisitId,
        populationInfo.frames,
        populationInfo.stairs,
        populationInfo.status);
    return returnPopulationInfo;
  }

  Map<String, dynamic> insertQueenInfo(changeQueenId, QueenInfo queenInfo) {
    var queenInfoMap = {
      'table': 'queenInfos',
      'tableData': {
        'id': this._idGen.generateId(),
        'changeQueenId': changeQueenId,
        'enterDate': queenInfo.enterDate,
        'breed': queenInfo.breed,
        'backColor': queenInfo.backColor
      }
    };
    this._databaseWrapper.insert(queenInfoMap);
    return queenInfoMap;
  }

  Map<String, dynamic> insertChangeQueen(changeQueenId, hiveId) {
    var changeQueenMap = {
      'table': 'changeQueens',
      'tableData': {
        'id': changeQueenId,
        'hiveId': hiveId,
        'date': _dateTimeProvider.getCurrentDateTime(),
        'pictures': json.encode(null),
        'description': '',
      }
    };
    this._databaseWrapper.insert(changeQueenMap);
    return changeQueenMap;
  }

  Map<String, dynamic> insertPopulationInfo(
      regularVisitId, PopulationInfo populationInfo) {
    var populationInfoMap = {
      'table': 'populationInfos',
      'tableData': {
        'id': this._idGen.generateId(),
        'regularVisitId': regularVisitId,
        'frames': populationInfo.frames,
        'stairs': populationInfo.stairs,
        'status': populationInfo.status
      }
    };
    this._databaseWrapper.insert(populationInfoMap);
    return populationInfoMap;
  }

  insertHive(Hive hive) {
    var hiveId = this._idGen.generateId();
    var hiveMap = {
      'table': 'hives',
      'tableData': {
        'id': hiveId,
        'number': hive.number,
        'annualHoney': hive.annualHoney,
        'description': hive.description,
        'picture': hive.picture
      }
    };
    this._databaseWrapper.insert(hiveMap);
    return hiveId;
  }

  insertRegularVisit(hiveId, regularVisitId) {
    var regularVisitMap = {
      'table': 'regularVisits',
      'tableData': {
        'id': regularVisitId,
        'hiveId': hiveId,
        'date': _dateTimeProvider.getCurrentDateTime(),
        'pictures': json.encode(null),
        'description': '',
        'behavior': '',
        'queenSeen': true,
        'honeyMaking': ''
      }
    };
    this._databaseWrapper.insert(regularVisitMap);
    return regularVisitMap;
  }

  @override
  Future<int> fetchLastHiveNumber() async {
    var rawHive = await this._databaseWrapper.selectFirst({
      'table': 'hives',
      'orderBy': 'number DESC',
    });
    if (rawHive == null) return null;
    return rawHive['number'];
  }
}
