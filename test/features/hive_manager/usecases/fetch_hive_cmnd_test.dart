import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hive_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

void main() {
  var mockHiveRepo = MockHiveRepo();
  test('should return the given list of hives from repo', () async {
    FetchHiveCmnd cmnd = FetchHiveCmnd(mockHiveRepo);
    var hive = Hive(
        '123',
        1234,
        44,
        'test',
        '',
        PopulationInfo('223f', 'rv2153425', 20, 2, 'OK'),
        QueenInfo(
          '32234f',
          '34534d',
          DateTime.utc(1996),
          'breed',
          'blue',
        ),
        []);
    when(mockHiveRepo.fetchHive(hive.id)).thenAnswer((realInvocation) => hive);
    var result = await cmnd.execute({'hive_id': hive.id});
    expect(result, hive);
  });
}
