import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/delete_hive_cmnd.dart';
import 'package:lever/features/hive_management/domain/usecases/usecases.dart';
import 'package:lever/features/home_screen/logic/home_screen_model.dart';
import 'package:mockito/mockito.dart';

class MockFetchHivesCmnd extends Mock implements FetchHivesCmnd {}

class MockAddHiveCmnd extends Mock implements AddHiveCmnd {}

class MockDeleteHiveCmnd extends Mock implements DeleteHiveCmnd {}

class MockSearchHiveCmnd extends Mock implements SearchHiveCmnd {}

class MockFetchHiveCmnd extends Mock implements FetchHiveCmnd {}

main() {
  MockFetchHivesCmnd mockFetchHivesCmnd = MockFetchHivesCmnd();
  MockDeleteHiveCmnd mockDeleteHiveCmnd = MockDeleteHiveCmnd();
  MockSearchHiveCmnd mockSearchHiveCmnd = MockSearchHiveCmnd();
  MockFetchHiveCmnd mockFetchHiveCmnd = MockFetchHiveCmnd();
  group('hives List', () {
    when(mockFetchHivesCmnd.execute(any)).thenAnswer((realInvocation) async =>
        [Hive('someId123', null, null, null, null, null, null, null)]);
    test(
        'should return the given hives list when there is none in the model object',
        () async {
      HomeScreenModel model = HomeScreenModel(mockFetchHivesCmnd,
          mockDeleteHiveCmnd, mockSearchHiveCmnd, mockFetchHiveCmnd);
      var expectedListCount = 1;
      var result = await model.hives;
      expect(result.length, expectedListCount);
    });
    test('should return the existing list of hives when already exists',
        () async {
      HomeScreenModel model = HomeScreenModel(mockFetchHivesCmnd,
          mockDeleteHiveCmnd, mockSearchHiveCmnd, mockFetchHiveCmnd);
      var expectedList = await model.hives;
      var result = await model.hives;
      expect(result.length, expectedList.length);
    });
    test('should remove the hive from the hives list on delete', () async {
      HomeScreenModel model = HomeScreenModel(mockFetchHivesCmnd,
          mockDeleteHiveCmnd, mockSearchHiveCmnd, mockFetchHiveCmnd);
      await model.hives;
      await model.deleteHive('someId123');
      expect(await model.hives, []);
    });
  });
}
