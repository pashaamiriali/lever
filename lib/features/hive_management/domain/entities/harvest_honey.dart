import 'dart:convert';

import 'visit.dart';

class HarvestHoney extends Visit {
  final String describedAmount;
  final int frames;
  final int weight;
  final String quality;

  HarvestHoney(
      String id,
      String hiveId,
      DateTime date,
      List<String> pictures,
      String description,
      this.describedAmount,
      this.frames,
      this.weight,
      this.quality)
      : super(id, hiveId, date, pictures, description);

  static HarvestHoney fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return HarvestHoney(
        map['id'],
        map['hiveId'],
       map['date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['date']),
        (json.decode(map['pictures']) as List<dynamic>).cast<String>(),
        map['description'],
        map['describedAmount'],
        map['frames'],
        map['weight'],
        map['quality']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'hiveId': this.hiveId,
      'date': this.date.millisecondsSinceEpoch,
      'pictures': json.encode(this.pictures),
      'description': this.description,
      'describedAmount': this.describedAmount,
      'frames': this.frames,
      'weight': this.weight,
      'quality': this.quality
    };
  }
}
