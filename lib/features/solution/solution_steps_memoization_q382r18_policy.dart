/// V172-Q382R18 — Solution Steps memoization / closed-panel compute guard.
///
/// This policy documents the performance contract added in AppShell:
/// SolutionStepsComposer must not run on every keyboard-driven rebuild while
/// the Solution Steps panel is closed, and repeated open-panel builds with the
/// same semantic inputs must reuse the cached SolutionStepsSnapshot.
class SolutionStepsMemoizationQ382R18Policy {
  const SolutionStepsMemoizationQ382R18Policy._();

  static const String phase = 'V172-Q382R18';
  static const String contract = 'solution-steps-memoization-closed-panel-compose-guard';
  static const bool composerSkippedWhenPanelClosed = true;
  static const bool memoizesOpenPanelSnapshotBySemanticInputs = true;
  static const bool preservesSolutionComposerOutputWhenOpen = true;
  static const bool doesNotTouchKeyboardLayout = true;
  static const bool doesNotTouchMathLiveBridge = true;
  static const bool doesNotTouchOcrCameraAndroidGraphHistorySolver = true;
}
