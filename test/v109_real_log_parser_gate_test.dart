import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_real_log_parser_gate.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_release_evidence_gate.dart';

void main() {
  group('V109 real log parser and analyze/test evidence gate', () {
    test('version and clean command logs are recognized without claiming visual PASS', () {
      expect(MathProRealLogParserGate.version, 'mathpro-v109-real-log-parser-gate');

      final verdict = MathProRealLogParserGate.evaluateAllRequiredLogs(
        pubGetLog: 'Resolving dependencies...\nDownloading packages...\nGot dependencies!',
        analyzeLog: 'Analyzing MathProFlutterPhase17...\nNo issues found! (ran in 3.1s)',
        testLog: '00:18 +209: All tests passed!',
        runLog: 'Launching lib/main.dart on 23106RN0DA in debug mode...\nSyncing files to device 23106RN0DA...\nFlutter run key commands.',
      );

      expect(verdict.logsPassed, isTrue);
      expect(verdict.blockers, isEmpty);
      expect(verdict.realDeviceVisualPassClaimAllowed, isFalse);
      expect(verdict.warnings.any((warning) => warning.contains('visual-pass')), isTrue);
    });

    test('flutter analyze with warnings is not accepted as clean PASS', () {
      final verdict = MathProRealLogParserGate.evaluateAnalyzeLog(
        'Analyzing MathProFlutterPhase17...\nwarning • The value of the field is not used • lib/a.dart:1:1\n1 issue found.',
      );

      expect(verdict.passed, isFalse);
      expect(verdict.blockers, contains('analyze-not-clean-warning-or-info-present'));
      expect(verdict.blockers, contains('analyze-clean-success-line-missing'));
    });

    test('flutter test failure output is blocked even if some tests passed before it', () {
      final verdict = MathProRealLogParserGate.evaluateTestLog(
        '00:07 +120 -1: Some tests failed.\nFailed to load test/v_bad_test.dart',
      );

      expect(verdict.passed, isFalse);
      expect(verdict.blockers, contains('test-log-contains-failure'));
      expect(verdict.blockers, contains('test-success-line-missing'));
    });

    test('flutter run launch log still cannot unlock manual visual PASS alone', () {
      final releaseVerdict = MathProReleaseEvidenceGate.evaluateRealLogEvidence(
        pubGetLog: 'Resolving dependencies...\nGot dependencies!',
        analyzeLog: 'Analyzing MathProFlutterPhase17...\nNo issues found!',
        testLog: '00:18 +209: All tests passed!',
        runLog: 'Launching lib/main.dart on 23106RN0DA in debug mode...\nFlutter run key commands.',
      );

      expect(releaseVerdict.passClaimAllowed, isFalse);
      expect(releaseVerdict.blockers, isEmpty);
      expect(releaseVerdict.warnings.any((warning) => warning.contains('manual device scenarios')), isTrue);
    });
  });
}
