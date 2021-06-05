import 'queen_info.dart';
import 'visit.dart';

class ChangeQueen extends Visit {
  final QueenInfo queenInfo;

  ChangeQueen(String id, String hiveId, DateTime date, List<String> pictures,
      String description, this.queenInfo)
      : super(id, hiveId, date, pictures, description);

  static ChangeQueen fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ChangeQueen(map['id'], map['hiveId'], map['date'], map['pictures'],
        map['description'], QueenInfo.fromMap(map['queenInfo']));
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'hiveId': this.hiveId,
      'date': this.date,
      'pictures': this.pictures,
      'description': this.description,
      'queenInfo': this.queenInfo?.toMap()
    };
  }
}
