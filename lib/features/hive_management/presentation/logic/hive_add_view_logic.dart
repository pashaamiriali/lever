import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';

class AddHiveViewLogic with ChangeNotifier {
  final AddHiveCmnd _addHiveCmnd;

  AddHiveViewLogic(this._addHiveCmnd);
  Future<Hive> addHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    return await _addHiveCmnd.execute({
      'hive': hive,
      'population_info': populationInfo,
      'queen_info': queenInfo,
    });
  }
}
