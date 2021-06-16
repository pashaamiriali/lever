import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/usecases/generate_hive_number_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

main() {
  MockHiveRepo mockHiveRepo = MockHiveRepo();
  test('should return a number +1 greater than the number taken from the repo',
      () async {
    var command = GenerateHiveNumberCmnd(mockHiveRepo);
    int expectedNumber = 2223;
    when(mockHiveRepo.fetchLastHiveNumber())
        .thenAnswer((realInvocation) async => expectedNumber - 1);
    var result = await command.execute(null);
    verify(mockHiveRepo.fetchLastHiveNumber());
    expect(result, expectedNumber);
  });
  test('should return 1001 when there is no record available', () async {
    var command = GenerateHiveNumberCmnd(mockHiveRepo);
    int expectedNumber = 1001;
    when(mockHiveRepo.fetchLastHiveNumber())
        .thenAnswer((realInvocation) async => null);
    var result = await command.execute(null);
    verify(mockHiveRepo.fetchLastHiveNumber());
    expect(result, expectedNumber);
  });
}
