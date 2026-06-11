import 'gauss_gradle_abi_packaging_build_trial_q345_policy.dart';

class GaussGradleAbiPackagingBuildTrialQ345Result {
  const GaussGradleAbiPackagingBuildTrialQ345Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.packagedBinaryInputs,
    required this.gradlePackagingSignals,
    required this.q344ActualBinaryBundlePresent,
    required this.paddlePredictorJarDependencyDeclared,
    required this.jniLibsAbiSourceSetPresent,
    required this.arm64V8aNativeLibraryPresent,
    required this.armeabiV7aNativeLibraryPresent,
    required this.x86_64NativeLibraryPresent,
    required this.gradleChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.mainActivityChanged,
    required this.systemLoadLibraryAdded,
    required this.paddleLiteInstantiated,
    required this.modelLoaderAvailable,
    required this.runtimeStartupExecuted,
    required this.dummyRuntimeCallExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.editableMathLiveReviewOpened,
    required this.workspaceImportExecuted,
    required this.buildTrialExecutedByAssistant,
    required this.flutterAnalyzePassClaimed,
    required this.flutterTestPassClaimed,
    required this.androidRealDevicePassClaimed,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final List<String> packagedBinaryInputs;
  final List<String> gradlePackagingSignals;
  final bool q344ActualBinaryBundlePresent;
  final bool paddlePredictorJarDependencyDeclared;
  final bool jniLibsAbiSourceSetPresent;
  final bool arm64V8aNativeLibraryPresent;
  final bool armeabiV7aNativeLibraryPresent;
  final bool x86_64NativeLibraryPresent;
  final bool gradleChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool mainActivityChanged;
  final bool systemLoadLibraryAdded;
  final bool paddleLiteInstantiated;
  final bool modelLoaderAvailable;
  final bool runtimeStartupExecuted;
  final bool dummyRuntimeCallExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool editableMathLiveReviewOpened;
  final bool workspaceImportExecuted;
  final bool buildTrialExecutedByAssistant;
  final bool flutterAnalyzePassClaimed;
  final bool flutterTestPassClaimed;
  final bool androidRealDevicePassClaimed;
  final bool ocrPassClaimed;
}

class GaussGradleAbiPackagingBuildTrialQ345 {
  const GaussGradleAbiPackagingBuildTrialQ345._();

  static GaussGradleAbiPackagingBuildTrialQ345Result evaluate() {
    return const GaussGradleAbiPackagingBuildTrialQ345Result(
      phase: GaussGradleAbiPackagingBuildTrialQ345Policy.phase,
      sourcePhase: GaussGradleAbiPackagingBuildTrialQ345Policy.sourcePhase,
      status: GaussGradleAbiPackagingBuildTrialQ345Policy.status,
      packagedBinaryInputs: GaussGradleAbiPackagingBuildTrialQ345Policy.packagedBinaryInputs,
      gradlePackagingSignals: GaussGradleAbiPackagingBuildTrialQ345Policy.gradlePackagingSignals,
      q344ActualBinaryBundlePresent: true,
      paddlePredictorJarDependencyDeclared: true,
      jniLibsAbiSourceSetPresent: true,
      arm64V8aNativeLibraryPresent: true,
      armeabiV7aNativeLibraryPresent: true,
      x86_64NativeLibraryPresent: false,
      gradleChanged: true,
      pubspecChanged: false,
      androidManifestChanged: false,
      mainActivityChanged: false,
      systemLoadLibraryAdded: false,
      paddleLiteInstantiated: false,
      modelLoaderAvailable: false,
      runtimeStartupExecuted: false,
      dummyRuntimeCallExecuted: false,
      realImageToLatexInferenceExecuted: false,
      editableMathLiveReviewOpened: false,
      workspaceImportExecuted: false,
      buildTrialExecutedByAssistant: false,
      flutterAnalyzePassClaimed: false,
      flutterTestPassClaimed: false,
      androidRealDevicePassClaimed: false,
      ocrPassClaimed: false,
    );
  }
}
