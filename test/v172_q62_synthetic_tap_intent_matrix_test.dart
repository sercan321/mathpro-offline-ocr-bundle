import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor/math_node.dart';
import 'package:mathpro_flutter_phase17/features/editor/slot_registry.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/slot_geometry_bundle_authority.dart';
import 'package:mathpro_flutter_phase17/features/formula_engine/synthetic_tap_intent_matrix_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q62 synthetic tap intent matrix', () {
    test('metadata advances to Q62 without claiming real-device +95 PASS', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.pubspecDescription, contains('V172-Q80'));
      expect(MathProPackageContract.auditTitle, contains('Q62'));
      expect(MathProPackageContract.nextPhase, contains('Q81'));
      expect(MathProPackageContract.cursorLineageTitles, contains('V172-Q62 Synthetic Tap Intent Matrix'));
      expect(MathProPackageContract.q62SyntheticTapIntentMatrixRule, contains('Synthetic Tap Intent Matrix'));
      expect(SyntheticTapIntentMatrixPolicy.syntheticTapIntentMatrixAvailable, isTrue);
      expect(SyntheticTapIntentMatrixPolicy.realDevicePlus95PassClaimed, isFalse);
    });

    test('samples exactly twenty phone-like tap points per structural scenario', () {
      final bundle = _bundle(
        id: 'fraction-denominator',
        kind: MathNodeKind.fraction,
        slotKey: 'denominator',
        role: 'fractionDenominator',
        visualRect: const Rect.fromLTWH(160, 110, 32, 24),
      );
      final samples = SyntheticTapIntentMatrixPolicy.samplesForBundle(bundle);
      expect(samples.length, SyntheticTapIntentMatrixPolicy.attemptsPerScenario);
      expect(samples.map((sample) => sample.label), containsAll(<String>[
        'visual-center',
        'placeholder-left-near',
        'template-region-left',
        'template-region-right',
      ]));
    });

    test('core isolated structural roles pass the 19/20 synthetic tap threshold', () {
      final bundles = <SlotEntry, SlotGeometryBundle>{};
      final roles = <String, MathNodeKind>{
        'fractionNumerator': MathNodeKind.fraction,
        'fractionDenominator': MathNodeKind.fraction,
        'functionArgument': MathNodeKind.functionCall,
        'sqrtValue': MathNodeKind.sqrt,
        'logBase': MathNodeKind.logBase,
        'powerExponent': MathNodeKind.power,
        'subscript': MathNodeKind.subscript,
        'integralUpperLimit': MathNodeKind.integral,
        'integralLowerLimit': MathNodeKind.integral,
        'integralBody': MathNodeKind.integral,
        'integralDifferential': MathNodeKind.integral,
      };
      var index = 0;
      for (final item in roles.entries) {
        final x = 80.0 + index * 135.0;
        final y = index.isEven ? 80.0 : 210.0;
        final bundle = _bundle(
          id: 'slot-${item.key}',
          kind: item.value,
          slotKey: item.key,
          role: item.key,
          visualRect: Rect.fromLTWH(x, y, 30, 22),
        );
        bundles[bundle.entry] = bundle;
        index += 1;
      }

      final matrix = SyntheticTapIntentMatrixPolicy.evaluateMatrix(bundles);
      expect(matrix.scenarioCount, roles.length);
      expect(matrix.passed, isTrue, reason: matrix.scenarios.map((scenario) => scenario.summary).join('\n'));
      expect(matrix.successRate, greaterThanOrEqualTo(SyntheticTapIntentMatrixPolicy.requiredSyntheticSuccessRate));
      for (final scenario in matrix.scenarios) {
        expect(scenario.correct, greaterThanOrEqualTo(SyntheticTapIntentMatrixPolicy.requiredCorrectPerScenario), reason: scenario.summary);
      }
    });

    test('template-region taps suppress detached linear fallback and resolve the intended slot', () {
      final bundle = _bundle(
        id: 'integral-differential',
        kind: MathNodeKind.integral,
        slotKey: 'differential',
        role: 'integralDifferential',
        visualRect: const Rect.fromLTWH(260, 132, 28, 22),
      );
      final bundles = <SlotEntry, SlotGeometryBundle>{bundle.entry: bundle};
      final point = Offset(bundle.visualRect.right + 5, bundle.visualRect.center.dy);
      final result = SyntheticTapIntentMatrixPolicy.resolveSyntheticTap(point: point, bundles: bundles);
      final verdict = SyntheticTapIntentMatrixPolicy.evaluateScenario(target: bundle, bundles: bundles);

      expect(result?.entry.id, bundle.slotId);
      expect(verdict.passed, isTrue, reason: verdict.summary);
      expect(verdict.results.every((tap) => tap.linearFallbackSuppressed), isTrue);
    });

    test('Q62 source is wired without mutating frozen visual surfaces', () {
      final policySource = File('lib/features/formula_engine/synthetic_tap_intent_matrix_policy.dart').readAsStringSync();
      final contractSource = File('lib/logic/mathpro_package_contract.dart').readAsStringSync();
      final verifierSource = File('tool/verify_mathpro_contract.py').readAsStringSync();
      expect(policySource, contains('SyntheticTapIntentMatrixPolicy'));
      expect(policySource, contains('requiredCorrectPerScenario'));
      expect(policySource, contains('structuralIntentMustBeatLinearFallback = true'));
      expect(policySource, contains('realDevicePlus95PassClaimed = false'));
      expect(contractSource, contains('q62SyntheticTapIntentMatrixRule'));
      expect(verifierSource, contains('check_v172_q62_synthetic_tap_intent_matrix'));
      expect(policySource, isNot(contains('keyboardSurfaceMutationAllowed = true')));
      expect(policySource, isNot(contains('longPressSurfaceMutationAllowed = true')));
    });
  });
}

SlotGeometryBundle _bundle({
  required String id,
  required MathNodeKind kind,
  required String slotKey,
  required String role,
  required Rect visualRect,
}) {
  final entry = SlotEntry(
    id: id,
    nodeId: 'node-$id',
    nodeKind: kind,
    slotKey: slotKey,
    role: role,
    priority: 128,
    minTouchSize: 72,
    normalizedBounds: const NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
  );
  final placeholderRect = Rect.fromCenter(
    center: visualRect.center,
    width: 14,
    height: 14,
  );
  return SlotGeometryBundleAuthority.bundleFor(
    entry: entry,
    visualRect: visualRect,
    placeholderRect: placeholderRect,
    baselineY: visualRect.center.dy + 5,
    canvasSize: const Size(1600, 360),
  );
}
