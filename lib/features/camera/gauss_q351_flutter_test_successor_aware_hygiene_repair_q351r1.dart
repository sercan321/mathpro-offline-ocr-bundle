import 'gauss_q351_flutter_test_successor_aware_hygiene_repair_q351r1_policy.dart';

class GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Result {
  const GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Result({
    required this.phase,
    required this.sourcePhase,
    required this.preservedCameraOcrLatestPhase,
    required this.successorAwarenessRepair,
    required this.generatedBuildArtifactExclusionRepair,
    required this.runtimeMarkerExpectationRepair,
    required this.mainActivityChanged,
    required this.gradleChanged,
    required this.pubspecChanged,
    required this.androidManifestChanged,
    required this.modelLoadAttempted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String preservedCameraOcrLatestPhase;
  final bool successorAwarenessRepair;
  final bool generatedBuildArtifactExclusionRepair;
  final bool runtimeMarkerExpectationRepair;
  final bool mainActivityChanged;
  final bool gradleChanged;
  final bool pubspecChanged;
  final bool androidManifestChanged;
  final bool modelLoadAttempted;
  final bool ocrPassClaimed;
}

class GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1 {
  const GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1._();

  static GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Result evaluate() {
    return const GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Result(
      phase: GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.phase,
      sourcePhase: GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.sourcePhase,
      preservedCameraOcrLatestPhase: GaussQ351FlutterTestSuccessorAwareHygieneRepairQ351R1Policy.preservedCameraOcrLatestPhase,
      successorAwarenessRepair: true,
      generatedBuildArtifactExclusionRepair: true,
      runtimeMarkerExpectationRepair: true,
      mainActivityChanged: false,
      gradleChanged: false,
      pubspecChanged: false,
      androidManifestChanged: false,
      modelLoadAttempted: false,
      ocrPassClaimed: false,
    );
  }
}
