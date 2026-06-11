/// V172-O regression / contract hardening policy.
///
/// This file is deliberately pure Dart.  It does not change runtime keyboard,
/// long-press, Graph, History, Solution, or solver behavior.  Its job is to
/// make the no-loupe premium cursor engine closure explicit and regression
/// testable: every V172 cursor phase from A through N must stay present, the
/// green debug overlay must remain disabled, and real-device PASS must not be
/// claimed from static/source-only evidence.
class RegressionContractHardeningPolicy {
  const RegressionContractHardeningPolicy._();

  static const String version = 'mathpro-v172o-regression-contract-hardening-v1';

  static const bool editorLoupeEnabled = false;
  static const bool editorLongPressMenuEnabled = false;
  static const bool editorLongPressLabelsEnabled = false;
  static const bool greenDebugOverlayEnabled = false;
  static const bool legacySlotBoxAllowed = false;
  static const bool realDeviceCursorPassClaimed = false;
  static const bool flutterPassClaimedByStaticGate = false;

  static const List<String> requiredCursorPhaseIds = <String>[
    'V172-A-visible-cursor-overlay',
    'V172-B-function-argument-continuity',
    'V172-C-cursor-anchor',
    'V172-D-fraction-power-subscript-precision',
    'V172-E-log-root-nested-function-precision',
    'V172-F-long-expression-auto-scroll',
    'V172-G-structural-deletion',
    'V172-H-matrix-system-cursor',
    'V172-I-calculus-differential-cursor-policy',
    'V172-J-no-loupe-tap-precision',
    'V172-K-gesture-router-without-loupe',
    'V172-L-renderer-sync-geometry-calibration',
    'V172-M-pixel-qa-cursor-matrix',
    'V172-N-premium-cursor-visual-polish',
    'V172-O-regression-contract-hardening',
  ];

  static const List<String> requiredRuntimeFiles = <String>[
    'lib/features/workspace/editor_caret_overlay.dart',
    'lib/features/editor/cursor_anchor.dart',
    'lib/features/editor/selection_controller.dart',
    'lib/features/editor/slot_registry.dart',
    'lib/features/editor/editor_commands.dart',
    'lib/features/editor/calculus_cursor_navigation_policy.dart',
    'lib/features/editor/matrix_cell_navigation_policy.dart',
    'lib/features/formula_engine/premium_tap_precision_policy.dart',
    'lib/features/formula_engine/editor_gesture_router_policy.dart',
    'lib/features/formula_engine/renderer_sync_geometry_policy.dart',
    'lib/features/formula_engine/pixel_qa_cursor_matrix_policy.dart',
    'lib/features/formula_engine/premium_cursor_visual_polish_policy.dart',
    'lib/features/formula_engine/regression_contract_hardening_policy.dart',
  ];

  static const List<String> requiredAuditFiles = <String>[
    'docs/audit/V172_I_CALCULUS_DIFFERENTIAL_CURSOR_AUDIT_REPORT.md',
    'docs/audit/V172_J_NO_LOUPE_TAP_PRECISION_AUDIT_REPORT.md',
    'docs/audit/V172_K_GESTURE_ROUTER_WITHOUT_LOUPE_AUDIT_REPORT.md',
    'docs/audit/V172_L_RENDERER_SYNC_GEOMETRY_AUDIT_REPORT.md',
    'docs/audit/V172_M_PIXEL_QA_CURSOR_MATRIX_AUDIT_REPORT.md',
    'docs/audit/V172_N_PREMIUM_CURSOR_VISUAL_POLISH_AUDIT_REPORT.md',
    'docs/audit/V172_O_REGRESSION_CONTRACT_HARDENING_AUDIT_REPORT.md',
  ];

  static const List<String> protectedContractFiles = <String>[
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/long_press_popup.dart',
    'lib/features/solution/solution_steps_panel.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
  ];

  static const List<String> forbiddenProductionSnippets = <String>[
    'paintVisibleSlotOverlay' ': true',
    'onLongPress:',
    'EditorLoupe',
    'CursorLoupe',
    'Payda',
    'Pay / Payda',
  ];

  static bool containsEveryCursorPhase(Iterable<String> phaseIds) {
    final set = phaseIds.toSet();
    return requiredCursorPhaseIds.every(set.contains);
  }

  static bool requiredRuntimeSetSatisfied(Iterable<String> files) {
    final set = files.toSet();
    return requiredRuntimeFiles.every(set.contains);
  }

  static bool requiredAuditSetSatisfied(Iterable<String> files) {
    final set = files.toSet();
    return requiredAuditFiles.every(set.contains);
  }

  static bool get isNoLoupeContractStrict {
    return !editorLoupeEnabled &&
        !editorLongPressMenuEnabled &&
        !editorLongPressLabelsEnabled &&
        !greenDebugOverlayEnabled &&
        !legacySlotBoxAllowed;
  }
}
