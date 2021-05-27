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
    //TODO: refactor to smaller functions
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
    var regularVisitId = this._idGen.generateId();
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
    var changeQueenId = this._idGen.generateId();
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
    var returnPopulationInfo = PopulationInfo(
        populationInfoMap['populationInfos']['id'],
        regularVisitId,
        populationInfo.frames,
        populationInfo.stairs,
        populationInfo.status);
    var returnQueenInfo = QueenInfo(
        queenInfoMap['queenInfos']['id'],
        changeQueenId,
        queenInfo.enterDate,
        queenInfo.breed,
        queenInfo.backColor);
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
    var returnChangeQueen = ChangeQueen(
        changeQueenMap['changeQueens']['id'],
        changeQueenMap['changeQueens']['hiveId'],
        changeQueenMap['changeQueens']['date'],
        changeQueenMap['changeQueens']['pictures'],
        changeQueenMap['changeQueens']['descriptions'],
        returnQueenInfo);
    return Hive(hiveId, hive.number, hive.annualHoney, hive.description,
        hive.picture, returnPopulationInfo, returnQueenInfo, [
      returnRegularVisit,
      returnChangeQueen,
    ]);
  }
}
