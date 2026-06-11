import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/math_expression_render_bridge.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/unified_math_preview_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_regression_gate.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_release_evidence_gate.dart';

void main() {
  group('V108 release evidence gate lock', () {
    test('defines the hard evidence contract without claiming PASS from code alone', () {
      expect(MathProReleaseEvidenceGate.version, 'mathpro-v108-release-evidence-hardening');
      expect(MathProReleaseEvidenceGate.requiredFlutterCommands, orderedEquals(<String>[
        'flutter pub get',
        'flutter analyze',
        'flutter test',
        'flutter run -d 23106RN0DA',
      ]));

      final preflight = MathProReleaseEvidenceGate.evaluateStaticPreflight();
      expect(preflight.passClaimAllowed, isFalse);
      expect(preflight.warnings.single, contains('not a real-device PASS'));
    });

    test('critical real-device scenarios cover the recurring P0 failures', () {
      expect(MathProReleaseEvidenceGate.requiredScenarioIds, containsAll(<String>{
        'fraction-filled-edit-delete',
        'log-base-filled-edit',
        'limit-variable-target-body',
        'sum-product-series-slot-overlay',
        'long-nested-cursor-pan',
        'longpress-popup-no-clipping',
        'more-panel-full-scan',
        'keyboard-contract-visual-lock',
      }));

      final evidenceItems = MathProReleaseEvidenceGate.criticalScenarios.map((scenario) => scenario.requiredEvidenceItem).toSet();
      expect(evidenceItems, contains('fraction-edit-delete-screen-recording'));
      expect(evidenceItems, contains('long-nested-cursor-screen-recording'));
      expect(evidenceItems, contains('keyboard-contract-screenshot'));
    });

    test('critical preview expressions are canonicalized before user-facing display', () {
      for (final expression in MathProReleaseEvidenceGate.criticalPreviewExpressions) {
        final preview = UnifiedMathPreviewPolicy.canonicalPreviewLabel(expression);
        final bridge = MathExpressionRenderBridge.canonicalDisplayExpression(expression);
        expect(MathProRegressionGate.hasForbiddenVisibleToken(preview), isFalse, reason: 'preview leak for $expression -> $preview');
        expect(MathProRegressionGate.hasForbiddenVisibleToken(bridge), isFalse, reason: 'bridge leak for $expression -> $bridge');
      }

      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('log(2)(5)'), 'log₍2₎(5)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('lim_y → 8(8)'), 'lim₍y→8₎(8)');
      expect(UnifiedMathPreviewPolicy.canonicalPreviewLabel('asin(□)'), 'sin⁻¹(□)');
    });

    test('manual evidence cannot pass without commands, scenarios, and attached artifacts', () {
      final blocked = MathProReleaseEvidenceGate.evaluateManualEvidence(
        pubGetPassed: true,
        analyzePassed: false,
        testPassed: true,
        realDeviceRunLaunched: false,
        completedScenarioIds: const <String>{'fraction-filled-edit-delete'},
        attachedEvidenceItems: const <String>{'pub-get-log'},
        noVisibleTokenLeakConfirmed: false,
        keyboardContractConfirmed: true,
        cursorOverlayConfirmedNotHuge: false,
        includeStaticPreflight: false,
      );

      expect(blocked.passClaimAllowed, isFalse);
      expect(blocked.blockers, contains('missing-or-failed-command:flutter analyze'));
      expect(blocked.blockers, contains('missing-or-failed-command:flutter run -d 23106RN0DA'));
      expect(blocked.blockers.any((blocker) => blocker.startsWith('missing-critical-scenarios:')), isTrue);
      expect(blocked.blockers.any((blocker) => blocker.startsWith('missing-release-evidence:')), isTrue);
    });

    test('manual evidence gate can pass only when every V108 item is present', () {
      final complete = MathProReleaseEvidenceGate.evaluateManualEvidence(
        pubGetPassed: true,
        analyzePassed: true,
        testPassed: true,
        realDeviceRunLaunched: true,
        completedScenarioIds: MathProReleaseEvidenceGate.requiredScenarioIds,
        attachedEvidenceItems: MathProReleaseEvidenceGate.requiredEvidenceSet,
        noVisibleTokenLeakConfirmed: true,
        keyboardContractConfirmed: true,
        cursorOverlayConfirmedNotHuge: true,
        includeStaticPreflight: false,
      );

      expect(complete.passClaimAllowed, isTrue);
      expect(complete.blockers, isEmpty);
      expect(complete.warnings.single, contains('Evidence contract is satisfied'));
    });
  });
}
