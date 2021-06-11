import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';
import 'package:lever/features/home_screen/logic/home_screen_model.dart';
import 'package:mockito/mockito.dart';

class MockFetchHivesCmnd extends Mock implements FetchHivesCmnd {}

class MockAddHiveCmnd extends Mock implements AddHiveCmnd {}

main() {
  MockFetchHivesCmnd mockFetchHivesCmnd = MockFetchHivesCmnd();
  MockAddHiveCmnd mockAddHiveCmnd = MockAddHiveCmnd();
  group('hives List', () {
    when(mockFetchHivesCmnd.execute(any)).thenAnswer((realInvocation) async =>
        [Hive(null, null, null, null, null, null, null, null)]);
    test(
        'should return the given hives list when there is none in the model object',
        () async {
      HomeScreenModel model =
          HomeScreenModel(mockFetchHivesCmnd, mockAddHiveCmnd);
      var expectedListCount = 1;
      var result = await model.hives;
      expect(result.length, expectedListCount);
    });
    test('should return the existing list of hives when already exists',
        () async {
      HomeScreenModel model =
          HomeScreenModel(mockFetchHivesCmnd, mockAddHiveCmnd);
      var expectedList = await model.hives;
      var result = await model.hives;
      expect(result.length, expectedList.length);
    });
  });
  group('add hive', () {
    when(mockAddHiveCmnd.execute(any)).thenAnswer((realInvocation) async =>
        Hive(null, null, null, null, null, null, null, null));
    test('should add the hive returned from execute to the hives list',
        () async {
      HomeScreenModel model =
          HomeScreenModel(mockFetchHivesCmnd, mockAddHiveCmnd);
      model.addHive(
          Hive(null, null, null, null, null, null, null, null),
          PopulationInfo(null, null, null, null, null),
          QueenInfo(null, null, null, null, null));
      var expectedListCount = 1;
      var result = await model.hives;
      expect(result.length, expectedListCount);
    });
  });
}
