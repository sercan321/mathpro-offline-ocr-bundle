import 'dart:ui';

import 'slot_geometry_bundle_authority.dart';

/// V172-Q61 cursor golden geometry court.
///
/// This is not a new visible UI surface and it does not mutate keyboard, MORE,
/// long-press, app shell, Graph, History or Solution. It formalizes the cursor
/// geometry invariants that must be true before expensive real-device checks:
///
/// * hitRect is allowed to be generous for touch comfort,
/// * active-empty caret must use the leading rail (`|□`),
/// * the caret must not overlap the placeholder box,
/// * the caret must stay optically close to the placeholder edge,
/// * filled slots must use innerTextRect instead of being forced to `|□`.
class CursorGoldenGeometryCourtPolicy {
  const CursorGoldenGeometryCourtPolicy._();

  static const String version = 'mathpro-v172-q61-cursor-golden-geometry-court-p6-locked-v1';

  static const bool cursorGoldenGeometryCourtAvailable = true;
  static const bool goldenGeometryCourtEnabled = true;
  static const bool hitRectMayBeGenerous = true;
  static const bool hitRectNeverPaintsCaret = true;
  static const bool emptyActiveSlotMustUseLeadingRail = true;
  static const bool placeholderOverlapAllowed = false;
  static const bool detachedCaretDriftAllowed = false;
  static const bool filledSlotInnerTextCaretPreserved = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;

  static const int attemptsPerScenario = 20;
  static const int requiredCorrectPerScenario = 19;
  static const double requiredCoreSuccessRate = 0.95;
  static const double minimumOpticalGap = 0.60;
  static const double maximumOpticalGap = 4.25;
  static const double maximumVerticalCenterDelta = 3.75;

  static const List<String> coreGoldenRoles = <String>[
    'fractionNumerator',
    'fractionDenominator',
    'functionArgument',
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

  static CursorGoldenGeometryVerdict evaluateEmptySlotBundle(SlotGeometryBundle bundle) {
    final caret = bundle.leadingRailRect;
    final gap = leadingGapFor(bundle);
    final verticalDelta = (caret.center.dy - bundle.placeholderRect.center.dy).abs();
    final failures = <String>[];

    if (caret.overlaps(bundle.placeholderRect)) {
      failures.add('caret-overlaps-placeholder');
    }
    if (caret.right > bundle.placeholderRect.left) {
      failures.add('caret-not-before-placeholder');
    }
    if (gap < minimumOpticalGap) {
      failures.add('caret-too-close-to-placeholder');
    }
    if (gap > maximumOpticalGap) {
      failures.add('caret-detached-from-placeholder');
    }
    if (verticalDelta > maximumVerticalCenterDelta) {
      failures.add('caret-vertical-center-drift');
    }
    if (bundle.leadingRailRect == bundle.hitRect || bundle.trailingRailRect == bundle.hitRect) {
      failures.add('caret-uses-hit-rect');
    }
    if (!coreGoldenRoles.contains(bundle.role) && _isCoreLikeRole(bundle.role)) {
      failures.add('core-role-not-registered');
    }

    return CursorGoldenGeometryVerdict(
      role: bundle.role,
      passed: failures.isEmpty,
      failures: List<String>.unmodifiable(failures),
      leadingGap: gap,
      verticalCenterDelta: verticalDelta,
    );
  }

  static bool isGoldenEmptySlotBundle(SlotGeometryBundle bundle) {
    return evaluateEmptySlotBundle(bundle).passed;
  }

  static double leadingGapFor(SlotGeometryBundle bundle) {
    return bundle.placeholderRect.left - bundle.leadingRailRect.right;
  }

  static Rect expectedEmptySlotCaret(SlotGeometryBundle bundle) {
    return bundle.leadingRailRect;
  }

  static bool caretUsesExpectedLeadingRail({
    required SlotGeometryBundle bundle,
    required Rect caretRect,
  }) {
    return _rectClose(caretRect, bundle.leadingRailRect, tolerance: 0.75);
  }

  static double successRateForResults(Iterable<bool> results) {
    final values = List<bool>.unmodifiable(results);
    if (values.isEmpty) return 0;
    final correct = values.where((value) => value).length;
    return correct / values.length;
  }

  static bool passesPlus95SyntheticThreshold(Iterable<bool> results) {
    final values = List<bool>.unmodifiable(results);
    if (values.length < attemptsPerScenario) return false;
    final correct = values.where((value) => value).length;
    return correct >= requiredCorrectPerScenario && successRateForResults(values) >= requiredCoreSuccessRate;
  }

  static bool filledCaretIsInsideInnerText({
    required SlotGeometryBundle bundle,
    required Rect caretRect,
  }) {
    final padded = bundle.innerTextRect.inflate(2.0);
    return padded.contains(caretRect.center) && !_rectClose(caretRect, bundle.leadingRailRect, tolerance: 0.75);
  }

  static bool _rectClose(Rect a, Rect b, {required double tolerance}) {
    return (a.left - b.left).abs() <= tolerance &&
        (a.top - b.top).abs() <= tolerance &&
        (a.width - b.width).abs() <= tolerance &&
        (a.height - b.height).abs() <= tolerance;
  }

  static bool _isCoreLikeRole(String role) {
    final lower = role.toLowerCase();
    return lower.contains('fraction') ||
        lower.contains('function') ||
        lower.contains('sqrt') ||
        lower.contains('root') ||
        lower.contains('log') ||
        lower.contains('power') ||
        lower.contains('subscript') ||
        lower.contains('integral');
  }
}

class CursorGoldenGeometryVerdict {
  const CursorGoldenGeometryVerdict({
    required this.role,
    required this.passed,
    required this.failures,
    required this.leadingGap,
    required this.verticalCenterDelta,
  });

  final String role;
  final bool passed;
  final List<String> failures;
  final double leadingGap;
  final double verticalCenterDelta;

  String get summary => passed
      ? 'PASS $role gap=${leadingGap.toStringAsFixed(2)} vertical=${verticalCenterDelta.toStringAsFixed(2)}'
      : 'FAIL $role ${failures.join(', ')}';
}
