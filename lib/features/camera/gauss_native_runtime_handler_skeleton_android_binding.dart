import 'gauss_native_runtime_handler_skeleton_android_binding_policy.dart';

enum GaussNativeRuntimeHandlerSkeletonAndroidBindingDecision {
  skeletonContractReadyRuntimeBindingBlocked,
  blockedIfNativeRuntimeBindingOrInferenceAdded,
}

class GaussNativeRuntimeHandlerSkeletonAndroidBindingResult {
  const GaussNativeRuntimeHandlerSkeletonAndroidBindingResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.reservedMethodChannelName,
    required this.reservedNativeHandlerName,
    required this.bridgeFeatureFlag,
    required this.bindingDecision,
    required this.requestEnvelopeFields,
    required this.responseEnvelopeFields,
    required this.bridgeErrorCodes,
    required this.handlerSkeletonPreconditions,
    required this.decision,
    required this.bridgeFeatureFlagEnabledByDefault,
    required this.nativeHandlerImplementationAdded,
    required this.androidBindingImplementationAdded,
    required this.methodChannelRuntimeBindingAdded,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.imageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String reservedMethodChannelName;
  final String reservedNativeHandlerName;
  final String bridgeFeatureFlag;
  final String bindingDecision;
  final List<String> requestEnvelopeFields;
  final List<String> responseEnvelopeFields;
  final List<String> bridgeErrorCodes;
  final List<String> handlerSkeletonPreconditions;
  final GaussNativeRuntimeHandlerSkeletonAndroidBindingDecision decision;
  final bool bridgeFeatureFlagEnabledByDefault;
  final bool nativeHandlerImplementationAdded;
  final bool androidBindingImplementationAdded;
  final bool methodChannelRuntimeBindingAdded;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool imageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussNativeRuntimeHandlerSkeletonAndroidBinding {
  const GaussNativeRuntimeHandlerSkeletonAndroidBinding._();

  static GaussNativeRuntimeHandlerSkeletonAndroidBindingResult evaluate() {
    const blocked =
        GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.bridgeFeatureFlagEnabledByDefault ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.runtimeInvocationAllowedWhenFlagOff ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.nativeHandlerImplementationAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.androidBindingImplementationAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.jniBindingAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.methodChannelRuntimeBindingAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.realOcrRuntimeAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.paddleRuntimeAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.paddleOcrDependencyAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.runtimeDependencyAddedToPubspec ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.gradleNativeRuntimeDependencyAdded ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.modelBinaryBundledInBaseApp ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.productionDownloadEnabled ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.imageToLatexInferenceExecuted ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.directWorkspaceImportEnabled ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.directSolveGraphSolutionHistoryEnabled ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.androidBindingPassClaimed ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.runtimeIntegrationPassClaimed ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.ocrPassClaimed ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.cameraOcrRuntimePassClaimed ||
            GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.releasePassClaimed;

    return const GaussNativeRuntimeHandlerSkeletonAndroidBindingResult(
      phase: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.phase,
      sourcePhase: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.sourcePhase,
      selectedEngineLabel: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.selectedEngineLabel,
      reservedMethodChannelName: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.reservedMethodChannelName,
      reservedNativeHandlerName: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.reservedNativeHandlerName,
      bridgeFeatureFlag: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.bridgeFeatureFlag,
      bindingDecision: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.bindingDecision,
      requestEnvelopeFields: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.requestEnvelopeFields,
      responseEnvelopeFields: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.responseEnvelopeFields,
      bridgeErrorCodes: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.bridgeErrorCodes,
      handlerSkeletonPreconditions: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.handlerSkeletonPreconditions,
      decision: blocked
          ? GaussNativeRuntimeHandlerSkeletonAndroidBindingDecision.blockedIfNativeRuntimeBindingOrInferenceAdded
          : GaussNativeRuntimeHandlerSkeletonAndroidBindingDecision.skeletonContractReadyRuntimeBindingBlocked,
      bridgeFeatureFlagEnabledByDefault: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.bridgeFeatureFlagEnabledByDefault,
      nativeHandlerImplementationAdded: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.nativeHandlerImplementationAdded,
      androidBindingImplementationAdded: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.androidBindingImplementationAdded,
      methodChannelRuntimeBindingAdded: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.methodChannelRuntimeBindingAdded,
      realOcrRuntimeAdded: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.realOcrRuntimeAdded,
      paddleRuntimeAdded: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.paddleRuntimeAdded,
      modelBinaryBundledInBaseApp: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.modelBinaryBundledInBaseApp,
      imageToLatexInferenceExecuted: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.imageToLatexInferenceExecuted,
      ocrPassClaimed: GaussNativeRuntimeHandlerSkeletonAndroidBindingPolicy.ocrPassClaimed,
    );
  }
}
