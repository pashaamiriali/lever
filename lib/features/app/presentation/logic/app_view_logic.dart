import 'package:flutter/cupertino.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';

class AppLogic with ChangeNotifier {
  String selectedHiveId;
  void setSelectedHive(String hiveId) {
    this.selectedHiveId = hiveId;
    notifyListeners();
  }
}
