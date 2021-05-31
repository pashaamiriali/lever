class PopulationInfo {
  final String id;
  final String regularVisitId;
  final int frames;
  final int stairs;
  final String status;

  PopulationInfo(
      this.id, this.regularVisitId, this.frames, this.stairs, this.status);

  static PopulationInfo fromMap(Map<String, dynamic> map) {
    return PopulationInfo(map['id'], map['regularVisitId'], map['frames'],
        map['stairs'], map['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'regularVisitId': this.regularVisitId,
      'frames': this.frames,
      'stairs': this.stairs,
      'status': this.status
    };
  }
}
