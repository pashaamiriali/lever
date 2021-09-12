import 'dart:async';

import 'package:lever/features/voice_command/entities/entities.dart';
import 'package:lever/features/voice_command/interpreter/matches.dart';

class Interpreter {
  final Stream<RawSTTResult> _rawSttResultsStream;

  final _commandsController = StreamController<ICommand>();
  Stream<ICommand> get commands =>
      _commandsController.stream.asBroadcastStream();

  Interpreter(this._rawSttResultsStream) {
    _rawSttResultsStream.listen((event) {
      if (event.isFinal)
        _commandsController.sink.add(
          _extractCommand(
            _replaceNumbers(event.text),
          ),
        );
    });
  }
  ICommand _extractCommand(String text) {
    for (var match in matchingTags) {
      if (text.contains(match['word']))
        return ICommand(
          match['tag'],
          text
              .substring(text.indexOf(match['word']), match['word'].length)
              .trim(),
        );
    }
    return null;
  }

  String _replaceNumbers(String original) {
    String result = '';
    for (String word in original.split(' ')) {
      if (numbers.containsKey(word))
        result += numbers[word];
      else
        result += word;
      result += ' ';
    }
    return result;
  }
}
