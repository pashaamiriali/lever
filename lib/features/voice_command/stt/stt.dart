//STT stands for speech to text
import 'dart:async';

import 'package:lever/features/voice_command/entities/entities.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class STT {
  final SpeechToText _speechToText;
  bool available = false;

  STT(this._speechToText);

  final _eventsController = StreamController<STTEvents>();
  final _textFlowController = StreamController<RawSTTResult>();

  Stream<STTEvents> get events => _eventsController.stream.asBroadcastStream();

  Stream<RawSTTResult> get textFlow =>
      _textFlowController.stream.asBroadcastStream();

  Future<void> initialize() async {
    this.available = await _speechToText.initialize(onStatus: _statusListener);
  }

  void _statusListener(String status) {
    switch (status) {
      case 'ready':
        _eventsController.sink.add(STTEvents.ready);
        break;
      case 'listening':
        _eventsController.sink.add(STTEvents.listening);
        break;
    }
  }

  void listen() {
    this._speechToText.listen(
        localeId: 'fa',
        onResult: (SpeechRecognitionResult result) {
          this._textFlowController.sink.add(
                RawSTTResult(result.recognizedWords, result.finalResult),
              );
        });
  }

  void stop() {
    this._speechToText.stop();
  }
}

