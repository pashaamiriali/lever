import 'population_info.dart';
import 'visit.dart';

class RegularVisit extends Visit {
  final String behavior;
  final bool queenSeen;
  final String honeyMaking;
  final PopulationInfo populationInfo;

  RegularVisit(
      String id,
      String hiveId,
      DateTime date,
      List<String> pictures,
      String description,
      this.behavior,
      this.queenSeen,
      this.honeyMaking,
      this.populationInfo)
      : super(id, hiveId,date, pictures, description);
}
