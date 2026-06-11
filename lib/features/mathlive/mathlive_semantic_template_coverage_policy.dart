/// V172-Q142 — MathLive Semantic Template Coverage policy.
///
/// Q142 prevents MathPro structure labels from falling through to plain text in
/// the active MathLive main editor. It extends the main-editor template map for
/// algebra, trigonometry aliases, complex-number helpers, matrix/vector labels,
/// and named linear-algebra/vector operations while preserving the protected
/// keyboard layout and long-press source of truth.
class MathLiveSemanticTemplateCoveragePolicy {
  const MathLiveSemanticTemplateCoveragePolicy._();

  static const String phase = 'V172-Q142';
  static const bool realBehaviorRepair = true;
  static const bool broadStructureLabelCoverageAdded = true;
  static const bool namedLabelsDoNotInsertPlainText = true;
  static const bool taylorAndSeriesRemainSemantic = true;
  static const bool matrixVectorLabelsUseMathTemplates = true;
  static const bool complexLabelsUseMathTemplates = true;
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
