import '../features/formula_engine/long_expression_navigation_policy.dart';
import '../features/formula_engine/premium_editor_performance_policy.dart';
import '../features/formula_engine/real_device_slot_test_protocol.dart';
import '../features/formula_engine/slot_interaction_calibration_policy.dart';
import 'math_key_inventory.dart';
import 'premium_math_key_specs.dart';
import 'premium_math_surface_policy.dart';

/// Code-level readiness gate for MathPro's real-device UX pass.
///
/// This file does not claim that the app was tested on a physical device. It
/// defines the exact preflight and evidence requirements that must be satisfied
/// before anyone may call the editor interaction work "real-device PASS".  The
/// goal is to prevent fake success while keeping the premium editor bar focused
/// on the user's actual pain points: tappable math slots, no raw programmer
/// labels, no debug leaks, no keyboard contract drift, no long-expression cursor
/// loss, and no popup clipping drift.
class RealDeviceUxReadinessGate {
  const RealDeviceUxReadinessGate._();

  static const String version = 'mathpro-v155-v162-real-device-ux-readiness-gate-and-regression-evidence-v1';

  static const String targetDeviceId = RealDeviceSlotTestProtocol.targetDeviceId;
  static const int requiredAttemptsPerScenario = RealDeviceSlotTestProtocol.attemptsPerScenario;
  static const int requiredCorrectPerScenario = RealDeviceSlotTestProtocol.minimumCorrectPerScenario;
  static const double requiredOverallSuccessRate = RealDeviceSlotTestProtocol.minimumOverallSuccessRate;


  /// V154: the minimum public surfaces that must be manually inspected on a
  /// physical device after the AST/token migration. These labels are selected
  /// from the real keyboard, MORE and long-press inventory; the gate does not
  /// claim they were tested, it prevents a release from forgetting them.
  static const Set<String> criticalKeySurfaceLabels = <String>{
    '□/□', '√□', '□^□', '|□|', 'sin⁻¹(□)', 'cos⁻¹(□)', 'tan⁻¹(□)',
    'log₁₀(□)', 'log₂(□)', 'log_□(□)', '∫□dx', '∫ₐᵇ', '∫₀¹ f(x)',
    'lim x→□', 'lim sin(x)/x', 'Σ', 'Π', 'Taylor', 'Geometrik',
    'x₁', 'y′', 'y″', 'y‴', 'z̄', 'i²', 'dx', 'dy', 'dθ',
    '2×2 Matris', 'det(□)', 'RREF', 'f(□)', 'g(□)', 'f∘g', 'Kuadratik',
  };

  /// Extra real-device UX surfaces added after the older V65 slot protocol.
  /// These are intentionally product-level observations, not solver/CAS tests.
  static const List<ManualUxScenario> additionalManualScenarios = <ManualUxScenario>[
    ManualUxScenario(
      id: 'log-longpress-premium-visual',
      surface: 'longPress/log',
      expression: 'log₁₀(□), log₂(□), log_□(□)',
      expected: 'Log base is visually attached as a real subscript/base slot and no chip is clipped.',
    ),
    ManualUxScenario(
      id: 'trig-inverse-display-no-raw-token',
      surface: 'longPress+MORE/trig',
      expression: 'sin⁻¹(□), cos⁻¹(□), tan⁻¹(□), sinh⁻¹(□)',
      expected: 'UI never displays asin/acos/atan/asinh/acosh/atanh; inverse notation remains mathematical.',
    ),
    ManualUxScenario(
      id: 'subscript-slot-real-editing',
      surface: 'keyboard+longPress/subscript',
      expression: 'x_□, y_□, I_□',
      expected: 'Tap on the lower slot routes input into the subscript; no stray n token appears.',
    ),
    ManualUxScenario(
      id: 'more-full-surface-premium-scan',
      surface: 'MORE/all-categories',
      expression: 'all MORE categories',
      expected: 'No internal token, duplicate-looking raw template, clipped chip, or debug label appears.',
    ),
    ManualUxScenario(
      id: 'android-navbar-keyboard-clearance',
      surface: 'keyboard/bottom-dock',
      expression: 'Temel and expanded tabs',
      expected: 'Keyboard stays clear of Android navigation bar and maintains the frozen key topology.',
    ),
    ManualUxScenario(
      id: 'long-expression-pan-caret-follow-device',
      surface: 'workspace/editor-viewport',
      expression: 'deep nested log/sqrt/fraction/integral expression',
      expected: 'Pan/zoom remains smooth; active slot/caret stays visible and tappable after transform.',
    ),

    ManualUxScenario(
      id: 'v154-critical-keycap-surface-scan',
      surface: 'keyboard+expanded-tabs/keycaps',
      expression: 'criticalKeySurfaceLabels',
      expected: 'Every critical keycap renders as a premium math glyph with no clipping, stale raw label, or topology drift.',
    ),
    ManualUxScenario(
      id: 'v154-longpress-chip-surface-scan',
      surface: 'longPress/all-high-risk-keys',
      expression: 'root/log/trig/calculus/function chips',
      expected: 'Long-press cards keep equal optical scale, no side clipping, no programmer alias, and tappable slots remain visible.',
    ),
    ManualUxScenario(
      id: 'v154-editor-insertion-roundtrip-scan',
      surface: 'editor/render+hit-test',
      expression: 'criticalKeySurfaceLabels inserted into editor',
      expected: 'Inserted expressions use semantic nodes, serialize to user-safe math, and delete/caret behavior remains atomic where promised.',
    ),
  ];

  static const List<String> requiredEvidenceItems = <String>[
    'flutter pub get log',
    'flutter analyze log',
    'flutter test log',
    'flutter run -d 23106RN0DA launch evidence',
    'screen recording for log/trig/subscript interactions',
    'screen recording for MORE full-surface scan',
    'screen recording for long-expression pan/caret-follow',
    'screenshots proving keyboard/navigation-bar clearance',
    'screenshots proving no debug/technical labels are visible',
    'V154 critical-key surface checklist',
    'V154 long-press chip sweep screenshots or video',
    'V154 editor insertion/delete/caret sweep screenshots or video',
    'V155 final flutter analyze/test log',
    'V155 zip hygiene verification',
    'V155 protected-surface unchanged verification',
    'V155 release verdict with no fake PASS wording',
  ];

  static Set<String> get requiredManualScenarioIds => <String>{
        for (final scenario in RealDeviceSlotTestProtocol.scenarios) scenario.id,
        for (final scenario in additionalManualScenarios) scenario.id,
      };

  static List<String> staticPreflightBlockers() {
    final blockers = <String>[];


    final missingCriticalLabels = criticalKeySurfaceLabels.difference(MathKeyInventory.publicUiLabels);
    if (missingCriticalLabels.isNotEmpty) {
      blockers.add('V154 critical key surface labels are missing from public UI: ${missingCriticalLabels.join(', ')}.');
    }
    for (final label in criticalKeySurfaceLabels.intersection(MathKeyInventory.publicUiLabels)) {
      if (!PremiumMathSurfacePolicy.isMathSurface(label)) {
        blockers.add('V154 critical surface is not classified as math surface: $label.');
      }
    }

    if (MathKeyInventory.publicUiProgrammerTokenLeaks.isNotEmpty) {
      blockers.add('Public UI still exposes programmer tokens: ${MathKeyInventory.publicUiProgrammerTokenLeaks.join(', ')}.');
    }
    if (PremiumMathKeySpecs.duplicateLabels.isNotEmpty) {
      blockers.add('PremiumMathKeySpecs contains duplicate labels: ${PremiumMathKeySpecs.duplicateLabels.join(', ')}.');
    }
    if (MathKeyInventory.missingPhase04RequiredSpecLabels.isNotEmpty) {
      blockers.add('Required public math labels are not spec-backed: ${MathKeyInventory.missingPhase04RequiredSpecLabels.join(', ')}.');
    }
    if (PremiumMathSurfacePolicy.longPressChipWidth('log_□(□)') < 112) {
      blockers.add('log long-press chip width is below the premium tappable/readable threshold.');
    }
    if (PremiumMathSurfacePolicy.longPressChipWidth('sin⁻¹(□)') < 112) {
      blockers.add('inverse trig long-press chip width is below the premium tappable/readable threshold.');
    }
    if (SlotInteractionCalibrationPolicy.minTouchSizeForRole('logBase', 0) < 88) {
      blockers.add('log base slot target is below mobile minimum.');
    }
    if (SlotInteractionCalibrationPolicy.minTouchSizeForRole('subscript', 0) < 88) {
      blockers.add('subscript slot target is below mobile minimum.');
    }
    if (SlotInteractionCalibrationPolicy.minTouchSizeForRole('functionArgument', 0) < 112) {
      blockers.add('function argument target is below premium mobile minimum.');
    }
    if (SlotInteractionCalibrationPolicy.minTouchSizeForRole('matrixCell', 0) < 72) {
      blockers.add('matrix cell target is below practical mobile minimum.');
    }
    if (LongExpressionNavigationPolicy.maxCanvasWidth != PremiumEditorPerformancePolicy.maxMeasuredExpressionWidth) {
      blockers.add('Long-expression canvas width and performance max width are not governed by the same policy.');
    }
    if (!RealDeviceSlotTestProtocol.requiredFlutterCommands.contains('flutter run -d 23106RN0DA')) {
      blockers.add('Real-device launch command for $targetDeviceId is not locked in the evidence protocol.');
    }

    return blockers;
  }

  static RealDeviceUxReadinessVerdict evaluateStaticReadiness() {
    final blockers = staticPreflightBlockers();
    return RealDeviceUxReadinessVerdict(
      readyForManualRun: blockers.isEmpty,
      passClaimAllowed: false,
      blockers: blockers,
      warnings: const <String>[
        'Static readiness is not a real-device PASS. Run the physical-device evidence protocol before any PASS claim.',
      ],
    );
  }

  static RealDeviceUxReadinessVerdict evaluateManualEvidence({
    required RealDeviceSlotTestReport slotReport,
    required Set<String> completedAdditionalScenarioIds,
    required Set<String> attachedEvidenceItems,
    required bool noDebugLeakConfirmed,
    required bool keyboardTopologyConfirmed,
    required bool moreSurfaceScanConfirmed,
  }) {
    final blockers = <String>[...staticPreflightBlockers()];
    final warnings = <String>[];

    final slotVerdict = RealDeviceSlotTestProtocol.evaluate(slotReport);
    if (!slotVerdict.pass) {
      blockers.addAll(slotVerdict.blockers.map((blocker) => 'V65 slot protocol: $blocker'));
    }

    final missingAdditionalScenarios = additionalManualScenarios
        .map((scenario) => scenario.id)
        .where((id) => !completedAdditionalScenarioIds.contains(id))
        .toList(growable: false);
    if (missingAdditionalScenarios.isNotEmpty) {
      blockers.add('Missing V93 manual UX scenarios: ${missingAdditionalScenarios.join(', ')}.');
    }

    final missingEvidence = requiredEvidenceItems
        .where((item) => !attachedEvidenceItems.contains(item))
        .toList(growable: false);
    if (missingEvidence.isNotEmpty) {
      blockers.add('Missing required real-device evidence: ${missingEvidence.join(', ')}.');
    }

    if (!noDebugLeakConfirmed) {
      blockers.add('No-debug-leak visual confirmation is missing.');
    }
    if (!keyboardTopologyConfirmed) {
      blockers.add('Frozen keyboard topology confirmation is missing.');
    }
    if (!moreSurfaceScanConfirmed) {
      blockers.add('Full MORE surface premium scan confirmation is missing.');
    }

    if (blockers.isEmpty) {
      warnings.add('Manual evidence gate is satisfied, but this code path still does not execute the real device itself. Keep attached logs/screens as release evidence.');
    }

    return RealDeviceUxReadinessVerdict(
      readyForManualRun: staticPreflightBlockers().isEmpty,
      passClaimAllowed: blockers.isEmpty,
      blockers: blockers,
      warnings: warnings,
    );
  }
}

class ManualUxScenario {
  const ManualUxScenario({
    required this.id,
    required this.surface,
    required this.expression,
    required this.expected,
  });

  final String id;
  final String surface;
  final String expression;
  final String expected;
}

class RealDeviceUxReadinessVerdict {
  const RealDeviceUxReadinessVerdict({
    required this.readyForManualRun,
    required this.passClaimAllowed,
    required this.blockers,
    required this.warnings,
  });

  final bool readyForManualRun;
  final bool passClaimAllowed;
  final List<String> blockers;
  final List<String> warnings;
}
