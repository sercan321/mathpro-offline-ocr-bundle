import 'gauss_private_model_download_sha_verification_runtime_policy.dart';

enum GaussPrivateModelDownloadShaVerificationRuntimeDecision {
  downloadShaContractReadyProductionDownloadBlocked,
  blockedIfDownloadRuntimeArtifactOrPassClaimAdded,
}

class GaussPrivateModelDownloadShaVerificationRuntimeResult {
  const GaussPrivateModelDownloadShaVerificationRuntimeResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.downloadFeatureFlag,
    required this.expectedSha256State,
    required this.artifactAcceptanceDecision,
    required this.privateStorageRootPolicy,
    required this.downloadVerificationPreconditions,
    required this.privateArtifactEnvelopeFields,
    required this.downloadErrorCodes,
    required this.decision,
    required this.downloadFeatureFlagEnabledByDefault,
    required this.productionDownloadEnabled,
    required this.realNetworkDownloadWorkerImplemented,
    required this.modelDownloadStarted,
    required this.actualSha256ComputedInPackage,
    required this.artifactSha256Verified,
    required this.artifactAcceptedForRuntime,
    required this.privateArtifactLoadEnabled,
    required this.runtimeInvocationEnabled,
    required this.modelBinaryBundledInBaseApp,
    required this.imageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String downloadFeatureFlag;
  final String expectedSha256State;
  final String artifactAcceptanceDecision;
  final String privateStorageRootPolicy;
  final List<String> downloadVerificationPreconditions;
  final List<String> privateArtifactEnvelopeFields;
  final List<String> downloadErrorCodes;
  final GaussPrivateModelDownloadShaVerificationRuntimeDecision decision;
  final bool downloadFeatureFlagEnabledByDefault;
  final bool productionDownloadEnabled;
  final bool realNetworkDownloadWorkerImplemented;
  final bool modelDownloadStarted;
  final bool actualSha256ComputedInPackage;
  final bool artifactSha256Verified;
  final bool artifactAcceptedForRuntime;
  final bool privateArtifactLoadEnabled;
  final bool runtimeInvocationEnabled;
  final bool modelBinaryBundledInBaseApp;
  final bool imageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussPrivateModelDownloadShaVerificationRuntime {
  const GaussPrivateModelDownloadShaVerificationRuntime._();

  static GaussPrivateModelDownloadShaVerificationRuntimeResult evaluate() {
    const blocked =
        GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadFeatureFlagEnabledByDefault ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.productionDownloadEnabled ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.realNetworkDownloadWorkerImplemented ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.modelDownloadStarted ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.actualSha256ComputedInPackage ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.artifactSha256Verified ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.artifactAcceptedForRuntime ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateArtifactLoadEnabled ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.runtimeInvocationEnabled ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.nativeHandlerImplementationAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.androidBindingImplementationAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.jniBindingAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.methodChannelRuntimeBindingAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.realOcrRuntimeAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.paddleRuntimeAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.paddleOcrDependencyAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.runtimeDependencyAddedToPubspec ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.gradleNativeRuntimeDependencyAdded ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.modelBinaryBundledInBaseApp ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.productionModelUrlBound ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.imageToLatexInferenceExecuted ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.directWorkspaceImportEnabled ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.directSolveGraphSolutionHistoryEnabled ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.modelDownloadPassClaimed ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.shaVerificationPassClaimed ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.runtimeIntegrationPassClaimed ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.ocrPassClaimed ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.cameraOcrRuntimePassClaimed ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.storeReadyPassClaimed ||
            GaussPrivateModelDownloadShaVerificationRuntimePolicy.releasePassClaimed;

    return const GaussPrivateModelDownloadShaVerificationRuntimeResult(
      phase: GaussPrivateModelDownloadShaVerificationRuntimePolicy.phase,
      sourcePhase: GaussPrivateModelDownloadShaVerificationRuntimePolicy.sourcePhase,
      selectedEngineLabel: GaussPrivateModelDownloadShaVerificationRuntimePolicy.selectedEngineLabel,
      downloadFeatureFlag: GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadFeatureFlag,
      expectedSha256State: GaussPrivateModelDownloadShaVerificationRuntimePolicy.expectedSha256State,
      artifactAcceptanceDecision: GaussPrivateModelDownloadShaVerificationRuntimePolicy.artifactAcceptanceDecision,
      privateStorageRootPolicy: GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateStorageRootPolicy,
      downloadVerificationPreconditions: GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadVerificationPreconditions,
      privateArtifactEnvelopeFields: GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateArtifactEnvelopeFields,
      downloadErrorCodes: GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadErrorCodes,
      decision: blocked
          ? GaussPrivateModelDownloadShaVerificationRuntimeDecision.blockedIfDownloadRuntimeArtifactOrPassClaimAdded
          : GaussPrivateModelDownloadShaVerificationRuntimeDecision.downloadShaContractReadyProductionDownloadBlocked,
      downloadFeatureFlagEnabledByDefault: GaussPrivateModelDownloadShaVerificationRuntimePolicy.downloadFeatureFlagEnabledByDefault,
      productionDownloadEnabled: GaussPrivateModelDownloadShaVerificationRuntimePolicy.productionDownloadEnabled,
      realNetworkDownloadWorkerImplemented: GaussPrivateModelDownloadShaVerificationRuntimePolicy.realNetworkDownloadWorkerImplemented,
      modelDownloadStarted: GaussPrivateModelDownloadShaVerificationRuntimePolicy.modelDownloadStarted,
      actualSha256ComputedInPackage: GaussPrivateModelDownloadShaVerificationRuntimePolicy.actualSha256ComputedInPackage,
      artifactSha256Verified: GaussPrivateModelDownloadShaVerificationRuntimePolicy.artifactSha256Verified,
      artifactAcceptedForRuntime: GaussPrivateModelDownloadShaVerificationRuntimePolicy.artifactAcceptedForRuntime,
      privateArtifactLoadEnabled: GaussPrivateModelDownloadShaVerificationRuntimePolicy.privateArtifactLoadEnabled,
      runtimeInvocationEnabled: GaussPrivateModelDownloadShaVerificationRuntimePolicy.runtimeInvocationEnabled,
      modelBinaryBundledInBaseApp: GaussPrivateModelDownloadShaVerificationRuntimePolicy.modelBinaryBundledInBaseApp,
      imageToLatexInferenceExecuted: GaussPrivateModelDownloadShaVerificationRuntimePolicy.imageToLatexInferenceExecuted,
      ocrPassClaimed: GaussPrivateModelDownloadShaVerificationRuntimePolicy.ocrPassClaimed,
    );
  }
}
