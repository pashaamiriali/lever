import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';

class MockVisitRepo extends Mock implements VisitRepo {}

void main() {
  MockVisitRepo visitRepo = MockVisitRepo();
  test('should call the saveRegularVisit with correct arguments', () async {
    HarvestHiveHoneyCmnd cmnd = HarvestHiveHoneyCmnd(visitRepo);
    var visit = HarvestHoney(null, 'someId3234', DateTime.now(),
        ['something.jpg'], 'some desc', 'High', 3, 12, 'Good');

    await cmnd.execute({'harvest_honey': visit});
    verify(visitRepo.saveHarvestHoney(visit));
  });
}
