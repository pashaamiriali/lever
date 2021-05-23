import 'package:flutter_test/flutter_test.dart';
import 'package:lever/core/exceptions/exceptions.dart';
import 'package:lever/features/hive_management/domain/usecases/add_hive_cmnd.dart';

main() {
  test(
    "should assert InvalidArgumentsException on empty argument list",
    () {
      var addHiveCmnd = AddHiveCmnd();
      expect(()=>addHiveCmnd.execute([]), throwsA(isA<InvalidArgumentsException>()));
    },
  );
}
