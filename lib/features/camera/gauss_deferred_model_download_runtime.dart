import 'gauss_deferred_model_download_runtime_policy.dart';
import 'gauss_pp_formulanet_s_user_selection.dart';

/// Optional model pack states for the future PP-FormulaNet-S runtime.
enum GaussDeferredModelDownloadStatus {
  notInstalled,
  queued,
  downloading,
  verifying,
  ready,
  failed,
  updateAvailable,
  disabledByUser,
}

extension GaussDeferredModelDownloadStatusUi on GaussDeferredModelDownloadStatus {
  String get storageValue => name;

  String get premiumLabel {
    switch (this) {
      case GaussDeferredModelDownloadStatus.notInstalled:
        return 'Model hazır değil';
      case GaussDeferredModelDownloadStatus.queued:
        return 'Wi‑Fi kuyruğunda';
      case GaussDeferredModelDownloadStatus.downloading:
        return 'Model indiriliyor';
      case GaussDeferredModelDownloadStatus.verifying:
        return 'Model doğrulanıyor';
      case GaussDeferredModelDownloadStatus.ready:
        return 'Offline hazır';
      case GaussDeferredModelDownloadStatus.failed:
        return 'Model kullanılamaz';
      case GaussDeferredModelDownloadStatus.updateAvailable:
        return 'Güncelleme var';
      case GaussDeferredModelDownloadStatus.disabledByUser:
        return 'Kapalı';
    }
  }
}

/// Static PP-FormulaNet-S model pack manifest used by Q248 gates.
///
/// No production URL or model bytes are bound in this phase. Those values stay
/// pending until a verified artifact exists and the Q249 runtime adapter is
/// approved.
class GaussPpFormulaNetSDeferredModelManifest {
  const GaussPpFormulaNetSDeferredModelManifest._();

  static const phase = GaussDeferredModelDownloadRuntimePolicy.phase;
  static const selectedEngineLabel = GaussDeferredModelDownloadRuntimePolicy.selectedEngineLabel;
  static const fallbackEngineLabel = GaussDeferredModelDownloadRuntimePolicy.fallbackEngineLabel;
  static const modelPackId = GaussDeferredModelDownloadRuntimePolicy.modelPackId;
  static const modelInstallMode = GaussDeferredModelDownloadRuntimePolicy.modelInstallMode;
  static const modelStoragePolicy = GaussDeferredModelDownloadRuntimePolicy.modelStoragePolicy;
  static const defaultNetworkPolicy = GaussDeferredModelDownloadRuntimePolicy.defaultNetworkPolicy;
  static const expectedModelVersion = GaussDeferredModelDownloadRuntimePolicy.expectedModelVersion;
  static const expectedModelSha256 = GaussDeferredModelDownloadRuntimePolicy.expectedModelSha256;
  static const maxModelSizeBytes = GaussDeferredModelDownloadRuntimePolicy.maxModelSizeBytes;

  static const productionModelUrlBound = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const mathLiveEditableReviewRequired = true;
  static const directSolveAllowed = false;

  static const installStates = <GaussDeferredModelDownloadStatus>[
    GaussDeferredModelDownloadStatus.notInstalled,
    GaussDeferredModelDownloadStatus.queued,
    GaussDeferredModelDownloadStatus.downloading,
    GaussDeferredModelDownloadStatus.verifying,
    GaussDeferredModelDownloadStatus.ready,
    GaussDeferredModelDownloadStatus.failed,
    GaussDeferredModelDownloadStatus.updateAvailable,
    GaussDeferredModelDownloadStatus.disabledByUser,
  ];
}

class GaussDeferredModelArtifactEvidence {
  const GaussDeferredModelArtifactEvidence({
    required this.status,
    required this.expectedSha256,
    required this.actualSha256,
    required this.modelSizeBytes,
    required this.storedInPrivateAppStorage,
    required this.offlineAfterInstall,
    required this.mathLiveReviewRequired,
    required this.directSolveAllowed,
    required this.productionUrlBound,
    required this.modelBinaryBundledInBaseApp,
  });

  final GaussDeferredModelDownloadStatus status;
  final String expectedSha256;
  final String actualSha256;
  final int modelSizeBytes;
  final bool storedInPrivateAppStorage;
  final bool offlineAfterInstall;
  final bool mathLiveReviewRequired;
  final bool directSolveAllowed;
  final bool productionUrlBound;
  final bool modelBinaryBundledInBaseApp;
}

enum GaussDeferredModelReadinessDecision {
  blockedNoVerifiedArtifact,
  blockedSha256Missing,
  blockedSha256Mismatch,
  blockedModelTooLarge,
  blockedNotPrivateStorage,
  blockedOfflineNotAvailable,
  blockedMissingMathLiveReview,
  blockedDirectSolveAttempt,
  blockedBaseApkBundlingAttempt,
  readyForFutureQ249AdapterOnly,
}

class GaussDeferredModelReadinessResult {
  const GaussDeferredModelReadinessResult({
    required this.phase,
    required this.decision,
    required this.issues,
    required this.canRunInferenceNow,
    required this.canProceedToQ249Adapter,
    required this.mathLiveReviewRequired,
    required this.directSolveAllowed,
  });

  final String phase;
  final GaussDeferredModelReadinessDecision decision;
  final List<String> issues;
  final bool canRunInferenceNow;
  final bool canProceedToQ249Adapter;
  final bool mathLiveReviewRequired;
  final bool directSolveAllowed;

  bool get isBlocked => decision != GaussDeferredModelReadinessDecision.readyForFutureQ249AdapterOnly;
}

/// Q248 deferred model runtime gate.
///
/// This class does not download, unzip, load, or execute PP-FormulaNet-S. It is
/// the readiness contract that future downloader/adapter code must satisfy.
class GaussDeferredModelDownloadRuntime {
  const GaussDeferredModelDownloadRuntime._();

  static const phase = GaussDeferredModelDownloadRuntimePolicy.phase;
  static const closesOverPhase = GaussDeferredModelDownloadRuntimePolicy.closesOverPhase;
  static const selectedEngineLabel = GaussPpFormulaNetSUserSelection.selectedEngineLabel;
  static const fallbackEngineLabel = GaussPpFormulaNetSUserSelection.fallbackEngineLabel;

  static const statusOrder = GaussPpFormulaNetSDeferredModelManifest.installStates;
  static const requiredReadinessGates = <String>[
    'verifiedPpFormulaNetSArtifact',
    'expectedSha256Present',
    'actualSha256MatchesExpected',
    'modelSizeWithinDeferredBudget',
    'privateAppStorage',
    'offlineAfterInstall',
    'mathLiveEditableReviewRequired',
    'directSolveBlocked',
    'notBundledInBaseApk',
  ];

  static bool get q247R1UserSelectionPreserved => true;
  static bool get bundlesModelInBaseApk => false;
  static bool get productionUrlBoundInQ248 => false;
  static bool get implementsProductionDownloaderInQ248 => false;
  static bool get implementsInferenceInQ248 => false;
  static bool get requiresEditableMathLiveReview => true;
  static bool get allowsDirectSolve => false;
  static bool get canRunInferenceNow => false;

  static GaussDeferredModelReadinessResult evaluateReadiness(
    GaussDeferredModelArtifactEvidence evidence,
  ) {
    final issues = <String>[];

    if (evidence.status != GaussDeferredModelDownloadStatus.ready) {
      issues.add('PP-FormulaNet-S model artifact is not in ready state.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedNoVerifiedArtifact, issues, evidence);
    }
    if (!_looksLikeSha256(evidence.expectedSha256) || !_looksLikeSha256(evidence.actualSha256)) {
      issues.add('Expected and actual SHA256 values must both be concrete 64-character hex digests.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedSha256Missing, issues, evidence);
    }
    if (evidence.expectedSha256.toLowerCase() != evidence.actualSha256.toLowerCase()) {
      issues.add('Model artifact SHA256 mismatch; the artifact must be discarded.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedSha256Mismatch, issues, evidence);
    }
    if (evidence.modelSizeBytes <= 0 || evidence.modelSizeBytes > GaussPpFormulaNetSDeferredModelManifest.maxModelSizeBytes) {
      issues.add('Model size is outside the deferred download budget.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedModelTooLarge, issues, evidence);
    }
    if (!evidence.storedInPrivateAppStorage) {
      issues.add('Verified model must be stored in app-private storage.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedNotPrivateStorage, issues, evidence);
    }
    if (!evidence.offlineAfterInstall) {
      issues.add('Offline-after-install availability must be proven before adapter work.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedOfflineNotAvailable, issues, evidence);
    }
    if (!evidence.mathLiveReviewRequired) {
      issues.add('Editable MathLive review is mandatory before workspace import.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedMissingMathLiveReview, issues, evidence);
    }
    if (evidence.directSolveAllowed) {
      issues.add('Direct solve from camera OCR remains prohibited.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedDirectSolveAttempt, issues, evidence);
    }
    if (evidence.modelBinaryBundledInBaseApp) {
      issues.add('PP-FormulaNet-S model bytes must not be bundled into the base APK.');
      return _blocked(GaussDeferredModelReadinessDecision.blockedBaseApkBundlingAttempt, issues, evidence);
    }

    return const GaussDeferredModelReadinessResult(
      phase: phase,
      decision: GaussDeferredModelReadinessDecision.readyForFutureQ249AdapterOnly,
      issues: <String>[],
      canRunInferenceNow: false,
      canProceedToQ249Adapter: true,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
    );
  }

  static GaussDeferredModelReadinessResult _blocked(
    GaussDeferredModelReadinessDecision decision,
    List<String> issues,
    GaussDeferredModelArtifactEvidence evidence,
  ) {
    return GaussDeferredModelReadinessResult(
      phase: phase,
      decision: decision,
      issues: List<String>.unmodifiable(issues),
      canRunInferenceNow: false,
      canProceedToQ249Adapter: false,
      mathLiveReviewRequired: evidence.mathLiveReviewRequired,
      directSolveAllowed: evidence.directSolveAllowed,
    );
  }

  static bool _looksLikeSha256(String value) {
    if (value.length != 64) return false;
    for (final code in value.codeUnits) {
      final isDigit = code >= 48 && code <= 57;
      final isLowerHex = code >= 97 && code <= 102;
      final isUpperHex = code >= 65 && code <= 70;
      if (!isDigit && !isLowerHex && !isUpperHex) return false;
    }
    return true;
  }
}
