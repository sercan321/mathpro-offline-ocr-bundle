import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_readiness_camera_ocr_release_audit_test_doc_section_repair_policy.dart';

void main() {
  group('V172-Q287R2 Store-readiness Camera/OCR release audit test-doc section repair', () {
    test('records the real user-log test-documentation repair without OCR/runtime/release claims', () {
      final result = GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepair.evaluate();

      expect(result.phase, GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.phase);
      expect(result.sourcePhase, 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR');
      expect(result.repairedIssueCount, 2);
      expect(result.decision, GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairDecision.repairedButRequiresUserRetest);
      expect(result.requiresUserSideRetest, contains('flutter analyze'));
      expect(result.requiresUserSideRetest, contains('flutter test'));
      expect(GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.repairsQ277R3ChangedFilesSectionAssertion, isTrue);
      expect(GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.repairsQ287R1ChangedFilesSectionAssertion, isTrue);
      expect(GaussStoreReadinessCameraOcrReleaseAuditTestDocSectionRepairPolicy.changesRuntimeBehavior, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('checks changed-files red lines by Modified section rather than whole document text', () {
      final q277r3Test = File('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart').readAsStringSync();
      final q287r1Test = File('test/v172_q287r1_store_readiness_camera_ocr_release_audit_log_repair_test.dart').readAsStringSync();
      final changed = File('docs/audit/V172_Q287R2_CHANGED_FILES.md').readAsStringSync();

      expect(q277r3Test, contains("split('## Modified').last.split('## Explicitly Not Modified').first"));
      expect(q287r1Test, contains("split('## Modified').last.split('## Not Changed').first"));
      expect(q287r1Test, contains("split('## Not Changed').last.split('## Runtime Boundary').first"));
      expect(changed, contains('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart'));
      expect(changed, contains('test/v172_q287r1_store_readiness_camera_ocr_release_audit_log_repair_test.dart'));
      expect(changed, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
      expect(changed, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
    });
  });
}
