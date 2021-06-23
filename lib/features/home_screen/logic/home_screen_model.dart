import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/delete_hive_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hives_cmnd.dart';

class HomeScreenModel with ChangeNotifier {
  final FetchHivesCmnd _fetchHivesCmnd;
  final DeleteHiveCmnd _deleteHiveCmnd;
  HomeScreenModel(this._fetchHivesCmnd, this._deleteHiveCmnd);

  List<Hive> _hives;

  Future<List<Hive>> get hives async {
    if (this._hives != null) return this._hives;
    this._hives = await this._fetchHivesCmnd.execute(null);
    return this._hives;
  }

  Future<void> deleteHive(String hiveId) async {
    await _deleteHiveCmnd.execute({'hive_id': hiveId});
    this._hives.removeWhere((element) => element.id == hiveId);
    notifyListeners();
  }
}
