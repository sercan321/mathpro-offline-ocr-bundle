import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_only_main_editor_flutter_log_hygiene_policy.dart';

void main() {
  group('V172-Q205R2 MathLive-only main editor Flutter log hygiene', () {
    test('policy repairs real user-side analyze/test blockers without fake PASS claims', () {
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.phase, 'V172-Q205R2');
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.q205MathLiveOnlyMainEditorPreserved, isTrue);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.userSideDartToolVerifierHygieneRepaired, isTrue);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.deadNullAwareExpressionRepaired, isTrue);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.q153SimpleFallbackExpectationRetired, isTrue);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.q155ProductionSigmaTestContractMigrated, isTrue);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.runReturningResultPathRestored, isFalse);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.visibleFallbackOverlayRestored, isFalse);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.diagnosticOverlayRestored, isFalse);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(MathLiveOnlyMainEditorFlutterLogHygienePolicy.androidRealDevicePassClaimed, isFalse);
    });

    test('source no longer contains the Q205R1 logged analyzer and test blockers', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final q153 = File('test/v172_q153_mathlive_flutter_test_contract_repair_test.dart').readAsStringSync();
      final q155 = File('test/v172_q155_mathlive_flutter_test_metadata_contract_repair_test.dart').readAsStringSync();
      final contract = File('tool/verify_mathpro_contract.py').readAsStringSync();

      expect(appShell, isNot(contains(r'errorState ??')));
      const retiredSimpleFallbackHelper = '_isMathLiveSimpleController' 'FallbackLabel';
      expect(q153, isNot(contains(retiredSimpleFallbackHelper)));
      expect(q153, contains('_mathLiveMainEditor.sendKey'));
      expect(q155, contains('Q204R2 migrated production-surface contract'));
      expect(contract, contains('USER_SIDE_GENERATED_PATH_PARTS'));
      expect(contract, contains('Ignored {len(ignored_generated)} user-side Flutter generated .dart_tool'));
    });
  });
}
