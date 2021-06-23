import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/generate_hive_number_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';
enum ProcessState{none,loading,finished}
class AddHiveViewLogic with ChangeNotifier {
  final AddHiveCmnd _addHiveCmnd;
  final GenerateHiveNumberCmnd _generateHiveNumberCmnd;
  AddHiveViewLogic(this._addHiveCmnd, this._generateHiveNumberCmnd);
  ProcessState processState = ProcessState.none;
  String picture='', breed='', queenBackColor='', status='متوسط', description='';
  int hiveNumber, frames=0, stairs=0, annualHoney=0;
  DateTime queenAddedDate=DateTime(0);

  Set<String> invalidFields = {};

  void saveHivePressed() {
    if (validateForm()) {
      var hive = Hive(null, hiveNumber, annualHoney, description, picture, null,
          null, null);
      var populationInfo = PopulationInfo(null, null, frames, stairs, status);
      var queenInfo =
          QueenInfo(null, null, queenAddedDate, breed, queenBackColor);
      processState = ProcessState.loading;
      notifyListeners();
      addHive(hive, populationInfo, queenInfo).then((value) {
        processState = ProcessState.finished;
        notifyListeners();
      });
    } else
      notifyListeners();
  }

  bool validateForm() {
    if (hiveNumber != null && invalidFields.isEmpty) return true;
    return false;
  }

  Future<int> generateHiveNumber() async {
    return hiveNumber = await _generateHiveNumberCmnd.execute(null);
  }

  Future<Hive> addHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    return await _addHiveCmnd.execute({
      'hive': hive,
      'population_info': populationInfo,
      'queen_info': queenInfo,
    });
  }
}
