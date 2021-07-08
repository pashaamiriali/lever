import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';

class RegularHiveVisitCmnd extends Command {
  final VisitRepo _visitRepo;

  RegularHiveVisitCmnd(this._visitRepo);

  //map: {'regular_visit': visit}
  @override
  execute(Map<String, dynamic> args) async {
    await this._visitRepo.saveRegularVisit(args['regular_visit']);
  }
}
