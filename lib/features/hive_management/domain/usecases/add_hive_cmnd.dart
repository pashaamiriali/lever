import 'package:lever/core/abstractions/command.dart';
import 'package:lever/core/exceptions/exceptions.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/entities.dart';

class AddHiveCmnd extends Command {
  final HiveRepo _hiveRepo;

  AddHiveCmnd(this._hiveRepo);

//map: {'hive': hive, 'population_info': populationInfo, 'queen_info': queenInfo}
  @override
  Future<Hive> execute(Map<String, dynamic> args) async {
    if (args.length != 3 ||
        args['hive'] == null ||
        args['population_info'] == null ||
        args['queen_info'] == null) throw InvalidArgumentsException();
    return await this
        ._hiveRepo
        .saveHive(args['hive'], args['population_info'], args['queen_info']);
  }
}
