import 'package:flutter/cupertino.dart';

class AppLogic with ChangeNotifier {
  String selectedHiveId;
  void setSelectedHive(String hiveId) {
    this.selectedHiveId = hiveId;
    notifyListeners();
  }
}
