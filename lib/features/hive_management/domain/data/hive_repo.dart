import 'package:lever/features/hive_management/domain/entities/entities.dart';

abstract class HiveRepo{
  saveHive(Hive hive,PopulationInfo populationInfo, QueenInfo queenInfo);
}