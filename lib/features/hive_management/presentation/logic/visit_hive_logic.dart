import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/change_hive_queen_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/harvest_hive_honey_cmnd.dart.dart';
import 'package:lever/features/hive_management/domain/usecases/regular_hive_visit_cmnd.dart';

class VisitHiveLogic with ChangeNotifier {
  final RegularHiveVisitCmnd _regularHiveVisitCmnd;
  final HarvestHiveHoneyCmnd _harvestHiveHoneyCmnd;
  final ChangeHiveQueenCmnd _changeHiveQueenCmnd;

  VisitHiveLogic(this._regularHiveVisitCmnd, this._harvestHiveHoneyCmnd,
      this._changeHiveQueenCmnd);

  Future<void> saveRegularVisit(Map<String, dynamic> visitData) async {
    await _regularHiveVisitCmnd.execute({
      'regular_visit': RegularVisit(
        null,
        visitData['hiveId'],
        visitData['date'],
        visitData['pictures'] as List<String>,
        visitData['description'],
        visitData['behavior'],
        visitData['queenSeen'],
        visitData['honeyMaking'],
        PopulationInfo(
          null,
          null,
          visitData['frames'],
          visitData['stairs'],
          visitData['status'],
        ),
      )
    });
  }

  Future<void> saveHarvestHoney(Map<String, dynamic> visitData) async {
    await _harvestHiveHoneyCmnd.execute({
      'harvest_honey': HarvestHoney(
          null,
          visitData['hiveId'],
          visitData['date'],
          visitData['pictures'],
          visitData['description'],
          visitData['describedAmount'],
          visitData['frames'],
          visitData['weight'],
          visitData['quality'])
    });
  }

  Future<void> saveChangeQueen(Map<String, dynamic> visitData) async {
    await _changeHiveQueenCmnd.execute({
      'change_queen': ChangeQueen(
        null,
        visitData['hiveId'],
        visitData['date'],
        visitData['pictures'],
        visitData['description'],
        QueenInfo(
          null,
          null,
          visitData['enterDate'],
          visitData['breed'],
          visitData['backColor'].toString(),
        ),
      )
    });
  }
}
