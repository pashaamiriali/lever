import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/exceptions/exceptions.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/entities/hive.dart';
import 'package:lever/features/hive_management/domain/usecases/add_hive_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

main() {
  var mockHiveRepo = MockHiveRepo();
  test(
    "should assert InvalidArgumentsException on invalid argument map",
    () {
      var addHiveCmnd = AddHiveCmnd(mockHiveRepo);
      expect(() => addHiveCmnd.execute({}),
          throwsA(isA<InvalidArgumentsException>()));
      Hive hive = Hive(
        'id',
        1234,
        23,
        'desc',
        'empty',
        PopulationInfo('id', 'regularVisitId', 20, 2, 'good'),
        QueenInfo(
          'id',
          'changeQueenId',
          DateTime.now(),
          'breed',
          'black',
        ),
        [],
      );
      expect(
          () => addHiveCmnd.execute(
                {
                  'hive': hive,
                },
              ),
          throwsA(isA<InvalidArgumentsException>()));
      expect(
          () => addHiveCmnd.execute(
                {'hive': null, 'population_info': null, 'queen_info': null},
              ),
          throwsA(isA<InvalidArgumentsException>()));
    },
  );
  test('should call saveHive in hiveRepo with proper arguments', () {
    var addHiveCommand = AddHiveCmnd(mockHiveRepo);
    Hive hive = Hive(null, 1234, 23, 'desc', 'empty', null, null, null);
    var populationInfo = PopulationInfo('id', 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      'id',
      'changeQueenId',
      DateTime.now(),
      'breed',
      'black',
    );
    addHiveCommand.execute({
      'hive': hive,
      'population_info': populationInfo,
      'queen_info': queenInfo
    });
    verify(mockHiveRepo.saveHive(hive, populationInfo, queenInfo));
  });
  test(
      'should return a hive with uniqueId + a populationInfo and queenInfo with visit ids',
      () async {
    var addHiveCommand = AddHiveCmnd(mockHiveRepo);
    Hive hive = Hive(null, 1234, 23, 'desc', 'empty', null, null, null);
    var populationInfo = PopulationInfo(null, 'regularVisitId', 20, 2, 'good');
    var queenInfo = QueenInfo(
      null,
      'changeQueenId',
      DateTime.now(),
      'breed',
      'black',
    );
    var expectedHive = Hive(
        null, 1234, 23, 'desc', 'empty', populationInfo, queenInfo, null);
    when(mockHiveRepo.saveHive(hive, populationInfo, queenInfo))
        .thenAnswer((realInvocation) => expectedHive);
    var result = await addHiveCommand.execute({
      'hive': hive,
      'population_info': populationInfo,
      'queen_info': queenInfo
    });
    expect(result, expectedHive);
  });
}
