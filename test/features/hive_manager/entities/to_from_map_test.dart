import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';

void main() {
  group('toMap', () {
    test('should return the correct map based on object populationInfo', () {
      var expectedMap = {
        'id': 'someId1234',
        'regularVisitId': 'someId1234',
        'frames': 20,
        'stairs': 2,
        'status': 'Strong'
      };
      var result = PopulationInfo(
              expectedMap['id'],
              expectedMap['regularVisitId'],
              expectedMap['frames'],
              expectedMap['stairs'],
              expectedMap['status'])
          .toMap();
      expect(result, expectedMap);
    });
    test('should return the correct map based on object queenInfo', () {
      var expectedMap = {
        'id': 'someId1234',
        'changeQueenId': 'someId1234',
        'enterDate': DateTime.now(),
        'breed': 'some breed name',
        'backColor': 'red'
      };
      var result = QueenInfo(
              expectedMap['id'],
              expectedMap['changeQueenId'],
              expectedMap['enterDate'],
              expectedMap['breed'],
              expectedMap['backColor'])
          .toMap();
      expect(result, expectedMap);
    });
    test('should return the correct map based on object regularVisit', () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
        'behavior': 'calm',
        'queenSeen': true,
        'honeyMaking': 'good',
        'populationInfo': null,
      };
      var result = RegularVisit(
              expectedMap['id'],
              expectedMap['hiveId'],
              expectedMap['date'],
              (json.decode(expectedMap['pictures']) as List<dynamic>)
                  .cast<String>(),
              expectedMap['description'],
              expectedMap['behavior'],
              expectedMap['queenSeen'],
              expectedMap['honeyMaking'],
              expectedMap['populationInfo'])
          .toMap();
      expect(result, expectedMap);
    });
    test('should return the correct map based on object changeQueen', () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
        'queenInfo': null,
      };
      var result = ChangeQueen(
              expectedMap['id'],
              expectedMap['hiveId'],
              expectedMap['date'],
              (json.decode(expectedMap['pictures']) as List<dynamic>)
                  .cast<String>(),
              expectedMap['description'],
              expectedMap['queenInfo'])
          .toMap();
      expect(result, expectedMap);
    });
    test('should return the correct map based on object harvestHoney', () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
        'describedAmount': 'good',
        'frames': 10,
        'weight': 40,
        'quality': 'good',
      };
      var result = HarvestHoney(
              expectedMap['id'],
              expectedMap['hiveId'],
              expectedMap['date'],
              (json.decode(expectedMap['pictures']) as List<dynamic>)
                  .cast<String>(),
              expectedMap['description'],
              expectedMap['describedAmount'],
              expectedMap['frames'],
              expectedMap['weight'],
              expectedMap['quality'])
          .toMap();
      expect(result, expectedMap);
    });
    test('should return the correct map based on object visit', () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
      };
      var result = Visit(
        expectedMap['id'],
        expectedMap['hiveId'],
        expectedMap['date'],
        (json.decode(expectedMap['pictures']) as List<dynamic>).cast<String>(),
        expectedMap['description'],
      ).toMap();
      expect(result, expectedMap);
    });
    test('should return the correct map based on object Hive', () {
      var expectedMap = {
        'id': 'someId1234',
        'number': 1324,
        'annualHoney': 60,
        'description': 'someDesc',
        'picture': 'picturePath',
        'populationInfo': null,
        'queenInfo': null,
        'visits': <Visit>[],
      };
      var result = Hive(
        expectedMap['id'],
        expectedMap['number'],
        expectedMap['annualHoney'],
        expectedMap['description'],
        expectedMap['picture'],
        expectedMap['populationInfo'],
        expectedMap['queenInfo'],
        expectedMap['visits'],
      ).toMap();
      expect(result, expectedMap);
    });
  });
  group('fromMap', () {
    test(
        'should generate the correct object based on the given Map populationInfo',
        () {
      var expectedMap = {
        'id': 'someId1234',
        'regularVisitId': 'someId1234',
        'frames': 20,
        'stairs': 2,
        'status': 'Strong'
      };
      var result = PopulationInfo.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
    test('should generate the correct object based on the given Map queenInfo',
        () {
      var expectedMap = {
        'id': 'someId1234',
        'changeQueenId': 'someId1234',
        'enterDate': DateTime.now(),
        'breed': 'some breed name',
        'backColor': 'red'
      };
      var result = QueenInfo.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
    test(
        'should generate the correct object based on the given Map regularVisit',
        () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
        'behavior': 'calm',
        'queenSeen': true,
        'honeyMaking': 'good',
        'populationInfo': null,
      };
      var result = RegularVisit.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
    test(
        'should generate the correct object based on the given Map changeQueen',
        () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
        'queenInfo': null,
      };
      var result = ChangeQueen.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
    test(
        'should generate the correct object based on the given Map harvestHoney',
        () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
        'describedAmount': 'good',
        'frames': 10,
        'weight': 40,
        'quality': 'good',
      };
      var result = HarvestHoney.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
    test('should generate the correct object based on the given Map Visit', () {
      var expectedMap = {
        'id': 'someId1234',
        'hiveId': 'someId1234',
        'date': DateTime.now(),
        'pictures': json.encode(['picturePath']),
        'description': 'someDesc',
      };
      var result = Visit.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
    test('should generate the correct object based on the given Map Hive', () {
      var expectedMap = {
        'id': 'someId1234',
        'number': 1324,
        'annualHoney': 60,
        'description': 'someDesc',
        'picture': 'picturePath',
        'populationInfo': null,
        'queenInfo': null,
        'visits': null,
      };
      var result = Hive.fromMap(expectedMap);
      expect(result.toMap(), expectedMap);
    });
  });
}
