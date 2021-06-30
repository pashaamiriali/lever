import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';

class DeleteHiveCmnd extends Command {
  final HiveRepo _hiveRepo;

  DeleteHiveCmnd(this._hiveRepo);
  //map: {'hive_id':hiveId}
  @override
  Future<void> execute(Map<String, dynamic> args) async {
    await this._hiveRepo.deleteHive(args['hive_id']);
  }
}
