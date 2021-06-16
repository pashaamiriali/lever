import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';

class GenerateHiveNumberCmnd extends Command {
  final HiveRepo _hiveRepo;

  GenerateHiveNumberCmnd(this._hiveRepo);
  @override
  Future<int> execute(Map<String, dynamic> args) async {
    int lastHiveNumber = await _hiveRepo.fetchLastHiveNumber();
    if (lastHiveNumber == null) return 1001;
    return lastHiveNumber + 1;
  }
}
