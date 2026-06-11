import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_only_main_editor_analyze_test_hygiene_policy.dart';

void main() {
  group('V172-Q205R1 MathLive-only main editor analyze/test hygiene', () {
    test('policy records hygiene repair without fake Flutter or Android PASS claims', () {
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.phase, 'V172-Q205R1');
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.q205MathLiveOnlyMainEditorPreserved, isTrue);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.analyzerNullAwareWarningRepaired, isTrue);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.productionPlaceholderTestContractsUpdated, isTrue);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.equalityLiteralContractPreserved, isTrue);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.nonEditorResultDisplaySurfacePreserved, isTrue);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.runReturningResultPathRestored, isFalse);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.visibleFallbackOverlayRestored, isFalse);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.diagnosticOverlayRestored, isFalse);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.legacyMainEditorStateRestored, isFalse);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(MathLiveOnlyMainEditorAnalyzeTestHygienePolicy.androidRealDevicePassClaimed, isFalse);
    });

    test('source no longer contains the Q205 user-side analyzer blockers', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final mainSurface = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();
      final productionSurface = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      final widgetTest = File('test/widget_test.dart').readAsStringSync();

      expect(appShell, isNot(contains('envelope?.evaluatorUnsupportedReason')));
      expect(mainSurface, contains('_MathLiveProductionEditorSurfaceState? _state;'));
      expect(productionSurface, contains('void _noteBridgeSendResult'));
      expect(widgetTest, contains('non-editor result/solution display surfaces'));
      expect(widgetTest, isNot(contains('Q205 does not synthesize legacy CalculatorController result state')));
    });

    test('production template tests now assert document placeholders, not raw insert tokens', () {
      final q142 = File('test/v172_q142_mathlive_semantic_template_coverage_test.dart').readAsStringSync();
      final q151 = File('test/v172_q151_mathlive_extended_template_court_test.dart').readAsStringSync();
      final q154 = File('test/v172_q154_mathlive_flutter_analyze_contract_repair_test.dart').readAsStringSync();
      final q155 = File('test/v172_q155_mathlive_flutter_test_metadata_contract_repair_test.dart').readAsStringSync();
      final q199 = File('test/v172_q199_production_command_contract_finalization_test.dart').readAsStringSync();

      expect(q142, contains(r'\placeholder{}'));
      expect(q151, contains(r'\placeholder{}'));
      expect(q154, contains(r'\placeholder{}'));
      expect(q155, contains(r'\placeholder{}'));
      expect(q199, contains('= remains the literal equality relation'));
      expect(q199, isNot(contains("'Maclaurin', '=']")));
    });
  });
}
