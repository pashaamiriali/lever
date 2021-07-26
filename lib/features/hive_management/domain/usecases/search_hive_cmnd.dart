import 'package:lever/core/abstractions/command.dart';
import 'package:lever/features/hive_management/domain/data/hive_repo.dart';
import 'package:lever/features/hive_management/domain/entities/hive.dart';

class SearchHiveCmnd extends Command {
  final HiveRepo _repo;

  SearchHiveCmnd(this._repo);

  //Map: {'query':query}
  @override
  Future<List<Hive>> execute(Map<String, dynamic> args) async {
    return _repo.searchHives(args['query']);
  }
}
