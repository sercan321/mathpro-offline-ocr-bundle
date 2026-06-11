import 'gauss_runtime_dependency_actual_trial_default_off_policy.dart';

/// V172-Q289 — Runtime Dependency Actual Trial Behind Default-Off Flag.
///
/// This phase is deliberately conservative because Q288 still records the real
/// model SHA as pending. It installs the default-off dependency trial contract
/// and blocks any pubspec/runtime mutation until source, SHA, ABI, memory,
/// latency, rollback, and real-device smoke evidence are real.
enum GaussRuntimeDependencyActualTrialDefaultOffDecision {
  trialContractReadyButDependencyBlocked,
  blockedIfDependencyRuntimeOrPassClaimAdded,
}

class GaussRuntimeDependencyActualTrialDefaultOffResult {
  const GaussRuntimeDependencyActualTrialDefaultOffResult({
    required this.phase,
    required this.sourcePhase,
    required this.selectedEngineLabel,
    required this.dependencyTrialFlag,
    required this.dependencyDecision,
    required this.dependencyTrialPreconditions,
    required this.decision,
    required this.dependencyTrialDefaultEnabled,
    required this.dependencyAddedToPubspec,
    required this.dependencyImportedInProductionCode,
    required this.runtimeActivationAllowed,
    required this.realOcrRuntimeAdded,
    required this.paddleRuntimeAdded,
    required this.modelBinaryBundledInBaseApp,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String selectedEngineLabel;
  final String dependencyTrialFlag;
  final String dependencyDecision;
  final List<String> dependencyTrialPreconditions;
  final GaussRuntimeDependencyActualTrialDefaultOffDecision decision;
  final bool dependencyTrialDefaultEnabled;
  final bool dependencyAddedToPubspec;
  final bool dependencyImportedInProductionCode;
  final bool runtimeActivationAllowed;
  final bool realOcrRuntimeAdded;
  final bool paddleRuntimeAdded;
  final bool modelBinaryBundledInBaseApp;
  final bool ocrPassClaimed;
}

class GaussRuntimeDependencyActualTrialDefaultOff {
  const GaussRuntimeDependencyActualTrialDefaultOff._();

  static GaussRuntimeDependencyActualTrialDefaultOffResult evaluate() {
    const blocked =
        GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialDefaultEnabled ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyAddedToPubspec ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyImportedInProductionCode ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.runtimeActivationAllowed ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.realOcrRuntimeAdded ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.paddleRuntimeAdded ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.modelBinaryBundledInBaseApp ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.ocrPassClaimed ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.cameraOcrRuntimePassClaimed ||
            GaussRuntimeDependencyActualTrialDefaultOffPolicy.releasePassClaimed;

    return const GaussRuntimeDependencyActualTrialDefaultOffResult(
      phase: GaussRuntimeDependencyActualTrialDefaultOffPolicy.phase,
      sourcePhase: GaussRuntimeDependencyActualTrialDefaultOffPolicy.sourcePhase,
      selectedEngineLabel: GaussRuntimeDependencyActualTrialDefaultOffPolicy.selectedEngineLabel,
      dependencyTrialFlag: GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialFlag,
      dependencyDecision: GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyDecision,
      dependencyTrialPreconditions: GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialPreconditions,
      decision: blocked
          ? GaussRuntimeDependencyActualTrialDefaultOffDecision.blockedIfDependencyRuntimeOrPassClaimAdded
          : GaussRuntimeDependencyActualTrialDefaultOffDecision.trialContractReadyButDependencyBlocked,
      dependencyTrialDefaultEnabled: GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialDefaultEnabled,
      dependencyAddedToPubspec: GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyAddedToPubspec,
      dependencyImportedInProductionCode: GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyImportedInProductionCode,
      runtimeActivationAllowed: GaussRuntimeDependencyActualTrialDefaultOffPolicy.runtimeActivationAllowed,
      realOcrRuntimeAdded: GaussRuntimeDependencyActualTrialDefaultOffPolicy.realOcrRuntimeAdded,
      paddleRuntimeAdded: GaussRuntimeDependencyActualTrialDefaultOffPolicy.paddleRuntimeAdded,
      modelBinaryBundledInBaseApp: GaussRuntimeDependencyActualTrialDefaultOffPolicy.modelBinaryBundledInBaseApp,
      ocrPassClaimed: GaussRuntimeDependencyActualTrialDefaultOffPolicy.ocrPassClaimed,
    );
  }
}
