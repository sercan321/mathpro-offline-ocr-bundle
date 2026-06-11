class GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy {
  const GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy._();

  static const String phase =
      'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
  static const String sourcePhase =
      'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
  static const String status =
      'LEGACY_Q336_Q343_VERIFIER_SUCCESSOR_AWARENESS_REPAIRED_FOR_Q352_NO_RUNTIME_NO_UI_CHANGE';

  static const List<String> repairedVerifierFiles = <String>[
    'tool/verify_native_package_hash_evidence_capture_q328_json_intake_v172_q336.mjs',
    'tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs',
    'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_v172_q338.mjs',
    'tool/verify_native_package_hash_evidence_capture_actual_bundle_permission_final_check_v172_q339.mjs',
    'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_evidence_blocked_gate_v172_q340.mjs',
    'tool/verify_native_package_hash_evidence_capture_bundle_evidence_acceptance_v172_q341.mjs',
    'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_v172_q342.mjs',
    'tool/verify_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_v172_q343.mjs',
    'tool/verify_q343_flutter_analyze_test_successor_aware_hygiene_repair_v172_q343r1.mjs',
    'tool/verify_q343r1_flutter_analyze_test_syntax_hygiene_repair_v172_q343r2.mjs',
  ];

  static const List<String> preservedRuntimeBoundaries = <String>[
    'Q352 ONNX conversion evidence remains accepted evidence only',
    'ONNX Runtime dependency remains absent',
    'ONNX model remains outside the Flutter project ZIP',
    'Android ONNX model load remains unattempted',
    'PP-FormulaNet-S image-to-LaTeX inference remains unexecuted',
    'OCR candidate review and workspace import remain blocked',
  ];
}
