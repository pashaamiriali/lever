import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/regular_hive_visit_cmnd.dart';

class VisitHiveLogic with ChangeNotifier {
  final RegularHiveVisitCmnd _regularHiveVisitCmnd;

  VisitHiveLogic(this._regularHiveVisitCmnd);

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
}
