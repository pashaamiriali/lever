import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/entities/hive.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';

class HiveDetailLogic with ChangeNotifier {
  final EditHiveCmnd _editHiveCmnd;
  final FetchHiveCmnd _fetchHiveCmnd;
  final DeleteHiveCmnd _deleteHiveCmnd;

  HiveDetailLogic(
    this._editHiveCmnd,
    this._fetchHiveCmnd,
    this._deleteHiveCmnd,
  );

  Future<void> updateHive(Hive newHive) async {
    await _editHiveCmnd.execute({'hive': newHive});
    notifyListeners();
  }

  Future<Hive> fetchHive(String hiveId) async {
    return await _fetchHiveCmnd.execute({'hive_id': hiveId});
  }

  Future<void> deleteHive(String hiveId) async {
    await this._deleteHiveCmnd.execute({'hive_id': hiveId});
    notifyListeners();
  }
}
