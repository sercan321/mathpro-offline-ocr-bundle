import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_readiness_camera_ocr_release_audit_log_repair.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_readiness_camera_ocr_release_audit_log_repair_policy.dart';

void main() {
  group('V172-Q287R1 Store-readiness Camera/OCR release audit Flutter log repair', () {
    test('records the two real user-log repairs without OCR/runtime/release claims', () {
      final result = GaussStoreReadinessCameraOcrReleaseAuditLogRepair.evaluate();

      expect(result.phase, GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.phase);
      expect(result.sourcePhase, 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT');
      expect(result.repairedIssueCount, 2);
      expect(result.decision, GaussStoreReadinessCameraOcrReleaseAuditLogRepairDecision.repairedButRequiresUserRetest);
      expect(result.requiresUserSideRetest, contains('flutter analyze'));
      expect(result.requiresUserSideRetest, contains('flutter test'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.releasePassClaimed, isFalse);

      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.repairsQ277R3MalformedTestString, isTrue);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.repairsMathLiveKeepCaretVisibleAnalyzerWarning, isTrue);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.keepsQ277R3TapLatencyCadenceIntent, isTrue);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.keepsCaretVisibilityHelperOnFirstRuntimeMountOnly, isTrue);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.paddleRuntimeAdded, isFalse);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.storeReadyPassClaimed, isFalse);
      expect(GaussStoreReadinessCameraOcrReleaseAuditLogRepairPolicy.releasePassClaimed, isFalse);
    });

    test('fixes the malformed Q277R3 test string and keeps protected UI red lines out', () {
      final q277r3Test = File('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart').readAsStringSync();
      final surface = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      final changed = File('docs/audit/V172_Q287R1_CHANGED_FILES.md').readAsStringSync();

      expect(q277r3Test, contains('q200-production-command-refresh-")));'));
      expect(q277r3Test, isNot(contains('q200-production-command-refresh-"))));')));
      expect(surface, contains('q287r1-production-mounted-caret-visibility-check'));
      expect(surface, contains('unawaited(_keepCaretVisible'));
      final modified = changed.split('## Modified').last.split('## Not Changed').first;
      final notChanged = changed.split('## Not Changed').last.split('## Runtime Boundary').first;
      expect(modified, contains('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart'));
      expect(modified, contains('lib/features/mathlive/mathlive_production_editor_surface.dart'));
      expect(modified, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
      expect(modified, isNot(contains('- `lib/features/keyboard/math_keyboard.dart`')));
      expect(modified, isNot(contains('- `lib/features/keyboard/long_press_popup.dart`')));
      expect(modified, isNot(contains('- `lib/features/workspace/template_tray.dart`')));
      expect(modified, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
      expect(modified, isNot(contains('- `lib/features/graph/graph_card.dart`')));
      expect(modified, isNot(contains('- `lib/features/solution/solution_steps_panel.dart`')));
      expect(modified, isNot(contains('- `lib/features/history/history_panel.dart`')));
      expect(modified, isNot(contains('- `android/app/src/main/AndroidManifest.xml`')));
      expect(notChanged, contains('- `lib/features/keyboard/key_config.dart`'));
      expect(notChanged, contains('- `assets/mathlive/mathlive_prod_bridge.js`'));
    });
  });
}
