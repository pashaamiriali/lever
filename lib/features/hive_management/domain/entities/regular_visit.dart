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
      : super(id, hiveId, date, pictures, description);

  static RegularVisit fromMap(Map<String, dynamic> map) {
    return RegularVisit(
      map['id'],
      map['hiveId'],
      map['date'],
      map['pictures'],
      map['description'],
      map['behavior'],
      map['queenSeen'],
      map['honeyMaking'],
      PopulationInfo.fromMap(map['populationInfo']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'hiveId': this.hiveId,
      'date': this.date,
      'pictures': this.pictures,
      'description': this.description,
      'behavior': this.behavior,
      'queenSeen': this.queenSeen,
      'honeyMaking': this.honeyMaking,
      'populationInfo': this.populationInfo.toMap()
    };
  }
}
