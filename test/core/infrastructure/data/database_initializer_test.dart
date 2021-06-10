import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/infrastructure/data/database_initializer.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  test('should call the execute method as many as the tables in the list',
      () async {
    MockDatabase mockDatabase = MockDatabase();
    await DatabaseInitializer.createTables(mockDatabase);
    expect(verify(mockDatabase.execute(any)).callCount,
        DatabaseInitializer.tables.length);
  });
}
