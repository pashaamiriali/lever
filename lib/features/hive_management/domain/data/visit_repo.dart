import 'package:lever/features/hive_management/domain/entities/entities.dart';

abstract class VisitRepo{
  saveRegularVisit(RegularVisit regularVisit);
  saveHarvestHoney(HarvestHoney harvestHoney);
  saveChangeQueen(ChangeQueen changeQueen);
}