/// V172-Q232 — Result Status Compact Copy / Graph-open Result Panel Fit Repair.
///
/// Guard-only policy record for the compact SONUÇ panel status-copy repair.
/// This phase changes only result/status copy resolution and ResultView fit
/// behavior; it does not change keyboard, long-press, MORE, MathLive, Graph,
/// Solution, History, AppShell, Android startup, solver, or evaluator runtime
/// semantics.
class ResultStatusCompactCopyPolicy {
  const ResultStatusCompactCopyPolicy._();

  static const String phase = 'V172-Q232';
  static const String fullPhase = 'V172-Q232-RESULT-STATUS-COMPACT-COPY-GRAPH-OPEN-FIT-REPAIR';
  static const String baseline = 'V172-Q231R2-LONG-PRESS-PLUS99-ANCHOR-FINAL-HYGIENE';

  static const bool centralStatusCopyResolverAdded = true;
  static const bool fullAndCompactCopyVariantsAvailable = true;
  static const bool graphOpenForcesCompactResultStatus = true;
  static const bool compressedResultPanelForcesCompactResultStatus = true;
  static const bool resultStatusSingleLine = true;
  static const bool resultStatusSoftWrapDisabled = true;
  static const bool resultStatusOverflowUsesFadeNotEllipsisDots = true;
  static const bool resultValueHasPriorityOverStatusMessage = true;
  static const bool longOpenSlotCopyRemovedFromRuntimePanel = true;
  static const bool rawEvaluatorReasonsPreservedForStateAndLogs = true;

  static const String openSlotFullCopy = 'Açık slotları doldurun';
  static const String openSlotCompactCopy = 'Slot bekleniyor';
  static const String emptyExpressionFullCopy = 'İfade girin';
  static const String emptyExpressionCompactCopy = 'İfade bekleniyor';
  static const String noResultFullCopy = 'Sonuç henüz yok';
  static const String noResultCompactCopy = 'Sonuç yok';
  static const String unsupportedFullCopy = 'İfade değerlendirilemiyor';
  static const String unsupportedCompactCopy = 'Değerlendirilemedi';
  static const String graphIncompatibleFullCopy = 'Grafik için uygun değil';
  static const String graphIncompatibleCompactCopy = 'Grafik uygun değil';
  static const String invalidExpressionFullCopy = 'Geçersiz ifade';
  static const String invalidExpressionCompactCopy = 'Geçersiz';
  static const String calculationErrorFullCopy = 'Hesaplama hatası';
  static const String calculationErrorCompactCopy = 'Hata';
  static const String noSolutionStepFullCopy = 'Çözüm adımı yok';
  static const String noSolutionStepCompactCopy = 'Adım yok';

  static const bool keyboardMutationAllowed = false;
  static const bool moreMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool mathLiveProductionMutationAllowed = false;
  static const bool graphEngineMutationAllowed = false;
  static const bool graphBehaviorMutationAllowed = false;
  static const bool solutionPanelMutationAllowed = false;
  static const bool historyMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool splashStartupMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool evaluatorSemanticMutationAllowed = false;

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimedByAssistant = false;
  static const bool graphOpenResultFitPassClaimedByAssistant = false;
  static const bool premiumVisualPassClaimedByAssistant = false;
}
