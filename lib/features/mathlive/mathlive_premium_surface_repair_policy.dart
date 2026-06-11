/// V172-Q140 — MathLive Premium Surface Repair policy.
///
/// This is a real behavior-repair phase, not a guard-only phase. It removes the
/// visible debug badge from the main editor, routes the actual insertLatex path
/// through the selection-aware MathLive insertion helper, upgrades structural
/// template mappings to semantic MathLive templates, and hardens focus/tap
/// restoration for Android WebView real-device use.
class MathLivePremiumSurfaceRepairPolicy {
  const MathLivePremiumSurfaceRepairPolicy._();

  static const String phase = 'V172-Q140';
  static const bool realBehaviorRepair = true;
  static const bool visibleMathLiveBadgeRemoved = true;
  static const bool activeInsertLatexUsesSelectionAwareHelper = true;
  static const bool structuralTemplateLabelsInsertSemanticMath = true;
  static const bool taylorInsertsSeriesTemplate = true;
  static const bool systemLabelsInsertCasesTemplate = true;
  static const bool mathfieldFocusRestoreAfterKeyboardCommands = true;
  static const bool mathfieldPointerEventsHardened = true;
  static const bool mathLiveChromeHidden = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool cursorPassClaimed = false;
  static const bool photomathLevelClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
}
