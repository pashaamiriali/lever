import 'package:lever/features/hive_management/domain/entities/regular_visit.dart';

class PopulationInfo {
  final String id;
  final String regularVisitId;
  final int frames;
  final int stairs;
  final String status;

  PopulationInfo(
      this.id, this.regularVisitId, this.frames, this.stairs, this.status);
}
