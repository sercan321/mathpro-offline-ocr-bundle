import 'dart:ui';

import '../editor/slot_registry.dart';
import 'cursor_golden_geometry_court_policy.dart';
import 'slot_geometry_bundle_authority.dart';
import 'slot_hit_testing.dart';
import 'structural_intent_resolver_policy.dart';

/// V172-Q62 synthetic tap intent matrix for the existing MathPro cursor engine.
/// Q80R1 repairs stale wording: after Q71-Q80 the matrix validates authoritative
/// SlotBox hits, not nearest structural guessing.
///
/// Q62 does not add a visible UI surface and it does not mutate keyboard, MORE,
/// long-press, app shell, Graph, History or Solution. It creates a code-level
/// court that simulates phone-like taps around core structural slots so the
/// engine can be pushed toward +95 confidence before expensive real-device
/// checkpoints.
class SyntheticTapIntentMatrixPolicy {
  const SyntheticTapIntentMatrixPolicy._();

  static const String version = 'mathpro-v172-q62-synthetic-tap-intent-matrix-p6-locked-v1';

  static const bool syntheticTapIntentMatrixAvailable = true;
  static const bool syntheticPhoneTapCourtEnabled = true;
  static const bool structuralIntentMustBeatLinearFallback = true;
  static const bool exactStructuralHitMustResolveTargetSlot = true;
  static const bool nearestStructuralHitMustResolveTargetSlot = false;
  static const bool authoritativeSlotBoxHitMustResolveTargetSlot = true;
  static const bool templateRegionMustSuppressDetachedLinearFallback = true;
  static const bool slotGeometryBundleAuthorityRequired = true;
  static const bool cursorGoldenGeometryCourtRequired = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const int attemptsPerScenario = CursorGoldenGeometryCourtPolicy.attemptsPerScenario;
  static const int requiredCorrectPerScenario = CursorGoldenGeometryCourtPolicy.requiredCorrectPerScenario;
  static const double requiredSyntheticSuccessRate = CursorGoldenGeometryCourtPolicy.requiredCoreSuccessRate;

  static const List<String> coreSyntheticTapRoles = <String>[
    'fractionNumerator',
    'fractionDenominator',
    'functionArgument',
    'functionArgument2',
    'functionArgument3',
    'sqrtValue',
    'rootIndex',
    'logBase',
    'powerExponent',
    'subscript',
    'integralUpperLimit',
    'integralLowerLimit',
    'integralBody',
    'integralDifferential',
  ];

  static SyntheticTapScenarioVerdict evaluateScenario({
    required SlotGeometryBundle target,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
  }) {
    final samples = samplesForBundle(target);
    final results = <SyntheticTapResult>[];
    for (final sample in samples) {
      final result = StructuralIntentResolverPolicy.resolveIntent(
        point: sample.point,
        bundles: bundles,
        primaryHit: null,
        structuralInteractionEnabled: true,
      );
      final linearSuppressed = StructuralIntentResolverPolicy.shouldSuppressLinearFallbackForTemplateRegion(
        point: sample.point,
        bundles: bundles,
        structuralInteractionEnabled: true,
      );
      results.add(SyntheticTapResult(
        sample: sample,
        resolvedRole: result?.entry.role,
        resolvedSlotId: result?.entry.id,
        resolvedSource: result?.source,
        passed: result?.entry.id == target.slotId && linearSuppressed,
        linearFallbackSuppressed: linearSuppressed,
      ));
    }
    final passVector = results.map((result) => result.passed).toList(growable: false);
    final successRate = CursorGoldenGeometryCourtPolicy.successRateForResults(passVector);
    final correct = passVector.where((value) => value).length;
    return SyntheticTapScenarioVerdict(
      role: target.role,
      slotId: target.slotId,
      attempts: results.length,
      correct: correct,
      successRate: successRate,
      passed: correct >= requiredCorrectPerScenario && successRate >= requiredSyntheticSuccessRate,
      results: List<SyntheticTapResult>.unmodifiable(results),
    );
  }

  static bool passesSyntheticPlus95Scenario({
    required SlotGeometryBundle target,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
  }) {
    return evaluateScenario(target: target, bundles: bundles).passed;
  }

  static SyntheticTapMatrixVerdict evaluateMatrix(Map<SlotEntry, SlotGeometryBundle> bundles) {
    final scenarioVerdicts = <SyntheticTapScenarioVerdict>[];
    for (final bundle in bundles.values) {
      if (!coreSyntheticTapRoles.contains(bundle.role)) continue;
      scenarioVerdicts.add(evaluateScenario(target: bundle, bundles: bundles));
    }
    final passed = scenarioVerdicts.isNotEmpty && scenarioVerdicts.every((verdict) => verdict.passed);
    final attempts = scenarioVerdicts.fold<int>(0, (sum, verdict) => sum + verdict.attempts);
    final correct = scenarioVerdicts.fold<int>(0, (sum, verdict) => sum + verdict.correct);
    final successRate = attempts == 0 ? 0.0 : correct / attempts;
    return SyntheticTapMatrixVerdict(
      passed: passed,
      scenarioCount: scenarioVerdicts.length,
      attempts: attempts,
      correct: correct,
      successRate: successRate,
      scenarios: List<SyntheticTapScenarioVerdict>.unmodifiable(scenarioVerdicts),
    );
  }

  static List<SyntheticTapSample> samplesForBundle(SlotGeometryBundle bundle) {
    final hit = bundle.hitRect;
    final visual = bundle.visualRect;
    final placeholder = bundle.placeholderRect;
    final lead = bundle.leadingRailRect;
    final trail = bundle.trailingRailRect;
    final inner = bundle.innerTextRect;
    final points = <SyntheticTapSample>[
      SyntheticTapSample(label: 'visual-center', point: visual.center),
      SyntheticTapSample(label: 'hit-center', point: hit.center),
      SyntheticTapSample(label: 'placeholder-center', point: placeholder.center),
      SyntheticTapSample(label: 'leading-rail-center', point: lead.center),
      SyntheticTapSample(label: 'trailing-rail-center', point: trail.center),
      SyntheticTapSample(label: 'inner-text-center', point: inner.center),
      SyntheticTapSample(label: 'visual-left-edge', point: Offset(visual.left + 1.0, visual.center.dy)),
      SyntheticTapSample(label: 'visual-right-edge', point: Offset(visual.right - 1.0, visual.center.dy)),
      SyntheticTapSample(label: 'visual-top-edge', point: Offset(visual.center.dx, visual.top + 1.0)),
      SyntheticTapSample(label: 'visual-bottom-edge', point: Offset(visual.center.dx, visual.bottom - 1.0)),
      SyntheticTapSample(label: 'placeholder-left-near', point: Offset(placeholder.left - 2.0, placeholder.center.dy)),
      SyntheticTapSample(label: 'placeholder-right-near', point: Offset(placeholder.right + 2.0, placeholder.center.dy)),
      SyntheticTapSample(label: 'hit-left-cushion', point: Offset(hit.left + hit.width * 0.18, hit.center.dy)),
      SyntheticTapSample(label: 'hit-right-cushion', point: Offset(hit.right - hit.width * 0.18, hit.center.dy)),
      SyntheticTapSample(label: 'hit-upper-cushion', point: Offset(hit.center.dx, hit.top + hit.height * 0.18)),
      SyntheticTapSample(label: 'hit-lower-cushion', point: Offset(hit.center.dx, hit.bottom - hit.height * 0.18)),
      SyntheticTapSample(label: 'template-region-left', point: Offset(visual.left - 6.0, visual.center.dy)),
      SyntheticTapSample(label: 'template-region-right', point: Offset(visual.right + 6.0, visual.center.dy)),
      SyntheticTapSample(label: 'template-region-upper', point: Offset(visual.center.dx, visual.top - 4.0)),
      SyntheticTapSample(label: 'template-region-lower', point: Offset(visual.center.dx, visual.bottom + 4.0)),
    ];
    assert(points.length == attemptsPerScenario);
    return List<SyntheticTapSample>.unmodifiable(points);
  }

  static SlotHitTestResult? resolveSyntheticTap({
    required Offset point,
    required Map<SlotEntry, SlotGeometryBundle> bundles,
  }) {
    return StructuralIntentResolverPolicy.resolveIntent(
      point: point,
      bundles: bundles,
      primaryHit: null,
      structuralInteractionEnabled: true,
    );
  }
}

class SyntheticTapSample {
  const SyntheticTapSample({required this.label, required this.point});

  final String label;
  final Offset point;
}

class SyntheticTapResult {
  const SyntheticTapResult({
    required this.sample,
    required this.resolvedRole,
    required this.resolvedSlotId,
    required this.resolvedSource,
    required this.passed,
    required this.linearFallbackSuppressed,
  });

  final SyntheticTapSample sample;
  final String? resolvedRole;
  final String? resolvedSlotId;
  final String? resolvedSource;
  final bool passed;
  final bool linearFallbackSuppressed;
}

class SyntheticTapScenarioVerdict {
  const SyntheticTapScenarioVerdict({
    required this.role,
    required this.slotId,
    required this.attempts,
    required this.correct,
    required this.successRate,
    required this.passed,
    required this.results,
  });

  final String role;
  final String slotId;
  final int attempts;
  final int correct;
  final double successRate;
  final bool passed;
  final List<SyntheticTapResult> results;

  String get summary => passed
      ? 'PASS $role $correct/$attempts ${(successRate * 100).toStringAsFixed(1)}%'
      : 'FAIL $role $correct/$attempts ${(successRate * 100).toStringAsFixed(1)}%';
}

class SyntheticTapMatrixVerdict {
  const SyntheticTapMatrixVerdict({
    required this.passed,
    required this.scenarioCount,
    required this.attempts,
    required this.correct,
    required this.successRate,
    required this.scenarios,
  });

  final bool passed;
  final int scenarioCount;
  final int attempts;
  final int correct;
  final double successRate;
  final List<SyntheticTapScenarioVerdict> scenarios;
}
