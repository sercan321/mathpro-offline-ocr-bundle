import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_flutter_test_contract_repair_policy.dart';

void main() {
  group('V172-Q153 MathLive Flutter test contract repair', () {
    test('policy repairs user-side test contracts without fake PASS claims', () {
      expect(MathLiveFlutterTestContractRepairPolicy.phase, 'V172-Q153');
      expect(MathLiveFlutterTestContractRepairPolicy.q141CompatibilityMarkersRestored, isTrue);
      expect(MathLiveFlutterTestContractRepairPolicy.popupNoClipEnvelopeRebalanced, isTrue);
      expect(MathLiveFlutterTestContractRepairPolicy.simpleGraphKeyFallbackForWidgetTests, isTrue);
      expect(MathLiveFlutterTestContractRepairPolicy.q152VerifierIgnoresUserSideGeneratedBuildDirs, isTrue);
      expect(MathLiveFlutterTestContractRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(MathLiveFlutterTestContractRepairPolicy.longPressOrderMutationAllowed, isFalse);
      expect(MathLiveFlutterTestContractRepairPolicy.realDevicePassClaimed, isFalse);
      expect(MathLiveFlutterTestContractRepairPolicy.photomathLevelClaimed, isFalse);
    });

    test('restores Q141 static markers through later MathLive bridge/CSS phases', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final html = File('assets/mathlive/main_editor.html').readAsStringSync();
      expect(bridge, contains('q141-touchend-selection-synced'));
      expect(html, contains('min-height: 72px'));
    });

    test('rebalances popup sizing back to the no-clip envelope required by legacy tests', () {
      expect(PremiumPopupFitPolicy.testContractRepairPhase, 'V172-Q153');
      expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
      expect(PremiumPopupFitPolicy.longPressChipHeight, inInclusiveRange(44, 56));
      expect(PremiumPopupFitPolicy.longPressPanelMaxHeight, lessThanOrEqualTo(72));
    });

    test('Q205 MathLive-only editor retires AppShell simple-key fallback instead of reviving raw text paths', () {
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      expect(appShell, isNot(contains('_syncMathLiveSimpleKeyFallbackForTests')), reason: 'Q205 MathLive-only editor removed the legacy simple-key fallback path.');
      const retiredSimpleFallbackHelper = '_isMathLiveSimpleController' 'FallbackLabel';
      expect(appShell, isNot(contains(retiredSimpleFallbackHelper)), reason: 'Q205 must not restore the simple controller fallback helper.');
      const retiredSimpleFallbackSource = "source: 'V172-Q153-mathlive-simple-key" '-test-fallback';
      expect(appShell, isNot(contains(retiredSimpleFallbackSource)));
      expect(appShell, contains('_mathLiveMainEditor.sendKeyFast'));
      expect(appShell, contains('_mathLiveMainEditor.markKeyboardTap'));
      expect(appShell, contains('_mathLiveMainEditor.markBridgeSendResult'));
      final warmupPolicy = File('lib/features/mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart').readAsStringSync();
      expect(warmupPolicy, contains('MathLiveKeyboardBridgePolicy.commandForMainEditorLabel'));
    });

    test('Q152 verifier ignores user-side generated build folders while keeping release hygiene blockers', () {
      final verifier = File('tool/verify_mathlive_final_premium_package_freeze_v172_q152.mjs').readAsStringSync();
      expect(verifier, contains('userSideGeneratedPathPatterns'));
      expect(verifier, contains('userSideGeneratedPathsIgnoredForWorkspaceVerification'));
      expect(verifier, contains(r'/(^|\/)build(\/|$)/'));
      expect(verifier, contains(r'/(^|\/)\.dart_tool(\/|$)/'));
    });
  });
}
