/// V172-Q50 P6-locked +95 cursor candidate freeze.
///
/// This is a release-candidate freeze contract, not a final Photomath/Wolfram
/// PASS claim. Q50 freezes the core cursor scenario matrix and the evidence
/// gates that must be satisfied before anyone can honestly call the cursor
/// +95 on a physical device. It deliberately does not mutate keyboard, MORE,
/// long-press, app shell, Graph, History, Solution, MathLabel, or key-face UI.
class P6LockedCursorCandidateFreezePolicy {
  const P6LockedCursorCandidateFreezePolicy._();

  static const String version =
      'mathpro-v172q50-p6-locked-plus95-cursor-candidate-freeze-v1';

  static const bool p6LockedCursorCandidateFreezeAvailable = true;
  static const bool plus95CandidateMatrixFrozen = true;
  static const bool p6VisualFilesLocked = true;
  static const bool keyboardSurfaceMutationAllowed = false;
  static const bool moreSurfaceMutationAllowed = false;
  static const bool longPressSurfaceMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool mathLabelMutationAllowed = false;
  static const bool premiumKeyMutationAllowed = false;
  static const bool templateTrayMutationAllowed = false;
  static const bool visibleGreenOverlayAllowed = false;
  static const bool loupeOrMenuIntroduced = false;
  static const bool fullNativeMathRendererClaimed = false;
  static const bool trueAstSlotToSvgNodeIdentityClaimed = false;
  static const bool realDevicePlus95PassClaimed = false;
  static const bool flutterAnalyzePassClaimed = false;
  static const bool flutterTestPassClaimed = false;

  static const int requiredAttemptsPerScenario = 20;
  static const int requiredCorrectPerScenario = 19;
  static const double requiredOverallSuccessRate = 0.95;
  static const String targetDeviceId = '23106RN0DA';
  static const String currentPhase = 'V172-Q50';
  static const String nextPhase = 'V172-Q51 real-device QA repair if needed';

  static const List<String> frozenLineageStages = <String>[
    'Q34 deterministic-slot-geometry',
    'Q35 placeholder-safe-cursor-engine',
    'Q36 role-based-cursor-size-engine',
    'Q37 fraction-precision-engine',
    'Q38 script-precision-engine',
    'Q39 log-root-precision-engine',
    'Q40 digit-level-caret-stops',
    'Q41 nested-expression-depth-engine',
    'Q42 drag-to-move-cursor-stability',
    'Q43 structural-insert-delete-safety',
    'Q44 renderer-sync-upgrade',
    'Q45 real-device-pixel-qa-court',
    'Q46 renderer-slot-identity-prototype',
    'Q47 true-glyph-level-caret-stops',
    'Q48 native-layoutbox-cursor-layer',
    'Q49 structural-cursor-release-hardening',
    'Q50 p6-locked-plus95-cursor-candidate-freeze',
  ];

  static const List<CursorCandidateFreezeScenario> coreScenarioMatrix = <CursorCandidateFreezeScenario>[
    CursorCandidateFreezeScenario(
      id: 'q50-root-placeholder-slot',
      expression: '√□',
      intent: 'root radicand placeholder caret must not overlap placeholder box',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-power-placeholder-slot',
      expression: 'x^□',
      intent: 'power exponent caret must be compact and slot-local',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-subscript-placeholder-slot',
      expression: 'x_□',
      intent: 'subscript caret must be compact and not stolen by baseline slot',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-log-base-and-argument-slots',
      expression: 'log_□(□)',
      intent: 'log base and argument slots must stay separately selectable',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-fraction-simple',
      expression: '9/6',
      intent: 'fraction numerator and denominator lanes must not swap',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-fraction-filled-denominator',
      expression: '12/345',
      intent: 'filled denominator caret must allow digit-gap selection',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-long-number-digit-gaps',
      expression: '123456789',
      intent: 'plain long-number digit gaps must be selectable',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-cos-long-argument-digit-gaps',
      expression: 'cos(99666655)',
      intent: 'function argument digit gaps must not auto-exit the parentheses',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-sin-filled-argument-digit-gaps',
      expression: 'sin(300)',
      intent: 'filled sin argument must remain slot-local during taps',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-ln-filled-argument-digit-gaps',
      expression: 'ln(123456)',
      intent: 'ln argument digit gaps must beat nearby structural anchors',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-nested-ln-depth',
      expression: 'ln(ln(8))',
      intent: 'inner nested ln slot must beat outer parent slot when tapped',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-nested-trig-depth',
      expression: 'sin(cos(300))',
      intent: 'inner cos argument slot must not be stolen by outer sin slot',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-root-log-trig-nested-mix',
      expression: '√(sin(x)+log₂(500))',
      intent: 'root, trig argument, log base, and log argument lanes must remain distinct',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
    CursorCandidateFreezeScenario(
      id: 'q50-long-mixed-expression-pan-drag',
      expression: 'sin(300)+cos(400)+log₂(500)+√(600)',
      intent: 'long mixed expression must keep caret stable during tap/drag/pan',
      minimumCorrectSelections: requiredCorrectPerScenario,
    ),
  ];

  static const Set<String> protectedP6Files = <String>{
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/long_press_popup.dart',
    'lib/features/keyboard/premium_key.dart',
    'lib/features/workspace/math_label.dart',
    'lib/features/workspace/template_tray.dart',
    'lib/app/app_shell.dart',
    'lib/features/solution/solution_steps_panel.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
  };

  static const Set<String> surgicalCursorPathPrefixes = <String>{
    'lib/features/editor/',
    'lib/features/workspace/editor_caret_overlay.dart',
    'lib/features/workspace/editor_viewport.dart',
    'lib/features/formula_engine/',
    'lib/logic/mathpro_package_contract.dart',
    'test/',
    'tool/',
    'docs/audit/',
    'README.md',
    'pubspec.yaml',
  };

  static bool get hasCompleteCoreScenarioMatrix {
    final ids = coreScenarioMatrix.map((scenario) => scenario.id).toSet();
    final expressions = coreScenarioMatrix.map((scenario) => scenario.expression).toSet();
    return coreScenarioMatrix.length == 14 &&
        ids.length == coreScenarioMatrix.length &&
        expressions.contains('√□') &&
        expressions.contains('log_□(□)') &&
        expressions.contains('123456789') &&
        expressions.contains('ln(ln(8))') &&
        expressions.contains('√(sin(x)+log₂(500))') &&
        expressions.contains('sin(300)+cos(400)+log₂(500)+√(600)');
  }

  static bool get hasFrozenLineageWithoutDuplicates {
    return frozenLineageStages.toSet().length == frozenLineageStages.length &&
        frozenLineageStages.first.startsWith('Q34') &&
        frozenLineageStages.last.startsWith('Q50');
  }

  static bool isProtectedP6File(String relativePath) {
    final normalized = relativePath.replaceAll('\\', '/');
    return protectedP6Files.contains(normalized);
  }

  static bool isAllowedSurgicalCursorPath(String relativePath) {
    final normalized = relativePath.replaceAll('\\', '/');
    if (isProtectedP6File(normalized)) return false;
    return surgicalCursorPathPrefixes.any((prefix) => normalized == prefix || normalized.startsWith(prefix));
  }

  static int requiredTotalAttempts(int scenarioCount) {
    final safeScenarioCount = scenarioCount < 0 ? 0 : scenarioCount;
    return safeScenarioCount * requiredAttemptsPerScenario;
  }

  static int requiredTotalCorrect(int scenarioCount) {
    final safeScenarioCount = scenarioCount < 0 ? 0 : scenarioCount;
    return safeScenarioCount * requiredCorrectPerScenario;
  }

  static bool canClaimPlus95CandidatePass({
    required int scenarioCount,
    required int totalAttempts,
    required int totalCorrect,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool realDeviceRunEvidence,
    required bool pixelQaEvidenceAvailable,
  }) {
    if (scenarioCount < coreScenarioMatrix.length) return false;
    if (totalAttempts < requiredTotalAttempts(coreScenarioMatrix.length)) return false;
    if (totalCorrect < requiredTotalCorrect(coreScenarioMatrix.length)) return false;
    if (!flutterAnalyzePassed || !flutterTestPassed || !realDeviceRunEvidence || !pixelQaEvidenceAvailable) return false;
    final rate = totalAttempts <= 0 ? 0.0 : totalCorrect / totalAttempts;
    return rate >= requiredOverallSuccessRate;
  }

  static String evidenceVerdict({
    required int scenarioCount,
    required int totalAttempts,
    required int totalCorrect,
    required bool flutterAnalyzePassed,
    required bool flutterTestPassed,
    required bool realDeviceRunEvidence,
    required bool pixelQaEvidenceAvailable,
  }) {
    return canClaimPlus95CandidatePass(
      scenarioCount: scenarioCount,
      totalAttempts: totalAttempts,
      totalCorrect: totalCorrect,
      flutterAnalyzePassed: flutterAnalyzePassed,
      flutterTestPassed: flutterTestPassed,
      realDeviceRunEvidence: realDeviceRunEvidence,
      pixelQaEvidenceAvailable: pixelQaEvidenceAvailable,
    )
        ? 'PASS: +95 candidate evidence threshold met'
        : 'CONDITIONAL PASS ONLY: Q50 candidate is frozen, but real Flutter/device evidence is still required';
  }
}

class CursorCandidateFreezeScenario {
  const CursorCandidateFreezeScenario({
    required this.id,
    required this.expression,
    required this.intent,
    required this.minimumCorrectSelections,
  });

  final String id;
  final String expression;
  final String intent;
  final int minimumCorrectSelections;
}
