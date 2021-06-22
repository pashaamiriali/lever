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
    TChangeQueen exampleQueenSeenRecord = TChangeQueen(
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
        exampleChangeQueen.queenInfo,
        [exampleRegularVisit,exampleChangeQueen]);
    test('should return a list of hives', () async {
      HiveRepoImpl hiveRepoImpl =
          HiveRepoImpl(mockAppDatabase, mockIdGen, mockDateTimeProvider);
      when(mockAppDatabase.allHives)
          .thenAnswer((realInvocation) async => [exampleHiveRecord]);
      List<Hive> result = await hiveRepoImpl.fetchHives();
      expect(result[0].toMap(), exampleHive.toMap());
    });
  });
}
