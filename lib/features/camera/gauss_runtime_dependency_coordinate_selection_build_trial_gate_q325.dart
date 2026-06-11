import 'gauss_runtime_dependency_coordinate_selection_build_trial_gate_q325_policy.dart';

class GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Result {
  const GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Result({
    required this.phase,
    required this.sourcePhase,
    required this.runtimeDependencyCoordinateSelectionMethod,
    required this.runtimeDependencyCoordinateSelectionStatus,
    required this.selectedRuntimeDependencyCandidate,
    required this.selectedModelLoaderCandidate,
    required this.selectedRuntimeDependencyCoordinate,
    required this.candidateRuntimePaths,
    required this.buildTrialEnvelopeFields,
    required this.q325HardBlocks,
    required this.q326EntryCriteria,
    required this.runtimeDependencyAdded,
    required this.runtimeDependencyCoordinateSelected,
    required this.buildTrialExecuted,
    required this.nativeLibraryBundled,
    required this.modelLoaderAvailable,
    required this.realImageToLatexInferenceExecuted,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String runtimeDependencyCoordinateSelectionMethod;
  final String runtimeDependencyCoordinateSelectionStatus;
  final String selectedRuntimeDependencyCandidate;
  final String selectedModelLoaderCandidate;
  final String selectedRuntimeDependencyCoordinate;
  final List<String> candidateRuntimePaths;
  final List<String> buildTrialEnvelopeFields;
  final List<String> q325HardBlocks;
  final List<String> q326EntryCriteria;
  final bool runtimeDependencyAdded;
  final bool runtimeDependencyCoordinateSelected;
  final bool buildTrialExecuted;
  final bool nativeLibraryBundled;
  final bool modelLoaderAvailable;
  final bool realImageToLatexInferenceExecuted;
  final bool ocrPassClaimed;
}

class GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325 {
  const GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325._();

  static GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Result evaluate() {
    return const GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Result(
      phase: GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.phase,
      sourcePhase: GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.sourcePhase,
      runtimeDependencyCoordinateSelectionMethod:
          GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.runtimeDependencyCoordinateSelectionMethod,
      runtimeDependencyCoordinateSelectionStatus:
          GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.runtimeDependencyCoordinateSelectionStatus,
      selectedRuntimeDependencyCandidate:
          GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.selectedRuntimeDependencyCandidate,
      selectedModelLoaderCandidate:
          GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.selectedModelLoaderCandidate,
      selectedRuntimeDependencyCoordinate:
          GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.selectedRuntimeDependencyCoordinate,
      candidateRuntimePaths: GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.candidateRuntimePaths,
      buildTrialEnvelopeFields:
          GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.buildTrialEnvelopeFields,
      q325HardBlocks: GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.q325HardBlocks,
      q326EntryCriteria: GaussRuntimeDependencyCoordinateSelectionBuildTrialGateQ325Policy.q326EntryCriteria,
      runtimeDependencyAdded: false,
      runtimeDependencyCoordinateSelected: true,
      buildTrialExecuted: false,
      nativeLibraryBundled: false,
      modelLoaderAvailable: false,
      realImageToLatexInferenceExecuted: false,
      ocrPassClaimed: false,
    );
  }
}
