import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';
import 'package:lever/features/hive_management/domain/usecases/search_hive_cmnd.dart';
import 'package:mockito/mockito.dart';

class MockHiveRepo extends Mock implements HiveRepo {}

void main() {
  MockHiveRepo mockHiveRepo = MockHiveRepo();
  when(mockHiveRepo.searchHives('hive')).thenAnswer(
    (realInvocation) async => [
      Hive('dfs34', 2343, 34, 'desc', 'some.jpg', null, null, null),
    ],
  );
  test('should return a list of hives with one element', () async {
    SearchHiveCmnd cmnd = SearchHiveCmnd(mockHiveRepo);
    List<Hive> result = await cmnd.execute({'query': 'hive'});
    verify(mockHiveRepo.searchHives('hive'));
    expect(result.length, 1);
  });
}
