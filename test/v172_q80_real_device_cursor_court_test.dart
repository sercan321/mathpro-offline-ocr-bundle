import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/native_real_device_cursor_court_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q80 real-device cursor court', () {
    test('metadata advances to Q80 while refusing fake Flutter/device PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('V172-Q80'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q80 Real Device Cursor Court | V172-Q80R1 Static Contract Audit Repair'));
      expect(MathProPackageContract.q80RealDeviceCursorCourtRule, contains('19/20'));
      expect(NativeRealDeviceCursorCourtPolicy.realDevicePlus95PassClaimed, isFalse);
      expect(NativeRealDeviceCursorCourtPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(NativeRealDeviceCursorCourtPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(NativeRealDeviceCursorCourtPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(NativeRealDeviceCursorCourtPolicy.photomathLevelClaimAllowedWithoutEvidence, isFalse);
    });

    test('court requires the exact Flutter command evidence before candidate review', () {
      final scenarioResults = <String, bool>{
        for (final scenario in NativeRealDeviceCursorCourtPolicy.requiredManualScenarios) scenario: true,
      };
      expect(
        NativeRealDeviceCursorCourtPolicy.qualifiesForCandidatePlus95Review(
          scenarioResults: scenarioResults,
          flutterCommandLogLines: const <String>[
            'flutter pub get',
            'flutter analyze',
            'flutter test',
          ],
          observedFailures: const <String>[],
        ),
        isFalse,
      );
      expect(
        NativeRealDeviceCursorCourtPolicy.qualifiesForCandidatePlus95Review(
          scenarioResults: scenarioResults,
          flutterCommandLogLines: NativeRealDeviceCursorCourtPolicy.requiredFlutterCommands,
          observedFailures: const <String>[],
        ),
        isTrue,
      );
    });

    test('19 of 20 scenarios is the minimum candidate threshold', () {
      final almostAll = <String, bool>{
        for (final scenario in NativeRealDeviceCursorCourtPolicy.requiredManualScenarios) scenario: true,
      };
      almostAll[NativeRealDeviceCursorCourtPolicy.requiredManualScenarios.last] = false;
      expect(NativeRealDeviceCursorCourtPolicy.countCorrectManualScenarios(almostAll), 19);
      expect(
        NativeRealDeviceCursorCourtPolicy.qualifiesForCandidatePlus95Review(
          scenarioResults: almostAll,
          flutterCommandLogLines: NativeRealDeviceCursorCourtPolicy.requiredFlutterCommands,
          observedFailures: const <String>[],
        ),
        isTrue,
      );

      final belowThreshold = Map<String, bool>.from(almostAll);
      belowThreshold[NativeRealDeviceCursorCourtPolicy.requiredManualScenarios.first] = false;
      expect(NativeRealDeviceCursorCourtPolicy.countCorrectManualScenarios(belowThreshold), 18);
      expect(
        NativeRealDeviceCursorCourtPolicy.qualifiesForCandidatePlus95Review(
          scenarioResults: belowThreshold,
          flutterCommandLogLines: NativeRealDeviceCursorCourtPolicy.requiredFlutterCommands,
          observedFailures: const <String>[],
        ),
        isFalse,
      );
    });

    test('blocking real-device failure modes reject the court even with 20/20 scenario map', () {
      final scenarioResults = <String, bool>{
        for (final scenario in NativeRealDeviceCursorCourtPolicy.requiredManualScenarios) scenario: true,
      };
      expect(
        NativeRealDeviceCursorCourtPolicy.qualifiesForCandidatePlus95Review(
          scenarioResults: scenarioResults,
          flutterCommandLogLines: NativeRealDeviceCursorCourtPolicy.requiredFlutterCommands,
          observedFailures: const <String>[
            'tap on integral differential is swallowed by integral body',
          ],
        ),
        isFalse,
      );
      expect(
        NativeRealDeviceCursorCourtPolicy.courtVerdict(
          scenarioResults: scenarioResults,
          flutterCommandLogLines: NativeRealDeviceCursorCourtPolicy.requiredFlutterCommands,
          observedFailures: const <String>[
            'tap on integral differential is swallowed by integral body',
          ],
        ),
        contains('REJECT'),
      );
    });

    test('court scenario list covers empty slots, families, integral and long-pan cases', () {
      final scenarios = NativeRealDeviceCursorCourtPolicy.requiredManualScenarios.join('\n');
      expect(scenarios, contains('fraction numerator'));
      expect(scenarios, contains('fraction denominator'));
      expect(scenarios, contains('sin argument'));
      expect(scenarios, contains('log base'));
      expect(scenarios, contains('log argument'));
      expect(scenarios, contains('sqrt body'));
      expect(scenarios, contains('integral differential'));
      expect(scenarios, contains('d|□'));
      expect(scenarios, contains('long nested expression pan'));
      expect(NativeRealDeviceCursorCourtPolicy.requiredManualScenarios.length, 20);
    });
  });
}
