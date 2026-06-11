import 'mathlive_final_static_production_freeze_policy.dart';

/// V172-Q204 — Real Device Evidence Intake Gate.
///
/// Q204 does not change the frozen Q203 production runtime path. It adds the
/// evidence contract that must be filled from the user's machine/device before
/// any Flutter analyze/test/run PASS, Android real-device PASS, caret PASS,
/// premium visual PASS, or final release PASS may be claimed.
abstract final class MathLiveRealDeviceEvidenceIntakePolicy {
  static const String phase = 'V172-Q204';
  static const String fullPhase = 'V172-Q204-REAL-DEVICE-EVIDENCE-INTAKE-GATE';
  static const String baseline = MathLiveFinalStaticProductionFreezePolicy.fullPhase;

  static const String evidenceTemplatePath =
      'tool/evidence/V172_Q204_REAL_DEVICE_EVIDENCE_TEMPLATE.json';
  static const String optionalEvidencePath =
      'tool/evidence/V172_Q204_REAL_DEVICE_EVIDENCE.json';
  static const String evidenceReportPath =
      'tool/reports/mathlive_real_device_evidence_intake_v172_q204_report.json';

  static const bool q203FinalStaticFreezeRequired = true;
  static const bool q199CommandContractRequired = true;
  static const bool q200NoFreezeContractRequired = true;
  static const bool q201CaretFocusSlotContractRequired = true;
  static const bool q202GraphHistorySolutionStateRequired = true;
  static const bool protectedHashVerificationRequired = true;
  static const bool packageHygieneVerificationRequired = true;

  static const bool userSideFlutterAnalyzeEvidenceRequired = true;
  static const bool userSideFlutterTestEvidenceRequired = true;
  static const bool userSideFlutterRunEvidenceRequired = true;
  static const bool androidRealDeviceVideoOrScreenshotsRequired = true;
  static const bool caretPlacementScenarioEvidenceRequired = true;
  static const bool templateVisualScenarioEvidenceRequired = true;
  static const bool noFreezeKeyboardTapEvidenceRequired = true;
  static const bool graphHistorySolutionEvidenceRequired = true;

  static const int requiredCaretScenarioCount = 12;
  static const int requiredTemplateVisualScenarioCount = 12;
  static const int requiredNoFreezeTapScenarioCount = 10;
  static const int requiredGraphHistorySolutionScenarioCount = 6;
  static const int maximumBlockingFailuresForPass = 0;

  static const bool assistantMayInferPassWithoutEvidence = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
  static const bool premiumVisualDevicePassClaimed = false;
  static const bool noFreezeDevicePassClaimed = false;
  static const bool graphHistorySolutionDevicePassClaimed = false;
  static const bool finalReleasePassClaimed = false;

  static bool enoughScenarioEvidence({
    required int caretScenarios,
    required int templateVisualScenarios,
    required int noFreezeTapScenarios,
    required int graphHistorySolutionScenarios,
    required int blockingFailures,
  }) {
    return caretScenarios >= requiredCaretScenarioCount &&
        templateVisualScenarios >= requiredTemplateVisualScenarioCount &&
        noFreezeTapScenarios >= requiredNoFreezeTapScenarioCount &&
        graphHistorySolutionScenarios >= requiredGraphHistorySolutionScenarioCount &&
        blockingFailures <= maximumBlockingFailuresForPass;
  }
}
