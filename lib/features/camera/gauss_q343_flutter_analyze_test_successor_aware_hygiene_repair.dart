import 'gauss_q343_flutter_analyze_test_successor_aware_hygiene_repair_policy.dart';

class GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairResult {
  const GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairResult({
    required this.phase,
    required this.sourcePhase,
    required this.preservedCameraOcrPhase,
    required this.status,
    required this.repairedAnalyzerFiles,
    required this.successorAwarenessScope,
    required this.hardNonGoals,
    required this.cameraOcrLatestPhaseAdvanced,
    required this.mainActivityChanged,
    required this.binaryBundleExecuted,
    required this.jniLibsDirectoryCreated,
    required this.androidAppLibsDirectoryCreated,
    required this.gradleChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.uiRuntimeChanged,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String preservedCameraOcrPhase;
  final String status;
  final List<String> repairedAnalyzerFiles;
  final List<String> successorAwarenessScope;
  final List<String> hardNonGoals;
  final bool cameraOcrLatestPhaseAdvanced;
  final bool mainActivityChanged;
  final bool binaryBundleExecuted;
  final bool jniLibsDirectoryCreated;
  final bool androidAppLibsDirectoryCreated;
  final bool gradleChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool uiRuntimeChanged;
  final bool ocrPassClaimed;
}

class GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepair {
  const GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepair._();

  static GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairResult evaluate() {
    return const GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairResult(
      phase: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.phase,
      sourcePhase: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.sourcePhase,
      preservedCameraOcrPhase: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.preservedCameraOcrPhase,
      status: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.status,
      repairedAnalyzerFiles: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.repairedAnalyzerFiles,
      successorAwarenessScope: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.successorAwarenessScope,
      hardNonGoals: GaussQ343FlutterAnalyzeTestSuccessorAwareHygieneRepairPolicy.hardNonGoals,
      cameraOcrLatestPhaseAdvanced: false,
      mainActivityChanged: false,
      binaryBundleExecuted: false,
      jniLibsDirectoryCreated: false,
      androidAppLibsDirectoryCreated: false,
      gradleChanged: false,
      pubspecChanged: false,
      androidManifestChanged: false,
      uiRuntimeChanged: false,
      ocrPassClaimed: false,
    );
  }
}
