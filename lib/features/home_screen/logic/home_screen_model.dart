import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hives_cmnd.dart';

class HomeScreenModel with ChangeNotifier {
  final FetchHivesCmnd _fetchHivesCmnd;
  HomeScreenModel(this._fetchHivesCmnd);

  List<Hive> _hives;

  Future<List<Hive>> get hives async {
    if (this._hives != null) return this._hives;
    this._hives = await this._fetchHivesCmnd.execute(null);
    return this._hives;
  }
}
