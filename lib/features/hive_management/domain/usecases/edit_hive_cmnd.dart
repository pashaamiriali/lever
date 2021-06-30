import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';

class EditHiveCmnd extends Command {
  final HiveRepo _repo;

  EditHiveCmnd(this._repo);
  //map: {'hive':hive}
  @override
  Future<void> execute(Map<String, dynamic> args) async {
    await this._repo.editHive(args['hive']);
    await this._repo.editPopulationInfo(args['hive'].populationInfo);
    await this._repo.editQueenInfo(args['hive'].queenInfo);
  }
}
