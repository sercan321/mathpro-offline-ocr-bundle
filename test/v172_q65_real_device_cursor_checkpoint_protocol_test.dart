import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/cursor_golden_geometry_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/long_expression_pan_nested_cursor_stability_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/real_device_cursor_checkpoint_protocol_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/structural_edit_transaction_stress_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/synthetic_tap_intent_matrix_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q65 real-device cursor checkpoint protocol', () {
    test('metadata advances to Q65 while refusing fake +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q64 Long Expression Pan Nested Cursor Stability'));
      expect(MathProPackageContract.cursorLineageVersions, contains('0.172.103+172'));
      expect(MathProPackageContract.cursorLineageVersions, contains('0.172.104+172'));
      expect(MathProPackageContract.auditTitle, contains('Q65'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q65 Real Device Cursor Checkpoint Protocol'));
      expect(MathProPackageContract.q65RealDeviceCursorCheckpointProtocolRule, contains('19/20'));
      expect(MathProPackageContract.q65RealDeviceCursorCheckpointProtocolRule, contains('does not claim real-device PASS'));
    });

    test('protocol requires real logs and phone evidence before +95 candidate claim', () {
      expect(RealDeviceCursorCheckpointProtocolPolicy.checkpointProtocolAvailable, isTrue);
      expect(RealDeviceCursorCheckpointProtocolPolicy.flutterAnalyzeEvidenceRequired, isTrue);
      expect(RealDeviceCursorCheckpointProtocolPolicy.flutterTestEvidenceRequired, isTrue);
      expect(RealDeviceCursorCheckpointProtocolPolicy.flutterRunDeviceEvidenceRequired, isTrue);
      expect(RealDeviceCursorCheckpointProtocolPolicy.phoneScreenshotOrVideoEvidenceRequired, isTrue);
      expect(RealDeviceCursorCheckpointProtocolPolicy.cursorPlus95ClaimAllowedWithoutEvidence, isFalse);
      expect(RealDeviceCursorCheckpointProtocolPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('all checkpoint scenarios require at least 19/20 correct attempts', () {
      for (final scenario in RealDeviceCursorCheckpointProtocolPolicy.requiredCheckpointScenarios) {
        final verdict = RealDeviceCursorCheckpointProtocolPolicy.evaluateScenario(
          scenario: scenario,
          attempts: RealDeviceCursorCheckpointProtocolPolicy.syntheticPassingAttemptVector(),
        );
        expect(verdict.attempts, 20, reason: scenario);
        expect(verdict.correct, 19, reason: scenario);
        expect(verdict.passed, isTrue, reason: verdict.summary);
      }
    });

    test('candidate +95 remains blocked without complete device evidence', () {
      final verdicts = <CheckpointScenarioVerdict>[
        for (final scenario in RealDeviceCursorCheckpointProtocolPolicy.requiredCheckpointScenarios)
          RealDeviceCursorCheckpointProtocolPolicy.evaluateScenario(
            scenario: scenario,
            attempts: RealDeviceCursorCheckpointProtocolPolicy.syntheticPassingAttemptVector(),
          ),
      ];
      expect(
        RealDeviceCursorCheckpointProtocolPolicy.evidenceBundleCanClaimCandidatePlus95(
          flutterAnalyzePassed: true,
          flutterTestPassed: true,
          flutterRunOnDeviceProvided: false,
          phoneVisualEvidenceProvided: true,
          scenarioVerdicts: verdicts,
        ),
        isFalse,
      );
      expect(
        RealDeviceCursorCheckpointProtocolPolicy.evidenceBundleCanClaimCandidatePlus95(
          flutterAnalyzePassed: true,
          flutterTestPassed: true,
          flutterRunOnDeviceProvided: true,
          phoneVisualEvidenceProvided: true,
          scenarioVerdicts: verdicts,
        ),
        isTrue,
      );
    });

    test('Q61-Q64 courts justify skipping per-phase device tests but not final checkpoint', () {
      expect(
        RealDeviceCursorCheckpointProtocolPolicy.maySkipPerPhaseDeviceTesting(
          goldenGeometryCourtPresent: CursorGoldenGeometryCourtPolicy.cursorGoldenGeometryCourtAvailable,
          syntheticTapMatrixPresent: SyntheticTapIntentMatrixPolicy.syntheticTapIntentMatrixAvailable,
          transactionStressCourtPresent: StructuralEditTransactionStressCourtPolicy.structuralEditTransactionStressCourtAvailable,
          longExpressionStabilityCourtPresent: LongExpressionPanNestedCursorStabilityPolicy.longExpressionPanNestedCursorStabilityAvailable,
        ),
        isTrue,
      );
    });

    test('Q65 source is wired without mutating frozen visual surfaces', () {
      final policySource = File('lib/features/formula_engine/real_device_cursor_checkpoint_protocol_policy.dart').readAsStringSync();
      final contractSource = File('lib/logic/mathpro_package_contract.dart').readAsStringSync();
      final readmeSource = File('README.md').readAsStringSync();
      final verifierSource = File('tool/verify_mathpro_contract.py').readAsStringSync();
      expect(policySource, contains('RealDeviceCursorCheckpointProtocolPolicy'));
      expect(policySource, contains('cursorPlus95ClaimAllowedWithoutEvidence = false'));
      expect(policySource, contains('requiredCorrectPerScenario = 19'));
      expect(contractSource, contains('q65RealDeviceCursorCheckpointProtocolRule'));
      expect(readmeSource.split('\n').first, contains('V172-Q65 Real Device Cursor Checkpoint Protocol'));
      expect(verifierSource, contains('check_v172_q65_real_device_cursor_checkpoint_protocol'));
      expect(policySource, isNot(contains('keyboardSurfaceMutationAllowed = true')));
      expect(policySource, isNot(contains('longPressSurfaceMutationAllowed = true')));
    });
  });
}

