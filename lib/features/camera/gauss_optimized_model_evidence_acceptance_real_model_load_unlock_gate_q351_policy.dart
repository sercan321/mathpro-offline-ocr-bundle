class GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy {
  const GaussOptimizedModelEvidenceAcceptanceRealModelLoadUnlockGateQ351Policy._();

  static const String phase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
  static const String sourcePhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
  static const String status =
      'OPTIMIZED_MODEL_EVIDENCE_ACCEPTANCE_REAL_MODEL_LOAD_UNLOCK_BLOCKED_PENDING_EXTERNAL_Q350_EVIDENCE_AND_MODEL_LOADER_PATH_DEFAULT_OFF';

  static const String externalOptimizedModelEvidenceRootPolicy =
      '../MathProOcrArtifacts/PP-FormulaNet-S-PaddleLite-Optimized';
  static const String q350CaptureScript =
      'tool/capture_pp_formulanet_s_optimized_model_evidence_v172_q350.mjs';
  static const String q351IntakeScript =
      'tool/intake_pp_formulanet_s_optimized_model_evidence_v172_q351.mjs';

  static const List<String> requiredBeforeRealModelLoad = <String>[
    'q350 optimized model conversion evidence JSON exists outside project root',
    'optimized Paddle Lite Android model artifact or model directory is present',
    'conversion command and conversion log are present',
    'converted model file SHA256 and size are captured',
    'model-loader path contract is approved for Android runtime',
    'user-side clean Flutter analyze/test/run or build evidence exists after Q350/Q351',
  ];
}
