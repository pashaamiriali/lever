import 'dart:convert';

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
    if (map == null) return null;
    return RegularVisit(
      map['id'],
      map['hiveId'],
      map['date']==null?null:DateTime.fromMillisecondsSinceEpoch(map['date']),
      (json.decode(map['pictures']) as List<dynamic>).cast<String>(),
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
      'date': this.date.millisecondsSinceEpoch,
      'pictures': json.encode(this.pictures),
      'description': this.description,
      'behavior': this.behavior,
      'queenSeen': this.queenSeen,
      'honeyMaking': this.honeyMaking,
      'populationInfo': this.populationInfo?.toMap()
    };
  }
}
