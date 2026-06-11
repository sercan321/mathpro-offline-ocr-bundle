import 'gauss_camera_math_ocr_end_to_end_court_policy.dart';
import 'gauss_ocr_mathlive_review_import.dart';
import 'gauss_ocr_runtime_adapter.dart';

/// Decision state for the Q251 camera math OCR end-to-end court.
///
/// The court is intentionally review-first and evidence-first. It may prove
/// that the chain is structurally safe, but it does not run PP-FormulaNet-S and
/// does not claim real OCR recognition.
enum GaussCameraMathOcrEndToEndCourtDecision {
  blockedMissingCameraCapture,
  blockedMissingCropScanFrame,
  blockedModelNotReady,
  blockedAdapterEnvelopeNotReady,
  blockedMathLiveReviewDraftNotReady,
  editableReviewCourtReady,
  blockedUserApprovalRequired,
  workspaceImportCourtReadyAfterApproval,
}

class GaussCameraMathOcrEndToEndCourtInput {
  const GaussCameraMathOcrEndToEndCourtInput({
    required this.capturePath,
    required this.cropFrameId,
    required this.adapterEnvelope,
    required this.reviewDraft,
    required this.realDeviceCaseId,
    required this.sourcePhase,
  });

  final String capturePath;
  final String cropFrameId;
  final GaussOcrRuntimeAdapterEnvelope adapterEnvelope;
  final GaussOcrMathLiveReviewImportDraft reviewDraft;
  final String realDeviceCaseId;
  final String sourcePhase;

  bool get hasCapturePath => capturePath.trim().isNotEmpty;
  bool get hasCropFrame => cropFrameId.trim().isNotEmpty;
  bool get hasRealDeviceCase => realDeviceCaseId.trim().isNotEmpty;
  bool get fromQ250ReviewImportPhase => sourcePhase == GaussOcrMathLiveReviewImport.phase;
}

class GaussCameraMathOcrEndToEndCourtResult {
  const GaussCameraMathOcrEndToEndCourtResult({
    required this.phase,
    required this.closesOverPhase,
    required this.decision,
    required this.input,
    required this.issues,
    required this.mathLiveReviewRequired,
    required this.userApprovalRequiredBeforeWorkspaceImport,
    required this.directWorkspaceImportAllowed,
    required this.directSolveAllowed,
    required this.directGraphAllowed,
    required this.directSolutionAllowed,
    required this.directHistoryAllowed,
  });

  final String phase;
  final String closesOverPhase;
  final GaussCameraMathOcrEndToEndCourtDecision decision;
  final GaussCameraMathOcrEndToEndCourtInput input;
  final List<String> issues;
  final bool mathLiveReviewRequired;
  final bool userApprovalRequiredBeforeWorkspaceImport;
  final bool directWorkspaceImportAllowed;
  final bool directSolveAllowed;
  final bool directGraphAllowed;
  final bool directSolutionAllowed;
  final bool directHistoryAllowed;

  bool get hasBlockingIssues => issues.isNotEmpty;

  bool get canOpenEditableMathLiveReviewCourt =>
      decision == GaussCameraMathOcrEndToEndCourtDecision.editableReviewCourtReady &&
      !hasBlockingIssues &&
      input.reviewDraft.canOpenEditableMathLiveReview &&
      mathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport &&
      directWorkspaceImportAllowed == false &&
      directSolveAllowed == false;

  bool get canPrepareWorkspaceImportCourtAfterUserApproval =>
      decision == GaussCameraMathOcrEndToEndCourtDecision.workspaceImportCourtReadyAfterApproval &&
      !hasBlockingIssues &&
      input.reviewDraft.canImportToWorkspaceAfterUserApproval &&
      mathLiveReviewRequired &&
      userApprovalRequiredBeforeWorkspaceImport &&
      directWorkspaceImportAllowed == false &&
      directSolveAllowed == false &&
      directGraphAllowed == false &&
      directSolutionAllowed == false &&
      directHistoryAllowed == false;

  bool get canEvaluateBeforeUserApproval => false;
  bool get canGraphBeforeUserApproval => false;
  bool get canWriteSolutionBeforeUserApproval => false;
  bool get canWriteHistoryBeforeUserApproval => false;
}

/// Q251 Camera Math OCR End-to-End Court.
///
/// This court validates the intended chain:
/// camera capture → crop/scan-frame → Q248 model readiness → Q249 review-only
/// adapter envelope → Q250 editable MathLive review → explicit user approval →
/// prepared workspace-import state. It never performs real OCR inference and it
/// never mutates workspace, solver, graph, solution, or history.
class GaussCameraMathOcrEndToEndCourt {
  const GaussCameraMathOcrEndToEndCourt._();

  static const phase = GaussCameraMathOcrEndToEndCourtPolicy.phase;
  static const closesOverPhase = GaussCameraMathOcrEndToEndCourtPolicy.closesOverPhase;
  static const selectedEngineLabel = GaussCameraMathOcrEndToEndCourtPolicy.selectedEngineLabel;
  static const courtMode = GaussCameraMathOcrEndToEndCourtPolicy.courtMode;

  static const requiresCameraCapture = true;
  static const requiresCropScanFrame = true;
  static const requiresQ248DeferredModelReadiness = true;
  static const requiresQ249AdapterEnvelope = true;
  static const requiresQ250MathLiveReviewImport = true;
  static const requiresEditableMathLiveReview = true;
  static const requiresUserApprovalBeforeWorkspaceImport = true;
  static const allowsDirectWorkspaceImport = false;
  static const allowsDirectSolve = false;
  static const allowsDirectGraph = false;
  static const allowsDirectSolution = false;
  static const allowsDirectHistory = false;
  static const realInferenceEnabledInQ251 = false;
  static const callsProductionMathLiveBridge = false;

  static const forbiddenEndToEndActions = <String>[
    'runPpFormulaNetSInference',
    'loadPaddleRuntime',
    'downloadModelNow',
    'callMathLiveProductionBridge',
    'setWorkspaceLatexWithoutUserApproval',
    'evaluateFromCameraBeforeApproval',
    'graphFromCameraBeforeApproval',
    'writeSolutionFromCameraBeforeApproval',
    'writeHistoryFromCameraBeforeApproval',
  ];

  static GaussCameraMathOcrEndToEndCourtResult evaluate({
    required GaussCameraMathOcrEndToEndCourtInput input,
  }) {
    final issues = <String>[];

    if (!input.hasCapturePath) {
      issues.add('Camera capture path is required before Q251 end-to-end court.');
      return _result(
        decision: GaussCameraMathOcrEndToEndCourtDecision.blockedMissingCameraCapture,
        input: input,
        issues: issues,
      );
    }

    if (!input.hasCropFrame) {
      issues.add('Crop/scan-frame id is required before Q251 end-to-end court.');
      return _result(
        decision: GaussCameraMathOcrEndToEndCourtDecision.blockedMissingCropScanFrame,
        input: input,
        issues: issues,
      );
    }

    if (input.adapterEnvelope.modelReadiness.isBlocked) {
      issues.add('Q248 deferred model readiness must be satisfied before adapter review court.');
      issues.addAll(input.adapterEnvelope.modelReadiness.issues);
      return _result(
        decision: GaussCameraMathOcrEndToEndCourtDecision.blockedModelNotReady,
        input: input,
        issues: issues,
      );
    }

    if (!input.adapterEnvelope.mayOpenMathLiveReviewOnly) {
      issues.add('Q249 adapter envelope must be review-only ready before Q251 court.');
      issues.addAll(input.adapterEnvelope.issues);
      return _result(
        decision: GaussCameraMathOcrEndToEndCourtDecision.blockedAdapterEnvelopeNotReady,
        input: input,
        issues: issues,
      );
    }

    if (!input.fromQ250ReviewImportPhase) {
      issues.add('Q251 court input must be sourced from the Q250 MathLive review-import phase.');
    }

    if (!input.hasRealDeviceCase) {
      issues.add('Q251 court requires a real-device case id/evidence label before closure.');
    }

    final reviewDraft = input.reviewDraft;
    if (reviewDraft.phase != GaussOcrMathLiveReviewImport.phase ||
        reviewDraft.sourceAdapterPhase != GaussOcrRuntimeAdapter.phase) {
      issues.add('Q250 MathLive review draft must close over the Q249 adapter phase.');
    }

    if (reviewDraft.canOpenEditableMathLiveReview) {
      return _result(
        decision: issues.isEmpty
            ? GaussCameraMathOcrEndToEndCourtDecision.editableReviewCourtReady
            : GaussCameraMathOcrEndToEndCourtDecision.blockedMathLiveReviewDraftNotReady,
        input: input,
        issues: issues,
      );
    }

    if (reviewDraft.canImportToWorkspaceAfterUserApproval) {
      return _result(
        decision: issues.isEmpty
            ? GaussCameraMathOcrEndToEndCourtDecision.workspaceImportCourtReadyAfterApproval
            : GaussCameraMathOcrEndToEndCourtDecision.blockedMathLiveReviewDraftNotReady,
        input: input,
        issues: issues,
      );
    }

    if (!reviewDraft.userApproved) {
      issues.add('Editable MathLive review must be explicitly approved before workspace import court.');
      return _result(
        decision: GaussCameraMathOcrEndToEndCourtDecision.blockedUserApprovalRequired,
        input: input,
        issues: issues,
      );
    }

    issues.add('Q250 MathLive review draft is not ready for review or approved import court.');
    return _result(
      decision: GaussCameraMathOcrEndToEndCourtDecision.blockedMathLiveReviewDraftNotReady,
      input: input,
      issues: issues,
    );
  }

  static GaussCameraMathOcrEndToEndCourtResult _result({
    required GaussCameraMathOcrEndToEndCourtDecision decision,
    required GaussCameraMathOcrEndToEndCourtInput input,
    required List<String> issues,
  }) {
    return GaussCameraMathOcrEndToEndCourtResult(
      phase: phase,
      closesOverPhase: closesOverPhase,
      decision: decision,
      input: input,
      issues: List<String>.unmodifiable(issues),
      mathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directWorkspaceImportAllowed: false,
      directSolveAllowed: false,
      directGraphAllowed: false,
      directSolutionAllowed: false,
      directHistoryAllowed: false,
    );
  }
}
