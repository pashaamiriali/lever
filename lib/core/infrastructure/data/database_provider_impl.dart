// import 'package:lever/core/infrastructure/data/database_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseWrapperImpl implements DatabaseWrapper {
//   final Database _db;

//   DatabaseWrapperImpl(this._db);

//   @override
//   Future<int> insert(Map<String, dynamic> tableData) async {
//     return await _db.insert(tableData['table'], tableData['tableData']);
//   }

//   @override
//   Future<List<Map<String, dynamic>>> select(
//       Map<String, dynamic> selectInfo) async {
//     return await _db.query(selectInfo['table']);
//   }

//   @override
//   Future<Map<String, dynamic>> selectFirst(
//       Map<String, dynamic> selectInfo) async {
//     List<Map> result = await _db.query(selectInfo['table'],
//         where: selectInfo['where'],
//         whereArgs: selectInfo['whereArgs'],
//         orderBy: selectInfo['orderBy'],
//         limit: 1);
//     if (result.isEmpty) return null;
//     return result[0];
//   }
// }
