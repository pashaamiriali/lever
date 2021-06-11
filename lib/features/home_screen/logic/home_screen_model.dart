import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/add_hive_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hives_cmnd.dart';

class HomeScreenModel with ChangeNotifier {
  final FetchHivesCmnd _fetchHivesCmnd;
  final AddHiveCmnd _addHiveCmnd;
  HomeScreenModel(this._fetchHivesCmnd, this._addHiveCmnd);

  List<Hive> _hives;

  Future<List<Hive>> get hives async {
    if (this._hives != null) return this._hives;
    this._hives = await this._fetchHivesCmnd.execute(null);
    return this._hives;
  }

  Future addHive(
      Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo) async {
    var savedHive = await this._addHiveCmnd.execute({
      'hive': hive,
      'population_info': populationInfo,
      'queen_info': queenInfo
    });
    if (this._hives == null)
      this._hives = [savedHive];
    else
      this._hives.add(savedHive);
    notifyListeners();
  }
}
