import 'package:lever/features/hive_management/domain/entities/entities.dart';

abstract class HiveRepo {
  saveHive(Hive hive, PopulationInfo populationInfo, QueenInfo queenInfo);
  fetchHives();
  fetchHive(String hiveId);
  fetchLastHiveNumber();
  deleteHive(String hiveId);
  editHive(Hive hive);
  editPopulationInfo(PopulationInfo populationInfo);
  editQueenInfo(QueenInfo queenInfo);
}
