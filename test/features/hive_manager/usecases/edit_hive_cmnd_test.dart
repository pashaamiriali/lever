import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/edit_hive_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

void main() {
  MockHiveRepo mockHiveRepo = MockHiveRepo();
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
  test('should call the editHive,editPopulationInfo and editQueenInfo in a row',
      () async {
    EditHiveCmnd editHiveCmnd = EditHiveCmnd(mockHiveRepo);
    await editHiveCmnd.execute({'hive': hive});
    verify(mockHiveRepo.editHive(any));
    verify(mockHiveRepo.editPopulationInfo(any));
    verify(mockHiveRepo.editQueenInfo(any));
  });
}
