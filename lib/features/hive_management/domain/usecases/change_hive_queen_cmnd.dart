import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/visit_repo.dart';

class ChangeHiveQueenCmnd extends Command {
  final VisitRepo _repo;

  ChangeHiveQueenCmnd(this._repo);

  //map: {'change_queen': changeQueen}
  @override
  execute(Map<String, dynamic> args) async {
  await  _repo.saveChangeQueen(args['change_queen']);
  }
}
