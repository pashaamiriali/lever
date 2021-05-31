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
    return HarvestHoney(
        map['id'],
        map['hiveId'],
        map['date'],
        map['pictures'],
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
      'date': this.date,
      'pictures': this.pictures,
      'description': this.description,
      'describedAmount': this.describedAmount,
      'frames': this.frames,
      'weight': this.weight,
      'quality': this.quality
    };
  }
}
