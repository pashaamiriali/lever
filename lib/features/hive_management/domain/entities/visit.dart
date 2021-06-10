import 'dart:convert';

class Visit {
  final String id;

  final String hiveId;
  final DateTime date;
  final List<String> pictures;
  final String description;

  Visit(this.id, this.hiveId, this.date, this.pictures, this.description);

  static Visit fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return Visit(map['id'], map['hiveId'], map['date'], (json.decode(map['pictures']) as List<dynamic>).cast<String>(),
        map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'hiveId': this.hiveId,
      'date': this.date,
      'pictures': json.encode(this.pictures),
      'description': this.description
    };
  }
}
