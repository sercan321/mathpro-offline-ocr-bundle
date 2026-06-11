import 'gauss_advanced_math_ocr_offline_mode_guard_policy.dart';
import 'gauss_deferred_math_ocr_model_manager.dart';
import 'gauss_winner_engine_adapter.dart';

/// V172-Q242 offline gate status for the future advanced math OCR runtime.
///
/// This status is intentionally not an OCR execution status. Q242 never runs a
/// model; it only decides whether a future offline OCR path would be safely
/// blocked or eligible for editable MathLive review after a real engine phase.
enum GaussAdvancedMathOcrOfflineModeStatus {
  contractReadyFutureOnly,
  blockedModelNotReady,
  blockedModelVerification,
  blockedRuntimeUnavailable,
  blockedAdapterUnsafe,
  blockedCropContextMissing,
  blockedDirectActionAttempt,
  disabledByUser,
}

enum GaussAdvancedMathOcrOfflineModeIssueSeverity {
  info,
  warning,
  blocking,
}

class GaussAdvancedMathOcrOfflineModeIssue {
  const GaussAdvancedMathOcrOfflineModeIssue({
    required this.code,
    required this.message,
    required this.severity,
  });

  final String code;
  final String message;
  final GaussAdvancedMathOcrOfflineModeIssueSeverity severity;

  bool get isBlocking => severity == GaussAdvancedMathOcrOfflineModeIssueSeverity.blocking;
}

/// Input envelope consumed by the Q242 guard.
///
/// The booleans model the future offline engine environment, but Q242 still
/// keeps OCR execution disabled even when every readiness gate is satisfied.
class GaussAdvancedMathOcrOfflineModeRequest {
  const GaussAdvancedMathOcrOfflineModeRequest({
    required this.modelSnapshot,
    required this.adapterEnvelope,
    required this.localModelSha256Verified,
    required this.offlineRuntimeAvailable,
    required this.croppedImageReady,
    this.attemptedDirectSolve = false,
    this.attemptedWorkspaceImport = false,
    this.attemptedGraphHistorySolution = false,
  });

  final GaussMathOcrModelSnapshot modelSnapshot;
  final GaussWinnerEngineAdapterEnvelope adapterEnvelope;
  final bool localModelSha256Verified;
  final bool offlineRuntimeAvailable;
  final bool croppedImageReady;
  final bool attemptedDirectSolve;
  final bool attemptedWorkspaceImport;
  final bool attemptedGraphHistorySolution;

  bool get attemptedDirectAction =>
      attemptedDirectSolve || attemptedWorkspaceImport || attemptedGraphHistorySolution;
}

class GaussAdvancedMathOcrOfflineModeDecision {
  const GaussAdvancedMathOcrOfflineModeDecision({
    required this.phase,
    required this.status,
    required this.request,
    required this.issues,
    required this.offlineOcrExecutionAllowedInThisPhase,
    required this.mathLiveReviewRequired,
    required this.directSolveAllowed,
    required this.directWorkspaceImportAllowed,
    required this.graphAllowedBeforeReview,
    required this.historyWriteAllowedBeforeReview,
    required this.solutionAllowedBeforeReview,
  });

  final String phase;
  final GaussAdvancedMathOcrOfflineModeStatus status;
  final GaussAdvancedMathOcrOfflineModeRequest request;
  final List<GaussAdvancedMathOcrOfflineModeIssue> issues;
  final bool offlineOcrExecutionAllowedInThisPhase;
  final bool mathLiveReviewRequired;
  final bool directSolveAllowed;
  final bool directWorkspaceImportAllowed;
  final bool graphAllowedBeforeReview;
  final bool historyWriteAllowedBeforeReview;
  final bool solutionAllowedBeforeReview;

  bool get hasBlockingIssues => issues.any((issue) => issue.isBlocking);

  /// Future-facing readiness: every safety gate is satisfied, but Q242 still
  /// does not execute a model. A later engine phase must flip runtime binding.
  bool get futureOfflineReviewPathPrepared =>
      status == GaussAdvancedMathOcrOfflineModeStatus.contractReadyFutureOnly &&
      !hasBlockingIssues &&
      offlineOcrExecutionAllowedInThisPhase == false &&
      mathLiveReviewRequired &&
      directSolveAllowed == false &&
      directWorkspaceImportAllowed == false &&
      graphAllowedBeforeReview == false &&
      historyWriteAllowedBeforeReview == false &&
      solutionAllowedBeforeReview == false;

  bool get mayExecuteOcrNow => false;
}

/// V172-Q242 guard for the future advanced offline math OCR mode.
class GaussAdvancedMathOcrOfflineModeGuard {
  const GaussAdvancedMathOcrOfflineModeGuard._();

  static const String phase = GaussAdvancedMathOcrOfflineModeGuardPolicy.fullPhase;
  static const bool realOcrEngineAdded = false;
  static const bool offlineOcrExecutionAllowedInThisPhase = false;
  static const bool mathLiveReviewRequired = true;
  static const bool directSolveAllowed = false;
  static const bool directWorkspaceImportAllowed = false;

  static const List<String> offlineReadinessGates = <String>[
    'q239dModelSnapshotReadyGate',
    'localModelSha256VerificationGate',
    'appPrivateInstallPathGate',
    'offlineRuntimeAvailabilityGate',
    'q241WinnerAdapterReviewOnlyGate',
    'croppedImageContextGate',
    'directActionBlockGate',
    'mathLiveReviewBeforeAnyActionGate',
  ];

  static const List<String> forbiddenOfflineModeActions = <String>[
    'executeOcrInQ242',
    'downloadModelInQ242',
    'loadOnnxRuntimeInQ242',
    'loadPaddleRuntimeInQ242',
    'callMathLiveProductionBridgeFromCamera',
    'setWorkspaceLatexWithoutReview',
    'evaluateFromCamera',
    'graphFromCamera',
    'writeHistoryFromCamera',
    'solveFromCamera',
  ];

  static GaussAdvancedMathOcrOfflineModeDecision evaluate(
    GaussAdvancedMathOcrOfflineModeRequest request,
  ) {
    final issues = <GaussAdvancedMathOcrOfflineModeIssue>[];
    void block(String code, String message) {
      issues.add(
        GaussAdvancedMathOcrOfflineModeIssue(
          code: code,
          message: message,
          severity: GaussAdvancedMathOcrOfflineModeIssueSeverity.blocking,
        ),
      );
    }

    if (request.attemptedDirectAction) {
      block('directActionAttempt', 'Camera OCR cannot directly solve, import workspace, graph, write history, or open solution. Editable MathLive review is mandatory.');
    }
    if (request.modelSnapshot.status == GaussMathOcrModelInstallStatus.disabledByUser) {
      block('modelDisabledByUser', 'Advanced math OCR model is disabled by the user.');
    }
    if (!request.modelSnapshot.canRunOffline) {
      block('modelNotReady', 'Advanced math OCR model must be installed, verified, and offline-ready before future OCR review.');
    }
    if ((request.modelSnapshot.installPath ?? '').trim().isEmpty) {
      block('installPath', 'Offline model must live in app-private storage before future OCR review.');
    }
    if (!request.localModelSha256Verified) {
      block('modelSha256', 'Local model artifact must pass SHA256 verification before future OCR review.');
    }
    if (!request.offlineRuntimeAvailable) {
      block('offlineRuntime', 'Offline runtime must be available before future OCR review.');
    }
    if (!request.adapterEnvelope.mayOpenMathLiveReviewOnly) {
      block('q241AdapterEnvelope', 'Q241 winner adapter envelope must be review-only and safe.');
    }
    if (!request.croppedImageReady) {
      block('croppedImage', 'A cropped formula image context is required before future OCR review.');
    }

    final status = _statusFor(request, issues);
    return GaussAdvancedMathOcrOfflineModeDecision(
      phase: phase,
      status: status,
      request: request,
      issues: List<GaussAdvancedMathOcrOfflineModeIssue>.unmodifiable(issues),
      offlineOcrExecutionAllowedInThisPhase: false,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
      directWorkspaceImportAllowed: false,
      graphAllowedBeforeReview: false,
      historyWriteAllowedBeforeReview: false,
      solutionAllowedBeforeReview: false,
    );
  }

  static GaussAdvancedMathOcrOfflineModeStatus _statusFor(
    GaussAdvancedMathOcrOfflineModeRequest request,
    List<GaussAdvancedMathOcrOfflineModeIssue> issues,
  ) {
    if (request.attemptedDirectAction) {
      return GaussAdvancedMathOcrOfflineModeStatus.blockedDirectActionAttempt;
    }
    if (request.modelSnapshot.status == GaussMathOcrModelInstallStatus.disabledByUser) {
      return GaussAdvancedMathOcrOfflineModeStatus.disabledByUser;
    }
    if (!request.modelSnapshot.canRunOffline || (request.modelSnapshot.installPath ?? '').trim().isEmpty) {
      return GaussAdvancedMathOcrOfflineModeStatus.blockedModelNotReady;
    }
    if (!request.localModelSha256Verified) {
      return GaussAdvancedMathOcrOfflineModeStatus.blockedModelVerification;
    }
    if (!request.offlineRuntimeAvailable) {
      return GaussAdvancedMathOcrOfflineModeStatus.blockedRuntimeUnavailable;
    }
    if (!request.adapterEnvelope.mayOpenMathLiveReviewOnly) {
      return GaussAdvancedMathOcrOfflineModeStatus.blockedAdapterUnsafe;
    }
    if (!request.croppedImageReady) {
      return GaussAdvancedMathOcrOfflineModeStatus.blockedCropContextMissing;
    }
    return issues.isEmpty
        ? GaussAdvancedMathOcrOfflineModeStatus.contractReadyFutureOnly
        : GaussAdvancedMathOcrOfflineModeStatus.blockedAdapterUnsafe;
  }

  static bool get blocksUnsafeOfflineActions =>
      forbiddenOfflineModeActions.contains('executeOcrInQ242') &&
      forbiddenOfflineModeActions.contains('setWorkspaceLatexWithoutReview') &&
      forbiddenOfflineModeActions.contains('evaluateFromCamera') &&
      offlineOcrExecutionAllowedInThisPhase == false &&
      directSolveAllowed == false &&
      directWorkspaceImportAllowed == false;

  static bool get exposesOfflineReviewOnlyContract =>
      offlineReadinessGates.contains('mathLiveReviewBeforeAnyActionGate') &&
      mathLiveReviewRequired &&
      directSolveAllowed == false &&
      directWorkspaceImportAllowed == false;
}
