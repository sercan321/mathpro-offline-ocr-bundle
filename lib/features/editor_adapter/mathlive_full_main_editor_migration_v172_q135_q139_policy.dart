/// V172-Q135-Q139 — MathLive Full Main Editor Migration Policy.
///
/// This is intentionally not another evidence-only guard. It documents the
/// active migration contract: the legacy Flutter cursor engine may remain in
/// the repository only as rollback code, but the main expression surface must
/// no longer render or hit-test through the legacy caret overlay when the app is
/// in normal workspace mode. The protected MathPro keyboard remains unchanged
/// and routes into the MathLive bridge.
class MathLiveFullMainEditorMigrationV172Q135Q139Policy {
  const MathLiveFullMainEditorMigrationV172Q135Q139Policy._();

  static const String phase = 'V172-Q135-Q139';
  static const bool realMigrationBatch = true;
  static const bool legacyCursorOverlayActiveInMainPath = false;
  static const bool legacyCursorHitTestActiveInMainPath = false;
  static const bool legacyEditorSurfaceFallbackAllowedInMainPath = false;
  static const bool mathLiveMainEditorMandatory = true;
  static const bool mathProKeyboardLayoutMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool legacyCursorPhysicalDeletionInThisBatch = false;
  static const bool legacyRollbackCodeRetained = true;
  static const bool releasePassClaimed = false;
  static const bool cursorPassClaimed = false;

  static const List<String> activeMigrationSteps = <String>[
    'Q135 legacy cursor overlay shutdown on active main route',
    'Q136 legacy hit-test/focus shutdown on active main route',
    'Q137 mandatory MathLive main editor mount',
    'Q138 protected MathPro keyboard to MathLive direct routing',
    'Q139 MathLive state to CalculatorController/evaluator/GHS sync',
  ];

  static bool get mainPathUsesMathLiveOnly {
    return realMigrationBatch &&
        !legacyCursorOverlayActiveInMainPath &&
        !legacyCursorHitTestActiveInMainPath &&
        !legacyEditorSurfaceFallbackAllowedInMainPath &&
        mathLiveMainEditorMandatory;
  }
}
