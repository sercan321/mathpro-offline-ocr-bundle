import 'gauss_q351_flutter_run_kotlin_build_helper_repair_q351r2_policy.dart';

class GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Result {
  const GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Result({
    required this.phase,
    required this.sourcePhase,
    required this.preservedCameraOcrLatestPhase,
    required this.kotlinBuildHelperRepair,
    required this.mainActivityChanged,
    required this.gradleChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.systemLoadLibraryAdded,
    required this.paddleLiteInstantiated,
    required this.modelLoadAttempted,
    required this.modelLoaded,
    required this.runtimeStartupExecuted,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String preservedCameraOcrLatestPhase;
  final bool kotlinBuildHelperRepair;
  final bool mainActivityChanged;
  final bool gradleChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool systemLoadLibraryAdded;
  final bool paddleLiteInstantiated;
  final bool modelLoadAttempted;
  final bool modelLoaded;
  final bool runtimeStartupExecuted;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2 {
  const GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2._();

  static GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Result evaluate() {
    return const GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Result(
      phase: GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.phase,
      sourcePhase: GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.sourcePhase,
      preservedCameraOcrLatestPhase: GaussQ351FlutterRunKotlinBuildHelperRepairQ351R2Policy.preservedCameraOcrLatestPhase,
      kotlinBuildHelperRepair: true,
      mainActivityChanged: true,
      gradleChanged: false,
      pubspecChanged: false,
      androidManifestChanged: false,
      systemLoadLibraryAdded: false,
      paddleLiteInstantiated: false,
      modelLoadAttempted: false,
      modelLoaded: false,
      runtimeStartupExecuted: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
