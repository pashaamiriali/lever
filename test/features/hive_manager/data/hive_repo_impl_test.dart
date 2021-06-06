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
  group('saveHive', () {
    test('should call insert (for hive) with proper mapped value', () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      var properHiveMap = {
        'table': 'hives',
        'tableData': {
          'id': 'someId3234',
          'number': 1234,
          'annualHoney': 34,
          'description': 'some desc',
          'picture': 'picturePath',
        }
      };
      Hive hive =
          Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
      var populationInfo =
          PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
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
        'table': 'regularVisits',
        'tableData': {
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
      var populationInfo =
          PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
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
    test('should call insert (for population info) with proper mapped value',
        () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

      var properPopulationInfoMap = {
        'table': 'populationInfos',
        'tableData': {
          'id': 'someId3234',
          'regularVisitId': 'someId3234',
          'frames': 20,
          'stairs': 2,
          'status': 'good'
        }
      };
      Hive hive =
          Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
      var populationInfo =
          PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
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
        'table': 'changeQueens',
        'tableData': {
          'id': 'someId3234',
          'hiveId': 'someId3234',
          'date': currentDateTime,
          'pictures': null,
          'description': '',
        }
      };
      Hive hive =
          Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
      var populationInfo =
          PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
      var queenInfo = QueenInfo(
        null,
        null,
        DateTime.now(),
        'breed',
        'black',
      );
      when(idGen.generateId()).thenReturn('someId3234');
      impl.saveHive(hive, populationInfo, queenInfo);
      expect(verify(dbWrapper.insert(captureAny)).captured[3],
          properChangeQueenMap);
    });
    test('should call insert (for queen info) with proper mapped value', () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

      var properQueenInfo = {
        'table': 'queenInfos',
        'tableData': {
          'id': 'someId3234',
          'changeQueenId': 'someId3234',
          'enterDate': currentDateTime,
          'breed': 'breed',
          'backColor': 'black'
        }
      };
      Hive hive =
          Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
      var populationInfo =
          PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
      var queenInfo = QueenInfo(
        null,
        'changeQueenId',
        currentDateTime,
        'breed',
        'black',
      );
      when(idGen.generateId()).thenReturn('someId3234');
      impl.saveHive(hive, populationInfo, queenInfo);
      expect(verify(dbWrapper.insert(captureAny)).captured[4], properQueenInfo);
    });
    test(
        'should return with a hive object that has an id and with inner objects that have ids',
        () async {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      Hive hive =
          Hive(null, 1234, 34, 'some desc', 'picturePath', null, null, null);
      var populationInfo =
          PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
      var queenInfo = QueenInfo(
        null,
        null,
        currentDateTime,
        'breed',
        'black',
      );
      when(idGen.generateId()).thenReturn('someId3234');
      Hive result = await impl.saveHive(hive, populationInfo, queenInfo);
      expect(result.id, 'someId3234');
      expect(result.populationInfo.id, 'someId3234');
      expect(result.populationInfo.regularVisitId, 'someId3234');
      expect(result.queenInfo.id, 'someId3234');
      expect(result.queenInfo.changeQueenId, 'someId3234');
    });
  });
  group('fetchHives', () {
    when(dbWrapper.select({'table': 'hives'})).thenAnswer((realInvocation) => [
          {
            'id': 'someId3234',
            'number': 1234,
            'annualHoney': 34,
            'description': 'some desc',
            'picture': 'picturePath',
          }
        ]);
    when(
      dbWrapper.selectFirst(
        {
          'table': 'regularVisits',
          'where': 'hiveId = ?',
          'whereArgs': ['someId3234'],
          'orderBy': 'date DEC'
        },
      ),
    ).thenAnswer((realInvocation) => {
          'id': 'someId3234',
          'hiveId': 'someId3234',
          'date': currentDateTime,
          'pictures': ['picturePath1', 'picturePath2'],
          'description': 'some desc',
          'queenSeen': true,
          'honeyMaking': 'good',
          'behavior': 'calm'
        });
    when(
      dbWrapper.selectFirst(
        {
          'table': 'populationInfos',
          'where': 'regularVisitId = ?',
          'whereArgs':['someId3234'],
        },
      ),
    ).thenAnswer((realInvocation) => {
          'id': 'someId3234',
          'regularVisitId': 'someId3234',
          'frames': 20,
          'stairs': 2,
          'status': 'strong'
        });
    when(
      dbWrapper.selectFirst(
        {
          'table': 'changeQueens',
          'where': 'hiveId = ?',
          'whereArgs':['someId3234'],
          'orderBy': 'date DEC'
        },
      ),
    ).thenAnswer((realInvocation) => {
          'id': 'someId3234',
          'hiveId': 'someId3234',
          'date': currentDateTime,
          'pictures': ['picturePath1', 'picturePath2'],
          'description': 'some desc',
        });
    when(
      dbWrapper.selectFirst(
        {
          'table': 'queenInfos',
          'where': 'changeQueenId = ?',
          'whereArgs': ['someId3234'],
        },
      ),
    ).thenAnswer((realInvocation) => {
          'id': 'someId3234',
          'changeQueenId': 'someId3234',
          'enterDate': currentDateTime,
          'breed': 'some breed name',
          'backColor': 'purple',
        });
    test('should call select on dbWrapper with proper args', () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);

      impl.fetchHives();
      var correctMap = {'table': 'hives'};
      expect(verify(dbWrapper.select(captureAny)).captured[0], correctMap);
    });
    test('should call selectFirst (latest regularVisit) for each hive record',
        () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      impl.fetchHives();
      var correctMap = {
        'table': 'regularVisits',
        'where': 'hiveId = ?',
        'whereArgs': ['someId3234'],
        'orderBy': 'date DEC'
      };
      expect(verify(dbWrapper.selectFirst(captureAny)).captured[0], correctMap);
    });
    test('should call selectFirst (latest populationInfo) for each hive record',
        () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      impl.fetchHives();
      var correctMap = {
        'table': 'populationInfos',
        'where': 'regularVisitId = ?',
        'whereArgs':['someId3234']
      };
      expect(verify(dbWrapper.selectFirst(captureAny)).captured[1], correctMap);
    });
    test('should call selectFirst (latest changeQueen) for each hive record',
        () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      impl.fetchHives();
      var correctMap = {
        'table': 'changeQueens',
        'where': 'hiveId = ?',
        'whereArgs': ['someId3234'],
        'orderBy': 'date DEC'
      };
      expect(verify(dbWrapper.selectFirst(captureAny)).captured[2], correctMap);
    });
    test('should call selectFirst (latest queenInfo) for each hive record', () {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      impl.fetchHives();
      var correctMap = {
        'table': 'queenInfos',
        'where': 'changeQueenId = ?',
        'whereArgs': ['someId3234']
      };
      expect(verify(dbWrapper.selectFirst(captureAny)).captured[3], correctMap);
    });
    test('should return a list of hive object with all the correct given data',
        () async {
      HiveRepoImpl impl = HiveRepoImpl(dbWrapper, idGen, dateTimeProvider);
      var correctPopulationInfo =
          PopulationInfo('someId3234', 'someId3234', 20, 2, 'strong');
      var correctQueenInfo = QueenInfo('someId3234', 'someId3234',
          currentDateTime, 'some breed name', 'purple');
      var correctRegularVisit = RegularVisit(
          'someId3234',
          'someId3234',
          currentDateTime,
          ['picturePath1', 'picturePath2'],
          'some desc',
          'calm',
          true,
          'good',
          correctPopulationInfo);
      var correctChangeQueen = ChangeQueen(
          'someId3234',
          'someId3234',
          currentDateTime,
          ['picturePath1', 'picturePath2'],
          'some desc',
          correctQueenInfo);
      var correctHivesList = [
        Hive(
            'someId3234',
            1234,
            34,
            'some desc',
            'picturePath',
            correctPopulationInfo,
            correctQueenInfo,
            [correctRegularVisit, correctChangeQueen])
      ];
      List<Hive> result = await impl.fetchHives();
      expect(result[0].toMap(), correctHivesList[0].toMap());
    });
  });
}
