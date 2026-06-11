import 'gauss_native_library_load_smoke_q346_policy.dart';

class GaussNativeLibraryLoadSmokeQ346Result {
  const GaussNativeLibraryLoadSmokeQ346Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.requiredBundledBinaryInputs,
    required this.loadSmokeBridgeSignals,
    required this.q345GradleAbiPackagingBuildTrialPresent,
    required this.q344ActualBinaryBundlePresent,
    required this.nativeLibraryLoadSmokeBridgeAdded,
    required this.nativeLibraryLoadFeatureDefaultEnabled,
    required this.automaticStartupLoad,
    required this.assistantExecutedNativeLoadSmoke,
    required this.paddlePredictorJarBundled,
    required this.arm64V8aNativeLibraryBundled,
    required this.armeabiV7aNativeLibraryBundled,
    required this.x86_64NativeLibraryBundled,
    required this.mainActivityChanged,
    required this.gradleChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.paddleLiteInstantiated,
    required this.modelLoaderAvailable,
    required this.modelLoaded,
    required this.runtimeStartupExecuted,
    required this.dummyRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.editableMathLiveReviewOpened,
    required this.workspaceImportExecuted,
    required this.flutterAnalyzePassClaimed,
    required this.flutterTestPassClaimed,
    required this.androidRealDevicePassClaimed,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final List<String> requiredBundledBinaryInputs;
  final List<String> loadSmokeBridgeSignals;
  final bool q345GradleAbiPackagingBuildTrialPresent;
  final bool q344ActualBinaryBundlePresent;
  final bool nativeLibraryLoadSmokeBridgeAdded;
  final bool nativeLibraryLoadFeatureDefaultEnabled;
  final bool automaticStartupLoad;
  final bool assistantExecutedNativeLoadSmoke;
  final bool paddlePredictorJarBundled;
  final bool arm64V8aNativeLibraryBundled;
  final bool armeabiV7aNativeLibraryBundled;
  final bool x86_64NativeLibraryBundled;
  final bool mainActivityChanged;
  final bool gradleChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool paddleLiteInstantiated;
  final bool modelLoaderAvailable;
  final bool modelLoaded;
  final bool runtimeStartupExecuted;
  final bool dummyRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool editableMathLiveReviewOpened;
  final bool workspaceImportExecuted;
  final bool flutterAnalyzePassClaimed;
  final bool flutterTestPassClaimed;
  final bool androidRealDevicePassClaimed;
  final bool ocrPassClaimed;
}

class GaussNativeLibraryLoadSmokeQ346 {
  const GaussNativeLibraryLoadSmokeQ346._();

  static GaussNativeLibraryLoadSmokeQ346Result evaluate() {
    return const GaussNativeLibraryLoadSmokeQ346Result(
      phase: GaussNativeLibraryLoadSmokeQ346Policy.phase,
      sourcePhase: GaussNativeLibraryLoadSmokeQ346Policy.sourcePhase,
      status: GaussNativeLibraryLoadSmokeQ346Policy.status,
      requiredBundledBinaryInputs: GaussNativeLibraryLoadSmokeQ346Policy.requiredBundledBinaryInputs,
      loadSmokeBridgeSignals: GaussNativeLibraryLoadSmokeQ346Policy.loadSmokeBridgeSignals,
      q345GradleAbiPackagingBuildTrialPresent: true,
      q344ActualBinaryBundlePresent: true,
      nativeLibraryLoadSmokeBridgeAdded: true,
      nativeLibraryLoadFeatureDefaultEnabled: false,
      automaticStartupLoad: false,
      assistantExecutedNativeLoadSmoke: false,
      paddlePredictorJarBundled: true,
      arm64V8aNativeLibraryBundled: true,
      armeabiV7aNativeLibraryBundled: true,
      x86_64NativeLibraryBundled: false,
      mainActivityChanged: true,
      gradleChanged: false,
      pubspecChanged: false,
      androidManifestChanged: false,
      paddleLiteInstantiated: false,
      modelLoaderAvailable: false,
      modelLoaded: false,
      runtimeStartupExecuted: false,
      dummyRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      editableMathLiveReviewOpened: false,
      workspaceImportExecuted: false,
      flutterAnalyzePassClaimed: false,
      flutterTestPassClaimed: false,
      androidRealDevicePassClaimed: false,
      ocrPassClaimed: false,
    );
  }
}
