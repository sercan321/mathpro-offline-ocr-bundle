/// V172-Q248 — Deferred Model Download Runtime policy.
///
/// Q248 prepares the PP-FormulaNet-S deferred model install/download runtime
/// contract without bundling model bytes into the base APK and without enabling
/// OCR inference. It is a guard/state-machine phase: model readiness requires a
/// verified artifact, private app storage, SHA256 integrity, offline-after-install
/// state, and editable MathLive review before any future Q249 adapter may run.
class GaussDeferredModelDownloadRuntimePolicy {
  const GaussDeferredModelDownloadRuntimePolicy._();

  static const phase = 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME';
  static const closesOverPhase = 'V172-Q247R1-PP_FORMULANET_S_USER_SELECTION_LOCK';
  static const sourcePackageSha256 = '087846a64d0613dcf60896e5744bfb99d8100012fcbc56cc1520e5c1c4b29b05';

  static const selectedEngineLabel = 'PP-FormulaNet-S';
  static const selectedEngineFamily = 'pp_formula_net_s';
  static const fallbackEngineLabel = 'PP-FormulaNet_plus-L';
  static const modelPackId = 'gauss_pp_formulanet_s_optional_math_ocr_pack';
  static const modelInstallMode = 'deferred-after-install';
  static const modelStoragePolicy = 'app-private-storage';
  static const defaultNetworkPolicy = 'wifi-only-until-user-overrides';
  static const expectedModelVersion = 'pending-verified-pp-formulanet-s-artifact';
  static const expectedModelSha256 = 'pending-verified-pp-formulanet-s-sha256';
  static const maxModelSizeBytes = 256 * 1024 * 1024;

  static const q247R1UserSelectionPreserved = true;
  static const deferredModelStateMachineImplemented = true;
  static const modelIntegrityGateImplemented = true;
  static const sha256VerificationRequiredBeforeReady = true;
  static const privateAppStorageRequiredBeforeReady = true;
  static const offlineAfterInstallRequiredBeforeInference = true;
  static const mathLiveEditableReviewRequiredBeforeImport = true;
  static const baseApkMustNotCarryModelBytes = true;
  static const brokenOrUnverifiedModelMustNotRun = true;
  static const q249RuntimeAdapterStillRequired = true;

  static const realOcrRuntimeAdded = false;
  static const paddleRuntimeAdded = false;
  static const paddleOcrDependencyAdded = false;
  static const textOcrFallbackRuntimeAdded = false;
  static const onnxRuntimeAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const productionModelUrlBound = false;
  static const productionDownloadWorkerImplemented = false;
  static const productionInferenceAllowed = false;
  static const productionRuntimeBindingAllowed = false;
  static const cameraRuntimeShellChanged = false;
  static const workspaceRuntimeChanged = false;
  static const mathLiveProductionBridgeCalled = false;
  static const directWorkspaceImportImplemented = false;
  static const directSolveFromCameraAllowed = false;
  static const directGraphFromCameraAllowed = false;
  static const directSolutionFromCameraAllowed = false;
  static const directHistoryFromCameraAllowed = false;
  static const androidToolchainModernizationDeferredToQ253 = true;
  static const cameraDependencyChanged = false;
  static const androidSettingsGradleChanged = false;
  static const androidManifestChanged = false;
  static const mainActivityChanged = false;

  static const keyboardMutationAllowed = false;
  static const longPressMutationAllowed = false;
  static const moreMutationAllowed = false;
  static const mathLiveProductionMutationAllowed = false;
  static const graphMutationAllowed = false;
  static const solutionMutationAllowed = false;
  static const historyMutationAllowed = false;
  static const splashLauncherMutationAllowed = false;

  static const flutterAnalyzePassClaimedByAssistant = false;
  static const flutterTestPassClaimedByAssistant = false;
  static const flutterRunPassClaimedByAssistant = false;
  static const androidRealDeviceDownloadPassClaimedByAssistant = false;
  static const realPpFormulaNetSInferencePassClaimedByAssistant = false;

  static const nextPlannedPhase = 'V172-Q249-OCR-RUNTIME-ADAPTER';
}
