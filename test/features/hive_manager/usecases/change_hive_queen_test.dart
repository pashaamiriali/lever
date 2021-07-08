import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';
import 'package:lever/features/hive_management/domain/entities/change_queen.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';

class MockVisitRepo extends Mock implements VisitRepo {}

void main() {
  MockVisitRepo repo = MockVisitRepo();
  test('should call saveChangeQueen with proper arguments', () async {
    ChangeQueen visit = ChangeQueen(
        null,
        'someId1234',
        DateTime.now(),
        ['something.jpg'],
        'some desc',
        QueenInfo(null, null, DateTime.now(), 'Some breed', '4000'));
    ChangeHiveQueenCmnd cmnd = ChangeHiveQueenCmnd(repo);
    await cmnd.execute({'change_queen': visit});
    expect(verify(repo.saveChangeQueen(captureAny)).captured[0].toMap(),
        visit.toMap());
  });
}
