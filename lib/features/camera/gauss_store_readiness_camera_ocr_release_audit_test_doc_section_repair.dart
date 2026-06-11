import 'gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair_policy.dart';

/// V172-Q287R2 — Store-readiness Camera/OCR release audit test-doc section repair.
///
/// This phase repairs the user's real `flutter test` failures where tests scanned
/// the whole changed-files document and treated the explicit "not changed" section
/// as if it were the modified section. It changes only test/documentation court
/// wording and does not alter runtime behavior, OCR, model loading, or release state.
enum GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairDecision {
  repairedButRequiresUserRetest,
  blockedIfRuntimeOrReleaseClaimAdded,
}

class GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairResult {
  const GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairResult({
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
  final GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairDecision decision;
  final List<String> requiresUserSideRetest;
  final bool realOcrRuntimeAdded;
  final bool releasePassClaimed;
}

class GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepair {
  const GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepair._();

  static GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairResult evaluate() {
    if (GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.realOcrRuntimeAdded ||
        GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.releasePassClaimed) {
      return const GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairResult(
        phase: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.phase,
        sourcePhase: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.sourcePhase,
        repairedIssueCount: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.repairedIssueCount,
        decision: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairDecision.blockedIfRuntimeOrReleaseClaimAdded,
        requiresUserSideRetest: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.requiresUserSideRetest,
        realOcrRuntimeAdded: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.realOcrRuntimeAdded,
        releasePassClaimed: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.releasePassClaimed,
      );
    }

    return const GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairResult(
      phase: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.phase,
      sourcePhase: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.sourcePhase,
      repairedIssueCount: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.repairedIssueCount,
      decision: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairDecision.repairedButRequiresUserRetest,
      requiresUserSideRetest: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.requiresUserSideRetest,
      realOcrRuntimeAdded: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.realOcrRuntimeAdded,
      releasePassClaimed: GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.releasePassClaimed,
    );
  }
}
