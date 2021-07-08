import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/entities/regular_visit.dart';
import 'package:lever/features/hive_management/domain/usecases/regular_hive_visit_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockVisitRepo extends Mock implements VisitRepo {}

void main() {
  MockVisitRepo visitRepo = MockVisitRepo();
  test('should call the saveRegularVisit with correct arguments', () async {
    RegularHiveVisitCmnd cmnd = RegularHiveVisitCmnd(visitRepo);
    var visit = RegularVisit(
      null,
      'someId3234',
      DateTime.now(),
      ['something.jpg'],
      'some desc',
      'Calm',
      true,
      'Good',
      PopulationInfo(null, null, 24, 3, 'Strong'),
    );

    await cmnd.execute({'regular_visit': visit});
    verify(visitRepo.saveRegularVisit(visit));
  });
}
