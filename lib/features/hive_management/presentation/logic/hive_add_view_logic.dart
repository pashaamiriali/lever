import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';

class AddHiveViewLogic with ChangeNotifier {
  final AddHiveCmnd _addHiveCmnd;
  AddHiveViewLogic(this._addHiveCmnd);
  bool isSaveButtonPressed = false;
  bool formValidated = false;
  bool isLoading = false;
  String picture, breed, queenBackColor, status, description;
  int hiveNumber, frames, stairs, annualHoney;
  DateTime queenAddedDate;

  List<String> invalidFields = [];

  void saveHivePressed() {
    if (formValidated = true) {
      var hive = Hive(null, hiveNumber, annualHoney, description, picture, null,
          null, null);
      var populationInfo = PopulationInfo(null, null, frames, stairs, status);
      var queenInfo =
          QueenInfo(null, null, queenAddedDate, breed, queenBackColor);
      isLoading = true;
      addHive(hive, populationInfo, queenInfo).then((value) {
        isLoading = false;
        notifyListeners();
      });
    } else
      isSaveButtonPressed = true;
    notifyListeners();
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
