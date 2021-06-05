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

  Hive(this.id, this.number, this.annualHoney, this.description, this.picture,
      this.populationInfo, this.queenInfo, this.visits);

  static Hive fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Hive(
        map['id'],
        map['number'],
        map['annualHoney'],
        map['description'],
        map['picture'],
        PopulationInfo.fromMap(map['populationInfo']),
        QueenInfo.fromMap(map['queenInfo']),
        visitsFromMapList(map['visits']));
  }

  static List<Visit> visitsFromMapList(List<Map> mapList) {
    if (mapList == null) return null;
    List<Visit> oVisits = [];
    for (var map in mapList) {
      oVisits.add(Visit.fromMap(map));
    }
    return oVisits;
  }

  List<Map> visitsToMapList() {
    if(this.visits==null) return null;
    List<Map> _mapList = [];
    for (var _visit in this.visits) {
      _mapList.add(_visit.toMap());
    }
    return _mapList;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'number': this.number,
      'annualHoney': this.annualHoney,
      'description': this.description,
      'picture': this.picture,
      'populationInfo': this.populationInfo?.toMap(),
      'queenInfo': this.queenInfo?.toMap(),
      'visits': this.visitsToMapList(),
    };
  }
}
