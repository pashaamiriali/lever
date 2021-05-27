import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/infrastructure/data/database_provider.dart';
import 'package:lever/core/infrastructure/data/date_time_provider.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/features/hive_management/data/hive_repo_impl.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:mockito/mockito.dart';

class MockDatabaseWrapper extends Mock implements DatabaseWrapper {}

class MockIDGen extends Mock implements IDGen {}

class MockDateTimeProvider extends Mock implements DateTimeProvider {}

void main() {
  MockDatabaseWrapper dbWrapper = MockDatabaseWrapper();
  MockIDGen idGen = MockIDGen();
  MockDateTimeProvider dateTimeProvider = MockDateTimeProvider();
  var currentDateTime = DateTime.now();
  when(dateTimeProvider.getCurrentDateTime()).thenReturn(currentDateTime);
  test('should call insert (for hive) with proper mapped value', () {
    HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
    var properHiveMap = {
      'hives': {
        'id': 'someId3234',
        'number': 1234,
        'annualHoney': 34,
        'description': 'some desc',
        'picture': 'picturePath',
      }
    };
    Hive hive =
        Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      'changeQueenId',
      DateTime.now(),
      'breed',
      'black',
    );
    when(idGen.generateId()).thenReturn('someId3234');
    impl.saveHive(hive, populationInfo, queenInfo);
    expect(verify(dbWrapper.insert(captureAny)).captured[0], properHiveMap);
  });
  test('should call insert (for regular visit) with proper mapped value', () {
    HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

    var properRegularVisitMap = {
      'regularVisits': {
        'id': 'someId3234',
        'hiveId': 'someId3234',
        'date': currentDateTime,
        'pictures': null,
        'description': '',
        'behavior': '',
        'queenSeen': true,
        'honeyMaking': ''
      }
    };
    Hive hive =
        Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      'changeQueenId',
      DateTime.now(),
      'breed',
      'black',
    );
    when(idGen.generateId()).thenReturn('someId3234');
    impl.saveHive(hive, populationInfo, queenInfo);
    expect(verify(dbWrapper.insert(captureAny)).captured[1],
        properRegularVisitMap);
  });
  test('should call insert (for population info) with proper mapped value', () {
    HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

    var properPopulationInfoMap = {
      'populationInfos': {
        'id': 'someId3234',
        'regularVisitId': 'someId3234',
        'frames': 20,
        'stairs': 2,
        'status': 'good'
      }
    };
    Hive hive =
        Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      'changeQueenId',
      DateTime.now(),
      'breed',
      'black',
    );
    when(idGen.generateId()).thenReturn('someId3234');
    impl.saveHive(hive, populationInfo, queenInfo);
    expect(verify(dbWrapper.insert(captureAny)).captured[2],
        properPopulationInfoMap);
  });
  test('should call insert (for change queen) with proper mapped value', () {
    HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

    var properChangeQueenMap = {
      'changeQueens': {
        'id': 'someId3234',
        'hiveId': 'someId3234',
        'date': currentDateTime,
        'pictures': null,
        'description': '',
      }
    };
    Hive hive =
        Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      null,
      DateTime.now(),
      'breed',
      'black',
    );
    when(idGen.generateId()).thenReturn('someId3234');
    impl.saveHive(hive, populationInfo, queenInfo);
    expect(
        verify(dbWrapper.insert(captureAny)).captured[3], properChangeQueenMap);
  });
  test('should call insert (for queen info) with proper mapped value', () {
    HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

    var properQueenInfo = {
      'queenInfos': {
        'id': 'someId3234',
        'changeQueenId': 'someId3234',
        'enterDate': currentDateTime,
        'breed': 'breed',
        'backColor': 'black'
      }
    };
    Hive hive =
        Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      'changeQueenId',
      currentDateTime,
      'breed',
      'black',
    );
    when(idGen.generateId()).thenReturn('someId3234');
    impl.saveHive(hive, populationInfo, queenInfo);
    expect(verify(dbWrapper.insert(captureAny)).captured[4],
        properQueenInfo);
  }); test('should return with a hive object that has an id and with inner objects that have ids', () async {
    HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
    Hive hive =
        Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      null,
      currentDateTime,
      'breed',
      'black',
    );
    when(idGen.generateId()).thenReturn('someId3234');
    Hive result=await impl.saveHive(hive, populationInfo, queenInfo);
    expect(result.id,'someId3234');
    expect(result.populationInfo.id,'someId3234');
    expect(result.populationInfo.regularVisitId,'someId3234');
    expect(result.queenInfo.id,'someId3234');
    expect(result.queenInfo.changeQueenId,'someId3234');
  });
}
