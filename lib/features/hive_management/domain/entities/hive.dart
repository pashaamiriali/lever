import 'population_info.dart';
import 'queen_info.dart';
import 'visit.dart';

class Hive {
  final String id;
  final int number;
  final int annualHoney;
  final String description;
  final List<String> pictures;
  final PopulationInfo populationInfo;
  final QueenInfo queenInfo;
  final List<Visit> visits;

  Hive(this.id, this.number, this.annualHoney, this.description,
      this.pictures, this.populationInfo, this.queenInfo, this.visits);
}
