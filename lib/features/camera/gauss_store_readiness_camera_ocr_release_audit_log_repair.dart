import 'gauss_store_readiness_camera_ocr_release_audit_log_repair_policy.dart';

/// V172-Q287R1 — Store-readiness Camera/OCR release audit Flutter log repair.
///
/// This is a surgical repair for the user's real `flutter analyze` / `flutter test`
/// log only. It fixes the malformed Q277R3 test string and keeps the existing
/// MathLive caret-visibility helper referenced on first production mount. It does
/// not add OCR runtime, model binaries, native handlers, downloads, or release PASS.
enum GaussStoreReadinessCameraOcrReleaseAuditLogRepairDecision {
  repairedButRequiresUserRetest,
  blockedIfRuntimeOrReleaseClaimAdded,
}

class GaussStoreReadinessCameraOcrReleaseAuditLogRepairResult {
  const GaussStoreReadinessCameraOcrReleaseAuditLogRepairResult({
    required this.phase,
    required this.sourcePhase,
    required this.repairedIssueCount,
    required this.decision,
    required this.requiresUserSideRetest,
    required this.realOcrRuntimeAdded,
    required this.releasePassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final int repairedIssueCount;
  final GaussStoreReadinessCameraOcrReleaseAuditLogRepairDecision decision;
  final List<String> requiresUserSideRetest;
  final bool realOcrRuntimeAdded;
  final bool releasePassClaimed;
}

class GaussStoreReadinessCameraOcrReleaseAuditLogRepair {
  const GaussStoreReadinessCameraOcrReleaseAuditLogRepair._();

  static GaussStoreReadinessCameraOcrReleaseAuditLogRepairResult evaluate() {
    if (GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.realOcrRuntimeAdded ||
        GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.releasePassClaimed) {
      return const GaussStoreReadinessCameraOcrReleaseAuditLogRepairResult(
        phase: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.phase,
        sourcePhase: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.sourcePhase,
        repairedIssueCount: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.repairedIssueCount,
        decision: GaussStoreReadinessCameraOcrReleaseAuditLogRepairDecision.blockedIfRuntimeOrReleaseClaimAdded,
        requiresUserSideRetest: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.requiresUserSideRetest,
        realOcrRuntimeAdded: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.realOcrRuntimeAdded,
        releasePassClaimed: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.releasePassClaimed,
      );
    }

    return const GaussStoreReadinessCameraOcrReleaseAuditLogRepairResult(
      phase: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.phase,
      sourcePhase: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.sourcePhase,
      repairedIssueCount: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.repairedIssueCount,
      decision: GaussStoreReadinessCameraOcrReleaseAuditLogRepairDecision.repairedButRequiresUserRetest,
      requiresUserSideRetest: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.requiresUserSideRetest,
      realOcrRuntimeAdded: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.realOcrRuntimeAdded,
      releasePassClaimed: GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.releasePassClaimed,
    );
  }
}
