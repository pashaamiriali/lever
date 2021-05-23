import 'package:lever/core/abstractions/command.dart';
import 'package:lever/core/exceptions/exceptions.dart';

class AddHiveCmnd extends Command {
  @override
  execute(List args) {
    if (args.length < 3) throw InvalidArgumentsException();
    
  }
}
