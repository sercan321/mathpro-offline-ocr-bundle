/// V172-Q189 — Single Device Candidate Gate.
///
/// Q189 does not add a new editor, bridge, keyboard layout, Graph UI, History
/// UI, Solution UI, or solver behavior. It freezes the Q184-Q188 production
/// path as a single-device candidate and defines the evidence that must be
/// collected on the user's Android device before any final/premium/release
/// claim can be made.
class MathLiveSingleDeviceCandidatePolicy {
  const MathLiveSingleDeviceCandidatePolicy._();

  static const String phase = 'V172-Q189';
  static const String name = 'Single Device Candidate Gate';
  static const String baseline = 'V172-Q188_PRODUCTION_GRAPH_HISTORY_SOLUTION_ADAPTER';
  static const String productionPath =
      'MathLiveProductionEditorSurface -> main_editor_prod.html -> mathlive_prod_bridge.js -> native math-field';

  static const bool packagesQ184MinimalProductionSurface = true;
  static const bool packagesQ185MinimalProductionHtml = true;
  static const bool packagesQ186MinimalProductionBridge = true;
  static const bool packagesQ187TemplateCommandContract = true;
  static const bool packagesQ188GraphHistorySolutionAdapter = true;

  static const bool singleDeviceCandidateOnly = true;
  static const bool finalReleaseClaimAllowed = false;
  static const bool newFeatureAllowed = false;
  static const bool productionBridgePublicApiMutationAllowed = false;
  static const bool appShellRuntimeMutationAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool fakeEvidenceAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> requiredFlutterCommands = <String>[
    'flutter clean',
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];

  static const List<String> requiredVerifierCommands = <String>[
    'node tool/verify_mathlive_production_simplification_v172_q182.mjs',
    'node tool/verify_mathlive_production_cutover_surface_v172_q184.mjs',
    'node tool/verify_mathlive_production_html_finalization_v172_q185.mjs',
    'node tool/verify_mathlive_production_bridge_contract_v172_q186.mjs',
    'node tool/verify_mathlive_template_command_contract_freeze_v172_q187.mjs',
    'node tool/verify_mathlive_production_graph_history_solution_adapter_v172_q188.mjs',
    'node tool/verify_mathlive_single_device_candidate_v172_q189.mjs',
    'python tool/verify_mathpro_contract.py',
  ];

  static const List<String> requiredManualScenarios = <String>[
    'startup-production-surface-visible',
    'mathlive-virtual-keyboard-hidden',
    'mathlive-badge-menu-debug-chrome-hidden',
    'tap-caret-moves-inside-expression',
    'type-1-plus-1',
    'type-x-squared',
    'fraction-template-visible-and-editable',
    'sqrt-template-visible-and-editable',
    'power-template-visible-and-editable',
    'sin-template-visible-and-editable',
    'log-template-visible-and-editable',
    'sigma-template-visible-and-editable',
    'integral-template-visible-and-editable',
    'taylor-template-not-raw-text',
    'maclaurin-template-not-raw-text',
    'three-equation-template-not-raw-text',
    'delete-backward',
    'clear',
    'enter-evaluate',
    'graph-open-from-mathlive-state',
    'history-record-from-mathlive-state',
    'solution-evaluator-candidate-from-mathlive-state',
  ];

  static const List<String> protectedFiles = <String>[
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/premium_key.dart',
    'lib/features/keyboard/long_press_popup.dart',
    'lib/features/workspace/template_tray.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/graph/graph_controller.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
    'lib/features/solution/solution_steps_panel.dart',
  ];

  static bool isFinalEvidenceComplete({
    required bool flutterAnalyzePass,
    required bool flutterTestPass,
    required bool flutterRunCaptured,
    required bool allVerifierCommandsPass,
    required bool allManualScenariosPass,
    required bool graphHistorySolutionAccepted,
    required bool noRedLineRegressionObserved,
  }) {
    return flutterAnalyzePass &&
        flutterTestPass &&
        flutterRunCaptured &&
        allVerifierCommandsPass &&
        allManualScenariosPass &&
        graphHistorySolutionAccepted &&
        noRedLineRegressionObserved;
  }

  static String candidateStatus({
    required bool flutterAnalyzePass,
    required bool flutterTestPass,
    required bool flutterRunCaptured,
    required bool allVerifierCommandsPass,
    required bool allManualScenariosPass,
    required bool graphHistorySolutionAccepted,
    required bool noRedLineRegressionObserved,
  }) {
    return isFinalEvidenceComplete(
      flutterAnalyzePass: flutterAnalyzePass,
      flutterTestPass: flutterTestPass,
      flutterRunCaptured: flutterRunCaptured,
      allVerifierCommandsPass: allVerifierCommandsPass,
      allManualScenariosPass: allManualScenariosPass,
      graphHistorySolutionAccepted: graphHistorySolutionAccepted,
      noRedLineRegressionObserved: noRedLineRegressionObserved,
    )
        ? 'Q189_DEVICE_CANDIDATE_EVIDENCE_COMPLETE_READY_FOR_FINAL_REVIEW'
        : 'Q189_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED';
  }
}
