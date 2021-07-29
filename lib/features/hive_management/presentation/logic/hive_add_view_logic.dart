import 'package:flutter/cupertino.dart';
import 'package:lever/core/infrastructure/qr_provider/save_qr.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/generate_hive_number_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';

enum ProcessState { none, loading, finished }

class AddHiveViewLogic with ChangeNotifier {
  final AddHiveCmnd _addHiveCmnd;
  final GenerateHiveNumberCmnd _generateHiveNumberCmnd;
  AddHiveViewLogic(this._addHiveCmnd, this._generateHiveNumberCmnd);
  ProcessState processState = ProcessState.none;
  Map<String, dynamic> hiveInfo = {
    'picture': '',
    'breed': '',
    'queenBackColor': '',
    'status': 'متوسط',
    'description': '',
    'hiveNumber': null,
    'frames': 0,
    'stairs': 0,
    'annualHoney': 0,
    'queenAddedDate': DateTime(0),
  };
  Set<String> invalidFields = {};
  Future<void> saveHivePressed() async {
    if (validateForm()) {
      var hive = Hive(null, hiveInfo['hiveNumber'], hiveInfo['annualHoney'],
          hiveInfo['description'], hiveInfo['picture'], null, null, null);
      var populationInfo = PopulationInfo(null, null, hiveInfo['frames'],
          hiveInfo['stairs'], hiveInfo['status']);
      var queenInfo = QueenInfo(null, null, hiveInfo['queenAddedDate'],
          hiveInfo['breed'], hiveInfo['queenBackColor']);
      this.processState = ProcessState.loading;
      notifyListeners();
      String result = await addHive(hive, populationInfo, queenInfo);
      var qrSaveResult = await saveQrCode(result, hive.number.toString());
      if (qrSaveResult == null || !qrSaveResult)
        await saveQrCode(result, hive.number.toString());
      this.processState = ProcessState.finished;
      notifyListeners();
    } else
      notifyListeners();
  }

  bool validateForm() {
    if (hiveInfo['hiveNumber'] != null && invalidFields.isEmpty) return true;
    return false;
  }

  Future<int> generateHiveNumber() async {
    return hiveInfo['hiveNumber'] = await _generateHiveNumberCmnd.execute(null);
  }

  Future<String> addHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    return await _addHiveCmnd.execute({
      'hive': hive,
      'population_info': populationInfo,
      'queen_info': queenInfo,
    });
  }
}
