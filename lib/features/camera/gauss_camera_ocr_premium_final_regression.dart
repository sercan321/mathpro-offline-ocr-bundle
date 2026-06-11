import 'gauss_camera_math_ocr_end_to_end_court_policy.dart';
import 'gauss_camera_ocr_premium_final_regression_policy.dart';

/// Decision state for the Q252 Camera/OCR Premium Final Regression.
enum GaussCameraOcrPremiumFinalRegressionDecision {
  blockedMissingQ251Court,
  blockedProtectedSurfaceRegression,
  blockedModelBundlingRegression,
  blockedDirectCameraActionRegression,
  blockedFakePassClaimRegression,
  premiumFinalRegressionStaticReady,
}

class GaussCameraOcrPremiumFinalRegressionInput {
  const GaussCameraOcrPremiumFinalRegressionInput({
    required this.q251CourtPhase,
    required this.q245ThroughQ251StaticChainVerified,
    required this.protectedSurfaceHashesUnchanged,
    required this.cameraDependencyLinePreserved,
    required this.noModelBinaryBundledInBaseApp,
    required this.noPaddleRuntimeDependency,
    required this.noProductionModelUrl,
    required this.noDirectWorkspaceImportFromCamera,
    required this.noDirectSolveGraphSolutionHistoryFromCamera,
    required this.mathLiveReviewAndUserApprovalRequired,
    required this.noRealOcrPassClaimed,
    required this.androidToolchainDeferredToQ253,
    required this.evidenceLabel,
  });

  final String q251CourtPhase;
  final bool q245ThroughQ251StaticChainVerified;
  final bool protectedSurfaceHashesUnchanged;
  final bool cameraDependencyLinePreserved;
  final bool noModelBinaryBundledInBaseApp;
  final bool noPaddleRuntimeDependency;
  final bool noProductionModelUrl;
  final bool noDirectWorkspaceImportFromCamera;
  final bool noDirectSolveGraphSolutionHistoryFromCamera;
  final bool mathLiveReviewAndUserApprovalRequired;
  final bool noRealOcrPassClaimed;
  final bool androidToolchainDeferredToQ253;
  final String evidenceLabel;

  bool get closesOverQ251Court => q251CourtPhase == GaussCameraMathOcrEndToEndCourtPolicy.phase;
  bool get hasEvidenceLabel => evidenceLabel.trim().isNotEmpty;
}

class GaussCameraOcrPremiumFinalRegressionResult {
  const GaussCameraOcrPremiumFinalRegressionResult({
    required this.phase,
    required this.closesOverPhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.selectedEngineLabel,
    required this.editableMathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.directWorkspaceImportAllowed,
    required this.directSolveAllowed,
    required this.directGraphAllowed,
    required this.directSolutionAllowed,
    required this.directHistoryAllowed,
    required this.realOcrRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
  });

  final String phase;
  final String closesOverPhase;
  final GaussCameraOcrPremiumFinalRegressionDecision decision;
  final GaussCameraOcrPremiumFinalRegressionInput input;
  final List<String> issues;
  final String selectedEngineLabel;
  final bool editableMathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final bool directWorkspaceImportAllowed;
  final bool directSolveAllowed;
  final bool directGraphAllowed;
  final bool directSolutionAllowed;
  final bool directHistoryAllowed;
  final bool realOcrRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get premiumFinalRegressionStaticReady =>
      decision == GaussCameraOcrPremiumFinalRegressionDecision.premiumFinalRegressionStaticReady &&
      !hasBlockingIssues &&
      selectedEngineLabel == GaussCameraOcrPremiumFinalRegressionPolicy.selectedEngineLabel &&
      editableMathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport &&
      directWorkspaceImportAllowed == false &&
      directSolveAllowed == false &&
      directGraphAllowed == false &&
      directSolutionAllowed == false &&
      directHistoryAllowed == false &&
      realOcrRuntimeAdded == false &&
      modelBinaryBundledInBaseApp == false;

  bool get canClaimRealOcrPass => false;
  bool get canClaimFlutterPassWithoutLogs => false;
  bool get canImportCameraOutputWithoutUserApproval => false;
  bool get canEvaluateCameraOutputBeforeReviewApproval => false;
  bool get canGraphCameraOutputBeforeReviewApproval => false;
  bool get canWriteSolutionOrHistoryBeforeReviewApproval => false;
}

/// Q252 Camera/OCR Premium Final Regression.
///
/// This is a static premium regression closure for Q245 through Q251. It keeps
/// PP-FormulaNet-S as the user-selected primary candidate, but it does not bind
/// the real runtime. It protects keyboard/MORE/long-press/MathLive production,
/// Graph, Solution, History, splash, camera shell, and Android toolchain scope.
class GaussCameraOcrPremiumFinalRegression {
  const GaussCameraOcrPremiumFinalRegression._();

  static const phase = GaussCameraOcrPremiumFinalRegressionPolicy.phase;
  static const closesOverPhase = GaussCameraOcrPremiumFinalRegressionPolicy.closesOverPhase;
  static const selectedEngineLabel = GaussCameraOcrPremiumFinalRegressionPolicy.selectedEngineLabel;
  static const regressionMode = GaussCameraOcrPremiumFinalRegressionPolicy.regressionMode;

  static const requiresQ251EndToEndCourt = true;
  static const requiresProtectedSurfaceHashesUnchanged = true;
  static const requiresNoBaseApkModelBundle = true;
  static const requiresNoPaddleRuntimeDependency = true;
  static const requiresNoProductionModelUrl = true;
  static const requiresMathLiveReviewAndUserApproval = true;
  static const allowsDirectWorkspaceImport = false;
  static const allowsDirectSolve = false;
  static const allowsDirectGraph = false;
  static const allowsDirectSolution = false;
  static const allowsDirectHistory = false;
  static const realInferenceEnabledInQ252 = false;
  static const callsProductionMathLiveBridge = false;

  static const forbiddenFinalRegressionActions = <String>[
    'runPpFormulaNetSInference',
    'bindPaddleRuntime',
    'bundlePpFormulaNetSModelInBaseApk',
    'setProductionModelUrl',
    'setWorkspaceLatexWithoutUserApproval',
    'setWorkspaceLatexWithoutReview',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeSolutionFromCamera',
    'writeHistoryFromCamera',
    'claimRealOcrPassWithoutEvidence',
  ];

  static GaussCameraOcrPremiumFinalRegressionResult evaluate(
    GaussCameraOcrPremiumFinalRegressionInput input,
  ) {
    final issues = <String>[];

    if (!input.closesOverQ251Court) {
      issues.add('Q252 final regression must close over the Q251 end-to-end court.');
    }
    if (!input.q245ThroughQ251StaticChainVerified) {
      issues.add('Q245 through Q251 static camera/OCR chain must be verified before Q252 closure.');
    }
    if (!input.protectedSurfaceHashesUnchanged) {
      issues.add('Protected premium surfaces must remain hash-unchanged for Q252 closure.');
    }
    if (!input.cameraDependencyLinePreserved) {
      issues.add('Q244R8 camera dependency/toolchain line must remain preserved for Q252.');
    }
    if (!input.noModelBinaryBundledInBaseApp) {
      issues.add('PP-FormulaNet-S model bytes must not be bundled in the base APK during Q252.');
    }
    if (!input.noPaddleRuntimeDependency) {
      issues.add('Paddle/PaddleOCR runtime dependency must not be added in Q252 final regression.');
    }
    if (!input.noProductionModelUrl) {
      issues.add('Production model URL must remain unbound until a later approved runtime phase.');
    }
    if (!input.noDirectWorkspaceImportFromCamera) {
      issues.add('Camera output must not import directly into workspace without editable MathLive review approval.');
    }
    if (!input.noDirectSolveGraphSolutionHistoryFromCamera) {
      issues.add('Camera output must not directly solve, graph, write Solution, or write History.');
    }
    if (!input.mathLiveReviewAndUserApprovalRequired) {
      issues.add('Editable MathLive review and explicit user approval are required before workspace import.');
    }
    if (!input.noRealOcrPassClaimed) {
      issues.add('Q252 must not claim real PP-FormulaNet-S OCR PASS without real runtime evidence.');
    }
    if (!input.androidToolchainDeferredToQ253) {
      issues.add('Android toolchain modernization must remain deferred to Q253 unless separately approved.');
    }
    if (!input.hasEvidenceLabel) {
      issues.add('Q252 final regression requires a static evidence label.');
    }

    final decision = _decisionFor(input, issues);

    return GaussCameraOcrPremiumFinalRegressionResult(
      phase: phase,
      closesOverPhase: closesOverPhase,
      decision: decision,
      input: input,
      issues: List<String>.unmodifiable(issues),
      selectedEngineLabel: selectedEngineLabel,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directWorkspaceImportAllowed: false,
      directSolveAllowed: false,
      directGraphAllowed: false,
      directSolutionAllowed: false,
      directHistoryAllowed: false,
      realOcrRuntimeAdded: false,
      modelBinaryBundledInBaseApp: false,
    );
  }

  static GaussCameraOcrPremiumFinalRegressionDecision _decisionFor(
    GaussCameraOcrPremiumFinalRegressionInput input,
    List<String> issues,
  ) {
    if (!input.closesOverQ251Court || !input.q245ThroughQ251StaticChainVerified) {
      return GaussCameraOcrPremiumFinalRegressionDecision.blockedMissingQ251Court;
    }
    if (!input.protectedSurfaceHashesUnchanged || !input.cameraDependencyLinePreserved) {
      return GaussCameraOcrPremiumFinalRegressionDecision.blockedProtectedSurfaceRegression;
    }
    if (!input.noModelBinaryBundledInBaseApp || !input.noPaddleRuntimeDependency || !input.noProductionModelUrl) {
      return GaussCameraOcrPremiumFinalRegressionDecision.blockedModelBundlingRegression;
    }
    if (!input.noDirectWorkspaceImportFromCamera || !input.noDirectSolveGraphSolutionHistoryFromCamera || !input.mathLiveReviewAndUserApprovalRequired) {
      return GaussCameraOcrPremiumFinalRegressionDecision.blockedDirectCameraActionRegression;
    }
    if (!input.noRealOcrPassClaimed || !input.androidToolchainDeferredToQ253 || !input.hasEvidenceLabel) {
      return GaussCameraOcrPremiumFinalRegressionDecision.blockedFakePassClaimRegression;
    }
    return issues.isEmpty
        ? GaussCameraOcrPremiumFinalRegressionDecision.premiumFinalRegressionStaticReady
        : GaussCameraOcrPremiumFinalRegressionDecision.blockedFakePassClaimRegression;
  }
}
