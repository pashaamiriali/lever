import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/usecases/delete_hive_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

main() {
  test('should call the delete hive function with proper id', () async {
    var hiveId = 'someId123';
    MockHiveRepo mockHiveRepo = MockHiveRepo();
    DeleteHiveCmnd deleteHiveCmnd = DeleteHiveCmnd(mockHiveRepo);
    await deleteHiveCmnd.execute({'hive_id': hiveId});
    expect(verify(mockHiveRepo.deleteHive(captureAny)).captured[0], hiveId);
  });
}
