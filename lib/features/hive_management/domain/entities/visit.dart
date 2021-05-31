class Visit {
  final String id;

  final String hiveId;
  final DateTime date;
  final List<String> pictures;
  final String description;

  Visit(this.id, this.hiveId, this.date, this.pictures, this.description);

  static Visit fromMap(Map<String, dynamic> map) {
    return Visit(map['id'], map['hiveId'], map['date'], map['pictures'],
        map['description']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'hiveId': this.hiveId,
      'date': this.date,
      'pictures': this.pictures,
      'description': this.description
    };
  }
}
