import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/p6_locked_cursor_candidate_freeze_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q50 P6-locked +95 cursor candidate freeze', () {
    test('policy freezes candidate matrix without claiming real-device +95 PASS', () {
      expect(P6LockedCursorCandidateFreezePolicy.version, contains('v172q50'));
      expect(P6LockedCursorCandidateFreezePolicy.p6LockedCursorCandidateFreezeAvailable, isTrue);
      expect(P6LockedCursorCandidateFreezePolicy.plus95CandidateMatrixFrozen, isTrue);
      expect(P6LockedCursorCandidateFreezePolicy.p6VisualFilesLocked, isTrue);
      expect(P6LockedCursorCandidateFreezePolicy.keyboardSurfaceMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.moreSurfaceMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.longPressSurfaceMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.appShellMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.graphHistorySolutionMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.mathLabelMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.premiumKeyMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.templateTrayMutationAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.visibleGreenOverlayAllowed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.fullNativeMathRendererClaimed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.trueAstSlotToSvgNodeIdentityClaimed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.realDevicePlus95PassClaimed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.flutterAnalyzePassClaimed, isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.flutterTestPassClaimed, isFalse);
    });

    test('metadata advances to Q50 while preserving Q34-Q49 cursor lineage', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.cursorLineageVersions, contains('0.172.77+172'));
      expect(MathProPackageContract.cursorLineageVersions, contains(MathProPackageContract.version));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q49 Structural Cursor Release Hardening'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q50R2 Stale Package Guard Repair'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.q50EvidenceRule, contains('real-device Pixel QA'));
    });

    test('core scenario matrix covers the frozen +95 candidate set', () {
      expect(P6LockedCursorCandidateFreezePolicy.hasCompleteCoreScenarioMatrix, isTrue);
      expect(P6LockedCursorCandidateFreezePolicy.coreScenarioMatrix, hasLength(14));
      expect(
        P6LockedCursorCandidateFreezePolicy.coreScenarioMatrix.map((scenario) => scenario.expression),
        containsAll(<String>[
          '√□',
          'x^□',
          'x_□',
          'log_□(□)',
          '9/6',
          '12/345',
          '123456789',
          'cos(99666655)',
          'sin(300)',
          'ln(123456)',
          'ln(ln(8))',
          'sin(cos(300))',
          '√(sin(x)+log₂(500))',
          'sin(300)+cos(400)+log₂(500)+√(600)',
        ]),
      );
      expect(
        P6LockedCursorCandidateFreezePolicy.coreScenarioMatrix.every(
          (scenario) => scenario.minimumCorrectSelections == P6LockedCursorCandidateFreezePolicy.requiredCorrectPerScenario,
        ),
        isTrue,
      );
    });

    test('evidence gate blocks +95 claim until Flutter and real-device proof exists', () {
      expect(
        P6LockedCursorCandidateFreezePolicy.canClaimPlus95CandidatePass(
          scenarioCount: 14,
          totalAttempts: 280,
          totalCorrect: 266,
          flutterAnalyzePassed: false,
          flutterTestPassed: true,
          realDeviceRunEvidence: true,
          pixelQaEvidenceAvailable: true,
        ),
        isFalse,
      );
      expect(
        P6LockedCursorCandidateFreezePolicy.canClaimPlus95CandidatePass(
          scenarioCount: 14,
          totalAttempts: 280,
          totalCorrect: 266,
          flutterAnalyzePassed: true,
          flutterTestPassed: true,
          realDeviceRunEvidence: false,
          pixelQaEvidenceAvailable: true,
        ),
        isFalse,
      );
      expect(
        P6LockedCursorCandidateFreezePolicy.canClaimPlus95CandidatePass(
          scenarioCount: 14,
          totalAttempts: 280,
          totalCorrect: 265,
          flutterAnalyzePassed: true,
          flutterTestPassed: true,
          realDeviceRunEvidence: true,
          pixelQaEvidenceAvailable: true,
        ),
        isFalse,
      );
      expect(
        P6LockedCursorCandidateFreezePolicy.canClaimPlus95CandidatePass(
          scenarioCount: 14,
          totalAttempts: 280,
          totalCorrect: 266,
          flutterAnalyzePassed: true,
          flutterTestPassed: true,
          realDeviceRunEvidence: true,
          pixelQaEvidenceAvailable: true,
        ),
        isTrue,
      );
    });

    test('path guards reject protected P6 UI files and allow cursor-only work areas', () {
      for (final path in P6LockedCursorCandidateFreezePolicy.protectedP6Files) {
        expect(P6LockedCursorCandidateFreezePolicy.isProtectedP6File(path), isTrue);
        expect(P6LockedCursorCandidateFreezePolicy.isAllowedSurgicalCursorPath(path), isFalse);
      }
      expect(
        P6LockedCursorCandidateFreezePolicy.isAllowedSurgicalCursorPath(
          'lib/features/formula_engine/p6_locked_cursor_candidate_freeze_policy.dart',
        ),
        isTrue,
      );
      expect(P6LockedCursorCandidateFreezePolicy.isAllowedSurgicalCursorPath('lib/app/app_shell.dart'), isFalse);
      expect(P6LockedCursorCandidateFreezePolicy.isAllowedSurgicalCursorPath('lib/features/keyboard/premium_key.dart'), isFalse);
    });

    test('Q50 source contract is present without enabling forbidden visual mutations', () {
      final policySource = File('lib/features/formula_engine/p6_locked_cursor_candidate_freeze_policy.dart').readAsStringSync();
      final verifierSource = File('tool/verify_mathpro_contract.py').readAsStringSync();
      final readmeSource = File('README.md').readAsStringSync();

      expect(policySource, contains('P6LockedCursorCandidateFreezePolicy'));
      expect(policySource, contains('coreScenarioMatrix'));
      expect(policySource, contains('realDevicePlus95PassClaimed = false'));
      expect(verifierSource, contains('check_v172_q50_p6_locked_cursor_candidate_freeze'));
      expect(readmeSource.split('\n').first, contains('V172-Q60'));
      expect(policySource, isNot(contains('paintVisibleSlotOverlay: true')));
    });
  });
}
