import 'population_info.dart';
import 'queen_info.dart';
import 'visit.dart';

class Hive {
  final String id;
  final int number;
  final int annualHoney;
  final String description;
  final String picture;
  final PopulationInfo populationInfo;
  final QueenInfo queenInfo;
  final List<Visit> visits;

  Hive(this.id, this.number, this.annualHoney, this.description,
      this.picture, this.populationInfo, this.queenInfo, this.visits);
}
