class SelectData {
  final String table;
  final String where;
  final List<dynamic> whereArgs;
  final String orderBy;

  SelectData(this.table, this.where, this.whereArgs, this.orderBy);

  static SelectData fromMap(Map<String, dynamic> map) {
    return SelectData(
        map['table'], map['where'], map['whereArgs'], map['orderBy']);
  }

  Map<String, dynamic> toMap() {
    return {
      'table': this.table,
      'where': this.where,
      'whereArgs': this.whereArgs,
      'orderBy': this.orderBy
    };
  }
}
