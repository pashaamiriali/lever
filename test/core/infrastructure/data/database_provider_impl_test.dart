// import 'package:flutter_test/flutter_test.dart';
// import 'package:lever/core/infrastructure/data/database_provider_impl.dart';
// import 'package:mockito/mockito.dart';
// import 'package:sqflite/sqflite.dart';

// class MockDatabase extends Mock implements Database {}

// void main() {
//   group('insert', () {
//     MockDatabase mockDatabase = MockDatabase();
//     DatabaseWrapperImpl dbWrapperImpl = DatabaseWrapperImpl(mockDatabase);
//     var properHiveMap = {
//       'table': 'hives',
//       'tableData': {
//         'id': 'someId3234',
//         'number': 1234,
//         'annualHoney': 34,
//         'description': 'some desc',
//         'picture': 'picturePath',
//       }
//     };
//     when(mockDatabase.insert(
//             properHiveMap['table'], properHiveMap['tableData']))
//         .thenAnswer((realInvocation) async => 1);
//     test('should call insert with proper map data and return the row id',
//         () async {
//       var result = await dbWrapperImpl.insert(properHiveMap);
//       verify(mockDatabase.insert(
//           properHiveMap['table'], properHiveMap['tableData']));
//       expect(result, 1);
//     });
//   });
//   group('selectFirst', () {
//     MockDatabase mockDatabase = MockDatabase();
//     DatabaseWrapperImpl dbWrapperImpl = DatabaseWrapperImpl(mockDatabase);
//     var currentDateTime = DateTime.now();
//     test(
//         'should process the mapped data to correct query and return the correct mapped row',
//         () async {
//       var queryMap = {
//         'table': 'regularVisits',
//         'where': 'hiveId = ?',
//         'whereArgs': ['someId3234'],
//         'orderBy': 'date DEC'
//       };
//       var expectedMap = {
//         'id': 'someId3234',
//         'hiveId': 'someId3234',
//         'date': currentDateTime,
//         'pictures': ['picturePath1', 'picturePath2'],
//         'description': 'some desc',
//         'queenSeen': true,
//         'honeyMaking': 'good',
//         'behavior': 'calm'
//       };
//       when(mockDatabase.query(queryMap['table'],
//               where: 'hiveId = ?',
//               whereArgs: ['someId3234'],
//               limit: 1,
//               orderBy: 'date DEC'))
//           .thenAnswer((realInvocation) async => [expectedMap]);
//       var result = await dbWrapperImpl.selectFirst(queryMap);
//       verify(mockDatabase.query(queryMap['table'],
//           where: 'hiveId = ?',
//           whereArgs: ['someId3234'],
//           limit: 1,
//           orderBy: 'date DEC'));
//       expect(result, expectedMap);
//     });
//     test('should return null when the database returns empty', () async {
//       var queryMap = {
//         'table': 'regularVisits',
//         'where': 'hiveId = ?',
//         'whereArgs': ['someId3234'],
//         'orderBy': 'date DEC'
//       };
//       when(mockDatabase.query(queryMap['table'],
//               where: 'hiveId = ?',
//               whereArgs: ['someId3234'],
//               limit: 1,
//               orderBy: 'date DEC'))
//           .thenAnswer((realInvocation) async => []);
//       var result = await dbWrapperImpl.selectFirst(queryMap);
//       verify(mockDatabase.query(queryMap['table'],
//           where: 'hiveId = ?',
//           whereArgs: ['someId3234'],
//           limit: 1,
//           orderBy: 'date DEC'));
//       expect(result, null);
//     });
//   });
//   group('select', () {
//     MockDatabase mockDatabase = MockDatabase();
//     DatabaseWrapperImpl dbWrapperImpl = DatabaseWrapperImpl(mockDatabase);
//     test('should return the correct list with the given selectInfo', () async {
//       var queryMap = {'table': 'hives'};
//       var expectedList = [
//         {
//           'id': 'someId3234',
//           'number': 1234,
//           'annualHoney': 34,
//           'description': 'some desc',
//           'picture': 'picturePath',
//         }
//       ];
//       when(mockDatabase.query(queryMap['table']))
//           .thenAnswer((realInvocation) async => expectedList);
//       var result = await dbWrapperImpl.select(queryMap);
//       verify(mockDatabase.query(queryMap['table']));
//       expect(result, expectedList);
//     });
//   });
// }
main() {}
