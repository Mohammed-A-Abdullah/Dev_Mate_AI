import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildQuickToolPromptSummary', () {
    test('returns fallback title when input is empty', () {
      expect(buildQuickToolPromptSummary('', 'Debug Code'), 'Debug Code');
    });

    test('returns a trimmed summary when prompt is provided', () {
      expect(
        buildQuickToolPromptSummary('  Explain this code carefully  ', 'Explain Code'),
        'Explain this code carefully',
      );
    });
  });
}
