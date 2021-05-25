import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';

class FetchHivesCmnd  extends Command{
 final HiveRepo _hiveRepo;

  FetchHivesCmnd(this._hiveRepo);
  @override
 Future<List<Hive>> execute(Map<String, dynamic> args) async {
    return await _hiveRepo.fetchHives();
  }

}