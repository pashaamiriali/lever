import 'change_queen.dart';

class QueenInfo {
  final String id;
  final String changeQueenId;
  final DateTime enterDate;
  final String breed;
  final String backColor;

  QueenInfo(
      this.id, this.changeQueenId, this.enterDate, this.breed, this.backColor);

  static QueenInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return QueenInfo(map['id'], map['changeQueenId'], map['enterDate'],
        map['breed'], map['backColor']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'changeQueenId': this.changeQueenId,
      'enterDate': this.enterDate,
      'breed': this.breed,
      'backColor': this.backColor
    };
  }
}
