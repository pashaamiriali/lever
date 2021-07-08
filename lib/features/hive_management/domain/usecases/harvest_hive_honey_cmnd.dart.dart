import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';

class HarvestHiveHoneyCmnd extends Command {
  final VisitRepo _visitRepo;

  HarvestHiveHoneyCmnd(this._visitRepo);

  //map: {'harvest_honey': harvestHoney}
  @override
  execute(Map<String, dynamic> args) {
    _visitRepo.saveHarvestHoney(args['harvest_honey']);
  }
}
