import 'gauss_q343r1_flutter_analyze_test_syntax_hygiene_repair_policy.dart';

class GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairResult {
  const GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairResult({
    required this.phase,
    required this.sourcePhase,
    required this.preservedCameraOcrPhase,
    required this.status,
    required this.repairedSyntaxFiles,
    required this.syntaxRepairScope,
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
  final List<String> repairedSyntaxFiles;
  final List<String> syntaxRepairScope;
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

class GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepair {
  const GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepair._();

  static GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairResult evaluate() {
    return const GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairResult(
      phase: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.phase,
      sourcePhase: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.sourcePhase,
      preservedCameraOcrPhase: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.preservedCameraOcrPhase,
      status: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.status,
      repairedSyntaxFiles: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.repairedSyntaxFiles,
      syntaxRepairScope: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.syntaxRepairScope,
      hardNonGoals: GaussQ343R1FlutterAnalyzeTestSyntaxHygieneRepairPolicy.hardNonGoals,
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
