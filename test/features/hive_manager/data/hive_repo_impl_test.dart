import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/infrastructure/data/date_time_provider.dart';
import 'package:lever/core/infrastructure/data/id_generator.dart';
import 'package:lever/core/infrastructure/data/moor_db/app_database.dart';
import 'package:lever/features/hive_management/data/hive_repo_impl.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:mockito/mockito.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockIdGen extends Mock implements IDGen {}

class MockDateTimeProvider extends Mock implements DateTimeProvider {}

main() {
  group('fetchHives', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    when(mockDateTimeProvider.getCurrentDateTime()).thenReturn(DateTime.now());
    THive exampleHiveRecord = THive(
        id: 'someId123',
        number: 1234,
        annualHoney: 60,
        description: 'some desc',
        picture: 'aPicture.jpg');
    TRegularVisit exampleRegularVisitRecord = TRegularVisit(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc',
        behavior: 'Calm',
        queenSeen: true,
        honeyMaking: 'Good');
    THarvestHoney exampleHarvestHoneyRecord = THarvestHoney(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc',
        describedAmount: 'Good',
        frames: 4,
        quality: 'Good',
        weight: 12);
    TChangeQueen exampleChangeQueenRecord = TChangeQueen(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc');
    TPopulationInfo examplePopulationInfoRecord = TPopulationInfo(
        id: 'someId123',
        regularVisitId: 'someId123',
        frames: 20,
        stairs: 2,
        status: 'Strong');
    TQueenInfo exampleQueenInfoRecord = TQueenInfo(
        id: 'someId123',
        changeQueenId: 'someId123',
        enterDate: mockDateTimeProvider.getCurrentDateTime(),
        breed: 'Karnika',
        backColor: 'Black');
    RegularVisit exampleRegularVisit = RegularVisit(
      exampleRegularVisitRecord.id,
      exampleRegularVisitRecord.hiveId,
      exampleRegularVisitRecord.date,
      (json.decode(exampleRegularVisitRecord.pictures) as List<dynamic>)
          .cast<String>(),
      exampleRegularVisitRecord.description,
      exampleRegularVisitRecord.behavior,
      exampleRegularVisitRecord.queenSeen,
      exampleRegularVisitRecord.honeyMaking,
      PopulationInfo(
          examplePopulationInfoRecord.id,
          examplePopulationInfoRecord.regularVisitId,
          examplePopulationInfoRecord.frames,
          examplePopulationInfoRecord.stairs,
          examplePopulationInfoRecord.status),
    );
    HarvestHoney exampleHarvestHoney = HarvestHoney(
        exampleHarvestHoneyRecord.id,
        exampleHarvestHoneyRecord.hiveId,
        exampleHarvestHoneyRecord.date,
        (json.decode(exampleHarvestHoneyRecord.pictures) as List<dynamic>)
            .cast<String>(),
        exampleHarvestHoneyRecord.description,
        exampleHarvestHoneyRecord.describedAmount,
        exampleHarvestHoneyRecord.frames,
        exampleHarvestHoneyRecord.weight,
        exampleHarvestHoneyRecord.quality);
    ChangeQueen exampleChangeQueen = ChangeQueen(
      exampleRegularVisitRecord.id,
      exampleRegularVisitRecord.hiveId,
      exampleRegularVisitRecord.date,
      (json.decode(exampleRegularVisitRecord.pictures) as List<dynamic>)
          .cast<String>(),
      exampleRegularVisitRecord.description,
      QueenInfo(
          exampleQueenInfoRecord.id,
          exampleQueenInfoRecord.changeQueenId,
          exampleQueenInfoRecord.enterDate,
          exampleQueenInfoRecord.breed,
          exampleQueenInfoRecord.backColor),
    );

    Hive exampleHive = Hive(
        exampleHiveRecord.id,
        exampleHiveRecord.number,
        exampleHiveRecord.annualHoney,
        exampleHiveRecord.description,
        exampleHiveRecord.picture,
        exampleRegularVisit.populationInfo,
        exampleChangeQueen.queenInfo, [
      exampleRegularVisit,
      exampleChangeQueen,
      exampleHarvestHoney,
    ]);
    when(mockAppDatabase.allHives)
        .thenAnswer((realInvocation) async => [exampleHiveRecord]);
    when(mockAppDatabase.getLastPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getLastQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    when(mockAppDatabase.getHiveChangeQueens(any))
        .thenAnswer((realInvocation) async => [exampleChangeQueenRecord]);
    when(mockAppDatabase.getHiveRegularVisits(any))
        .thenAnswer((realInvocation) async => [exampleRegularVisitRecord]);
    when(mockAppDatabase.getHiveHarvestHoneys(any))
        .thenAnswer((realInvocation) async => [exampleHarvestHoneyRecord]);
    when(mockAppDatabase.getPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    test('should return a list of hives', () async {
      HiveRepoImpl hiveRepoImpl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      List<Hive> result = await hiveRepoImpl.fetchHives();
      expect(result[0].toMap(), exampleHive.toMap());
    });
  });
  group('fetchHive', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    when(mockDateTimeProvider.getCurrentDateTime()).thenReturn(DateTime.now());
    THive exampleHiveRecord = THive(
        id: 'someId123',
        number: 1234,
        annualHoney: 60,
        description: 'some desc',
        picture: 'aPicture.jpg');
    TRegularVisit exampleRegularVisitRecord = TRegularVisit(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc',
        behavior: 'Calm',
        queenSeen: true,
        honeyMaking: 'Good');
    THarvestHoney exampleHarvestHoneyRecord = THarvestHoney(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc',
        describedAmount: 'Good',
        frames: 4,
        quality: 'Good',
        weight: 12);
    TChangeQueen exampleChangeQueenRecord = TChangeQueen(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc');
    TPopulationInfo examplePopulationInfoRecord = TPopulationInfo(
        id: 'someId123',
        regularVisitId: 'someId123',
        frames: 20,
        stairs: 2,
        status: 'Strong');
    TQueenInfo exampleQueenInfoRecord = TQueenInfo(
        id: 'someId123',
        changeQueenId: 'someId123',
        enterDate: mockDateTimeProvider.getCurrentDateTime(),
        breed: 'Karnika',
        backColor: 'Black');
    RegularVisit exampleRegularVisit = RegularVisit(
      exampleRegularVisitRecord.id,
      exampleRegularVisitRecord.hiveId,
      exampleRegularVisitRecord.date,
      (json.decode(exampleRegularVisitRecord.pictures) as List<dynamic>)
          .cast<String>(),
      exampleRegularVisitRecord.description,
      exampleRegularVisitRecord.behavior,
      exampleRegularVisitRecord.queenSeen,
      exampleRegularVisitRecord.honeyMaking,
      PopulationInfo(
          examplePopulationInfoRecord.id,
          examplePopulationInfoRecord.regularVisitId,
          examplePopulationInfoRecord.frames,
          examplePopulationInfoRecord.stairs,
          examplePopulationInfoRecord.status),
    );
    HarvestHoney exampleHarvestHoney = HarvestHoney(
        exampleHarvestHoneyRecord.id,
        exampleHarvestHoneyRecord.hiveId,
        exampleHarvestHoneyRecord.date,
        (json.decode(exampleHarvestHoneyRecord.pictures) as List<dynamic>)
            .cast<String>(),
        exampleHarvestHoneyRecord.description,
        exampleHarvestHoneyRecord.describedAmount,
        exampleHarvestHoneyRecord.frames,
        exampleHarvestHoneyRecord.weight,
        exampleHarvestHoneyRecord.quality);
    ChangeQueen exampleChangeQueen = ChangeQueen(
      exampleRegularVisitRecord.id,
      exampleRegularVisitRecord.hiveId,
      exampleRegularVisitRecord.date,
      (json.decode(exampleRegularVisitRecord.pictures) as List<dynamic>)
          .cast<String>(),
      exampleRegularVisitRecord.description,
      QueenInfo(
          exampleQueenInfoRecord.id,
          exampleQueenInfoRecord.changeQueenId,
          exampleQueenInfoRecord.enterDate,
          exampleQueenInfoRecord.breed,
          exampleQueenInfoRecord.backColor),
    );

    Hive exampleHive = Hive(
        exampleHiveRecord.id,
        exampleHiveRecord.number,
        exampleHiveRecord.annualHoney,
        exampleHiveRecord.description,
        exampleHiveRecord.picture,
        exampleRegularVisit.populationInfo,
        exampleChangeQueen.queenInfo, [
      exampleRegularVisit,
      exampleChangeQueen,
      exampleHarvestHoney,
    ]);
    when(mockAppDatabase.getHive(any))
        .thenAnswer((realInvocation) async => exampleHiveRecord);
    when(mockAppDatabase.getLastPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getLastQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    when(mockAppDatabase.getHiveChangeQueens(any))
        .thenAnswer((realInvocation) async => [exampleChangeQueenRecord]);
    when(mockAppDatabase.getHiveRegularVisits(any))
        .thenAnswer((realInvocation) async => [exampleRegularVisitRecord]);
    when(mockAppDatabase.getHiveHarvestHoneys(any))
        .thenAnswer((realInvocation) async => [exampleHarvestHoneyRecord]);
    when(mockAppDatabase.getPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    test('should return a hive', () async {
      HiveRepoImpl hiveRepoImpl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      Hive result = await hiveRepoImpl.fetchHive(exampleHive.id);
      expect(result.toMap(), exampleHive.toMap());
    });
  });
  group('fetchVisits', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    when(mockDateTimeProvider.getCurrentDateTime()).thenReturn(DateTime.now());
    THive exampleHiveRecord = THive(
        id: 'someId123',
        number: 1234,
        annualHoney: 60,
        description: 'some desc',
        picture: 'aPicture.jpg');
    TRegularVisit exampleRegularVisitRecord = TRegularVisit(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc',
        behavior: 'Calm',
        queenSeen: true,
        honeyMaking: 'Good');
    THarvestHoney exampleHarvestHoneyRecord = THarvestHoney(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc',
        describedAmount: 'Good',
        frames: 4,
        quality: 'Good',
        weight: 12);
    TChangeQueen exampleChangeQueenRecord = TChangeQueen(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some desc');
    TPopulationInfo examplePopulationInfoRecord = TPopulationInfo(
        id: 'someId123',
        regularVisitId: 'someId123',
        frames: 20,
        stairs: 2,
        status: 'Strong');
    TQueenInfo exampleQueenInfoRecord = TQueenInfo(
        id: 'someId123',
        changeQueenId: 'someId123',
        enterDate: mockDateTimeProvider.getCurrentDateTime(),
        breed: 'Karnika',
        backColor: 'Black');
    RegularVisit exampleRegularVisit = RegularVisit(
      exampleRegularVisitRecord.id,
      exampleRegularVisitRecord.hiveId,
      exampleRegularVisitRecord.date,
      (json.decode(exampleRegularVisitRecord.pictures) as List<dynamic>)
          .cast<String>(),
      exampleRegularVisitRecord.description,
      exampleRegularVisitRecord.behavior,
      exampleRegularVisitRecord.queenSeen,
      exampleRegularVisitRecord.honeyMaking,
      PopulationInfo(
          examplePopulationInfoRecord.id,
          examplePopulationInfoRecord.regularVisitId,
          examplePopulationInfoRecord.frames,
          examplePopulationInfoRecord.stairs,
          examplePopulationInfoRecord.status),
    );
    HarvestHoney exampleHarvestHoney = HarvestHoney(
        exampleHarvestHoneyRecord.id,
        exampleHarvestHoneyRecord.hiveId,
        exampleHarvestHoneyRecord.date,
        (json.decode(exampleHarvestHoneyRecord.pictures) as List<dynamic>)
            .cast<String>(),
        exampleHarvestHoneyRecord.description,
        exampleHarvestHoneyRecord.describedAmount,
        exampleHarvestHoneyRecord.frames,
        exampleHarvestHoneyRecord.weight,
        exampleHarvestHoneyRecord.quality);
    ChangeQueen exampleChangeQueen = ChangeQueen(
      exampleRegularVisitRecord.id,
      exampleRegularVisitRecord.hiveId,
      exampleRegularVisitRecord.date,
      (json.decode(exampleRegularVisitRecord.pictures) as List<dynamic>)
          .cast<String>(),
      exampleRegularVisitRecord.description,
      QueenInfo(
          exampleQueenInfoRecord.id,
          exampleQueenInfoRecord.changeQueenId,
          exampleQueenInfoRecord.enterDate,
          exampleQueenInfoRecord.breed,
          exampleQueenInfoRecord.backColor),
    );

    Hive exampleHive = Hive(
        exampleHiveRecord.id,
        exampleHiveRecord.number,
        exampleHiveRecord.annualHoney,
        exampleHiveRecord.description,
        exampleHiveRecord.picture,
        exampleRegularVisit.populationInfo,
        exampleChangeQueen.queenInfo, [
      exampleRegularVisit,
      exampleChangeQueen,
      exampleHarvestHoney,
    ]);
    when(mockAppDatabase.getHive(any))
        .thenAnswer((realInvocation) async => exampleHiveRecord);
    when(mockAppDatabase.getLastPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getLastQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    when(mockAppDatabase.getHiveChangeQueens(any))
        .thenAnswer((realInvocation) async => [exampleChangeQueenRecord]);
    when(mockAppDatabase.getHiveRegularVisits(any))
        .thenAnswer((realInvocation) async => [exampleRegularVisitRecord]);
    when(mockAppDatabase.getHiveHarvestHoneys(any))
        .thenAnswer((realInvocation) async => [exampleHarvestHoneyRecord]);
    when(mockAppDatabase.getPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    test('should return a list of visits with the proper Id given', () async {
      HiveRepoImpl hiveRepoImpl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      var result = await hiveRepoImpl.fetchVisits(exampleHive.id);
      expect(result.runtimeType,
          [exampleRegularVisit, exampleChangeQueen].runtimeType);
    });
  });
  group('deleteHive', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    test('should call teh deleteHive method with proper id', () async {
      HiveRepoImpl impl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      var hiveId = 'someId123';
      await impl.deleteHive(hiveId);
      expect(
          verify(
            mockAppDatabase.deleteHive(captureAny),
          ).captured[0],
          hiveId);
    });
  });
  group('editHive', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    test('should call the updateHive method on the database', () async {
      HiveRepoImpl impl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      await impl
          .editHive(Hive('someId', null, null, null, null, null, null, null));
      expect(verify(mockAppDatabase.updateHive(captureAny)).captured[0],
          TypeMatcher<THive>());
    });
  });
  group('editPopulationInfo', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    test('should call the updatePopulationInfo method on the database',
        () async {
      HiveRepoImpl impl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      await impl
          .editPopulationInfo(PopulationInfo('someId', null, null, null, null));
      expect(
          verify(mockAppDatabase.updatePopulationInfo(captureAny)).captured[0],
          TypeMatcher<TPopulationInfo>());
    });
  });
  group('editQueenInfo', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    test('should call the updateQueenInfo method on the database', () async {
      HiveRepoImpl impl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      await impl.editQueenInfo(QueenInfo('someId', null, null, null, null));
      expect(verify(mockAppDatabase.updateQueenInfo(captureAny)).captured[0],
          TypeMatcher<TQueenInfo>());
    });
  });
  group('searchHives', () {
    MockAppDatabase mockAppDatabase = MockAppDatabase();
    MockIdGen mockIdGen = MockIdGen();
    MockDateTimeProvider mockDateTimeProvider = MockDateTimeProvider();
    when(mockDateTimeProvider.getCurrentDateTime()).thenReturn(DateTime.now());
    THive exampleHiveRecord = THive(
        id: 'someId123',
        number: 1234,
        annualHoney: 60,
        description: 'some desc',
        picture: 'aPicture.jpg');
    TRegularVisit exampleRegularVisitRecord = TRegularVisit(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some visit desc',
        behavior: 'Calm',
        queenSeen: true,
        honeyMaking: 'Good');
    THarvestHoney exampleHarvestHoneyRecord = THarvestHoney(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some visit desc',
        describedAmount: 'Good',
        frames: 4,
        quality: 'Good',
        weight: 12);
    TChangeQueen exampleChangeQueenRecord = TChangeQueen(
        id: 'someId123',
        hiveId: 'someId123',
        date: mockDateTimeProvider.getCurrentDateTime(),
        pictures: '[]',
        description: 'some visit desc');
    TPopulationInfo examplePopulationInfoRecord = TPopulationInfo(
        id: 'someId123',
        regularVisitId: 'someId123',
        frames: 20,
        stairs: 2,
        status: 'Strong');
    TQueenInfo exampleQueenInfoRecord = TQueenInfo(
        id: 'someId123',
        changeQueenId: 'someId123',
        enterDate: mockDateTimeProvider.getCurrentDateTime(),
        breed: 'Karnika',
        backColor: 'Black');
    when(mockAppDatabase.allHives)
        .thenAnswer((realInvocation) async => [exampleHiveRecord]);
    when(mockAppDatabase.getLastPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getLastQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);
    when(mockAppDatabase.getHiveChangeQueens(any))
        .thenAnswer((realInvocation) async => [exampleChangeQueenRecord]);
    when(mockAppDatabase.getHiveRegularVisits(any))
        .thenAnswer((realInvocation) async => [exampleRegularVisitRecord]);
    when(mockAppDatabase.getHiveHarvestHoneys(any))
        .thenAnswer((realInvocation) async => [exampleHarvestHoneyRecord]);
    when(mockAppDatabase.getPopulationInfo(any))
        .thenAnswer((realInvocation) async => examplePopulationInfoRecord);
    when(mockAppDatabase.getQueenInfo(any))
        .thenAnswer((realInvocation) async => exampleQueenInfoRecord);

    test('should return nothing on a no-match query', () async {
      String query = 'this is a no match query';
      HiveRepoImpl repo =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      var result = await repo.searchHives(query);
      expect(result.length, 0);
    });
    group('should return matching hives', () {
      test('should return matching number', () async {
        String query = '1234';
        HiveRepoImpl repo =
            HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].number.toString(), query);
      });
      test('should return matching description', () async {
        String query = 'some';
        HiveRepoImpl repo =
            HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].description.contains(query), true);
      });
      test('should return matching annual honey', () async {
        String query = '60';
        HiveRepoImpl repo =
            HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].annualHoney.toString(), query);
      });
    });
    group('should return hives with matching populationInfo', () {
      test('should return matching frames count', () async {
        String query = '20';
        HiveRepoImpl repo =
            HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].populationInfo.frames.toString(), query);
      });
      test('should return matching stairs count', () async {
        String query = '2';
        HiveRepoImpl repo =
            HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].populationInfo.stairs.toString(), query);
      });
      test('should return matching status', () async {
        String query = 'Strong';
        HiveRepoImpl repo =
            HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].populationInfo.status, query);
      });
    });
    group('should return hives with matching queenInfo', (){
      //TODO: Add matching date and color
      test('should return matching breed', () async {
        String query = 'Karnika';
        HiveRepoImpl repo =
        HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].queenInfo.breed, query);
      });
    });
    group('should return hives with matching visits',(){
      test('should return matching description', () async {
        String query = 'visit';
        HiveRepoImpl repo =
        HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        expect(result[0].visits[0].description.contains(query), true);
      });
      test('should return matching behavior', () async {
        String query = 'Calm';
        HiveRepoImpl repo =
        HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
        var result = await repo.searchHives(query);
        for(Visit visit in result[0].visits)
          if(visit is RegularVisit)
        expect(visit.behavior, query);
      });
    });
  });
}
