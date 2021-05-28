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
  fetchHives() {
    // TODO: implement fetchHives
    throw UnimplementedError();
  }

  @override
  Future<Hive> saveHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    var hiveId = insertHive(hive);
    var regularVisitId = this._idGen.generateId();
    var regularVisitMap = insertRegularVisit(hiveId, regularVisitId);
    Map<String, Map<String, dynamic>> populationInfoMap =
        insertPopulationInfo(regularVisitId, populationInfo);
    var changeQueenId = this._idGen.generateId();
    Map<String, Map<String, dynamic>> changeQueenMap =
        insertChangeQueen(changeQueenId, hiveId);
    Map<String, Map<String, dynamic>> queenInfoMap =
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

  Hive generateReturnValues(
      Map<String, Map<String, dynamic>> populationInfoMap,
      regularVisitId,
      PopulationInfo populationInfo,
      Map<String, Map<String, dynamic>> queenInfoMap,
      changeQueenId,
      QueenInfo queenInfo,
      regularVisitMap,
      Map<String, Map<String, dynamic>> changeQueenMap,
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
      Map<String, Map<String, dynamic>> changeQueenMap,
      QueenInfo returnQueenInfo) {
    var returnChangeQueen = ChangeQueen(
        changeQueenMap['changeQueens']['id'],
        changeQueenMap['changeQueens']['hiveId'],
        changeQueenMap['changeQueens']['date'],
        changeQueenMap['changeQueens']['pictures'],
        changeQueenMap['changeQueens']['descriptions'],
        returnQueenInfo);
    return returnChangeQueen;
  }

  RegularVisit generateReturnRegularVisit(
      regularVisitMap, PopulationInfo populationInfo) {
    var returnRegularVisit = RegularVisit(
        regularVisitMap['regularVisits']['id'],
        regularVisitMap['regularVisits']['hiveId'],
        regularVisitMap['regularVisits']['date'],
        regularVisitMap['regularVisits']['pictures'],
        regularVisitMap['regularVisits']['description'],
        regularVisitMap['regularVisits']['behavior'],
        regularVisitMap['regularVisits']['queenSeen'],
        regularVisitMap['regularVisits']['honeyMaking'],
        populationInfo);
    return returnRegularVisit;
  }

  QueenInfo generateReturnQueenInfo(
      Map<String, Map<String, dynamic>> queenInfoMap,
      changeQueenId,
      QueenInfo queenInfo) {
    var returnQueenInfo = QueenInfo(
        queenInfoMap['queenInfos']['id'],
        changeQueenId,
        queenInfo.enterDate,
        queenInfo.breed,
        queenInfo.backColor);
    return returnQueenInfo;
  }

  PopulationInfo generateReturnPopulationInfo(
      Map<String, Map<String, dynamic>> populationInfoMap,
      regularVisitId,
      PopulationInfo populationInfo) {
    var returnPopulationInfo = PopulationInfo(
        populationInfoMap['populationInfos']['id'],
        regularVisitId,
        populationInfo.frames,
        populationInfo.stairs,
        populationInfo.status);
    return returnPopulationInfo;
  }

  Map<String, Map<String, dynamic>> insertQueenInfo(
      changeQueenId, QueenInfo queenInfo) {
    var queenInfoMap = {
      'queenInfos': {
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

  Map<String, Map<String, dynamic>> insertChangeQueen(changeQueenId, hiveId) {
    var changeQueenMap = {
      'changeQueens': {
        'id': changeQueenId,
        'hiveId': hiveId,
        'date': _dateTimeProvider.getCurrentDateTime(),
        'pictures': null,
        'description': '',
      }
    };
    this._databaseWrapper.insert(changeQueenMap);
    return changeQueenMap;
  }

  Map<String, Map<String, dynamic>> insertPopulationInfo(
      regularVisitId, PopulationInfo populationInfo) {
    var populationInfoMap = {
      'populationInfos': {
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
      'hives': {
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
      'regularVisits': {
        'id': regularVisitId,
        'hiveId': hiveId,
        'date': _dateTimeProvider.getCurrentDateTime(),
        'pictures': null,
        'description': '',
        'behavior': '',
        'queenSeen': true,
        'honeyMaking': ''
      }
    };
    this._databaseWrapper.insert(regularVisitMap);
    return regularVisitMap;
  }
}
