import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/delete_hive_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hive_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hives_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/search_hive_cmnd.dart';

class HomeScreenModel with ChangeNotifier {
  final FetchHivesCmnd _fetchHivesCmnd;
  final DeleteHiveCmnd _deleteHiveCmnd;
  final SearchHiveCmnd _searchHiveCmnd;
  final FetchHiveCmnd _fetchHiveCmnd;
  HomeScreenModel(
    this._fetchHivesCmnd,
    this._deleteHiveCmnd,
    this._searchHiveCmnd,
    this._fetchHiveCmnd,
  );

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

  Future<List<Hive>> searchHives(String query) async {
    if (query.isEmpty) return null;
    return await this._searchHiveCmnd.execute({'query': query});
  }

  Future<Hive> fetchHive(String hiveId) async {
    if (hiveId.isEmpty) return null;
    try {
      return await this._fetchHiveCmnd.execute({'hive_id': hiveId});
    } catch (e) {
      return null;
    }
  }
}
