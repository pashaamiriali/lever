import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/core/infrastructure/data/moor_db/app_database.dart';
import 'package:lever/features/hive_management/data/visit_repo_impl.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:mockito/mockito.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockIDGen extends Mock implements IDGen {}

void main() {
  group('saveRegularVisit', () {
    MockAppDatabase appDatabase = MockAppDatabase();
    MockIDGen idGen = MockIDGen();
    VisitRepoImpl impl = VisitRepoImpl(appDatabase, idGen);
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
    test(
        'should call the addRegularVisit and addPopulationInfo with proper arguments',
        () async {
      await impl.saveRegularVisit(visit);
      expect(verify(appDatabase.addRegularVisit(captureAny)).captured[0],
          TypeMatcher<TRegularVisitsCompanion>());
      expect(verify(appDatabase.addPopulationInfo(captureAny)).captured[0],
          TypeMatcher<TPopulationInfosCompanion>());
    });
  });
  group('saveHarvestHoney', () {
    MockAppDatabase appDatabase = MockAppDatabase();
    MockIDGen idGen = MockIDGen();
    VisitRepoImpl impl = VisitRepoImpl(appDatabase, idGen);
    var visit = HarvestHoney(null, 'someId2134', DateTime.now(),
        ['something.jpg'], 'some desc', 'Good', 5, 20, 'Good');
    test('should call the addHarvestHoney with proper arguments', () async {
      await impl.saveHarvestHoney(visit);
      expect(verify(appDatabase.addHarvestHoney(captureAny)).captured[0],
          TypeMatcher<THarvestHoneysCompanion>());
    });
  });
  group('saveChangeQueen', () {
    MockAppDatabase appDatabase = MockAppDatabase();
    MockIDGen idGen = MockIDGen();
    VisitRepoImpl impl = VisitRepoImpl(appDatabase, idGen);
    ChangeQueen visit = ChangeQueen(
        null,
        'someId1234',
        DateTime.now(),
        ['something.jpg'],
        'some desc',
        QueenInfo(null, null, DateTime.now(), 'Some breed', '4000'));
    test('should call addChangeQueen and addQueenInfo with proper arguments',
        () async {
      await impl.saveChangeQueen(visit);
      expect(verify(appDatabase.addChangeQueen(captureAny)).captured[0],
          TypeMatcher<TChangeQueensCompanion>());
      expect(verify(appDatabase.addQueenInfo(captureAny)).captured[0],
          TypeMatcher<TQueenInfosCompanion>());
    });
  });
}
