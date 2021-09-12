import 'package:flutter_test/flutter_test.dart';
import 'package:lever/features/voice_command/entities/entities.dart';
import 'package:lever/features/voice_command/stt/stt.dart';
import 'package:mockito/mockito.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MockSpeechToText extends Mock implements SpeechToText {}

main() {
  MockSpeechToText mockSpeechToText = MockSpeechToText();
  group('initialize', () {
    when(mockSpeechToText.initialize())
        .thenAnswer((realInvocation) async => true);
    test('should initialize the mock stt class using the method.', () {
      STT stt = STT(mockSpeechToText);
      stt.initialize();
      verify(mockSpeechToText.initialize());
    });
    test('should change the STT available to true in successful initialize',
        () async {
      STT stt = STT(mockSpeechToText);
      await stt.initialize();
      expectLater(stt.available, true);
    });
    test('should broadcast ready event when ready.', () async {
      STT stt = STT(mockSpeechToText);
      stt.events.listen((event) {
        expect(event, STTEvents.ready);
      });
      stt.initialize();
    });
  });
  group('listen', ()
  {
    test('should broadcast listening event when listen is called', () {
      STT stt = STT(mockSpeechToText);
      stt.events.listen((event) {
        expect(event, STTEvents.listening);
      });
      stt.listen();
    });
    test('should broadcast notListening event when stop is called', () {
      STT stt = STT(mockSpeechToText);
      stt.events.listen((event) {
        expect(event, STTEvents.notListening);
      });
      stt.stop();
    });
  });
}
