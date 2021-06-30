import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/hive.dart';

class FetchHiveCmnd extends Command {
  final HiveRepo _hiveRepo;

  FetchHiveCmnd(this._hiveRepo);
  //map: {'hive_id': hiveId}
  @override
  Future<Hive> execute(Map<String, dynamic> args) async {
    return await this._hiveRepo.fetchHive(args['hive_id']);
  }
}
