import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';

class FetchVisitsCmnd extends Command{
  final HiveRepo _hiveRepo;

  FetchVisitsCmnd(this._hiveRepo);
  //map: {'hive_id': hiveId}
  @override
  Future<List<Visit>>execute(Map<String, dynamic> args) async {
    return await this._hiveRepo.fetchVisits(args['hive_id']);
  }
}