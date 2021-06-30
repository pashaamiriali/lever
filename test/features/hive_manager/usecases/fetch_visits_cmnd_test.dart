import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_hives_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/fetch_visits_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

void main() {
  var mockHiveRepo = MockHiveRepo();
  test('should return the given list of visits from repo with correct id',
      () async {
    FetchVisitsCmnd cmnd = FetchVisitsCmnd(mockHiveRepo);
    var hiveId = 'someId325';
    var visits = [
      RegularVisit(
          'someId324',
          hiveId,
          DateTime.now(),
          ['pic'],
          'someDesc',
          'calm',
          true,
          'good',
          PopulationInfo('someId', 'someId324', 24, 2, 'strong'))
    ];
    when(mockHiveRepo.fetchVisits(hiveId))
        .thenAnswer((realInvocation) => visits);
    var result = await cmnd.execute({'hive_id': hiveId});
    expect(result, visits);
  });
}
