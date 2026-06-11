import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_main_keyboard_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q107 MathPro Keyboard to MathLive Main Bridge Hardening', () {
    test('records guard-only main keyboard bridge contract without keyboard or UI mutation', () {
      expect(MathLiveMainKeyboardBridgePolicy.phase, 'V172-Q107');
      expect(MathLiveMainKeyboardBridgePolicy.sourceBridgePhase, 'V172-Q85');
      expect(MathLiveMainKeyboardBridgePolicy.mountFlagPhase, 'V172-Q106');
      expect(MathLiveMainKeyboardBridgePolicy.q85LabBridgeIsSourceOfTruth, isTrue);
      expect(MathLiveMainKeyboardBridgePolicy.q106MountFlagRequired, isTrue);
      expect(MathLiveMainKeyboardBridgePolicy.q101LabSmokeEvidenceClosureRequired, isTrue);
      expect(MathLiveMainKeyboardBridgePolicy.officialRuntimeVerificationRequired, isTrue);
      expect(MathLiveMainKeyboardBridgePolicy.explicitInternalFlagRequired, isTrue);
      expect(MathLiveMainKeyboardBridgePolicy.mainWorkspaceBridgeImplementedInThisPackage, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.mainBridgeRuntimeBindingAllowedWithoutEvidence, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.keyboardMutationAllowed, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.moreMutationAllowed, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.longPressMutationAllowed, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.graphHistorySolutionUiMutationAllowed, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.legacyCursorDeletionAllowed, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveMainKeyboardBridgePolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathProPackageContract.q107MainKeyboardBridgeRule, contains('V172-Q107'));
    });

    test('keeps frozen Q85 mapping subset intact for main-bridge candidates', () {
      expect(MathLiveMainKeyboardBridgePolicy.validateFrozenMappingSubset(lastAnswer: '42'), isEmpty);
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('7').latex, '7');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('+').latex, '+');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('×').latex, r'\times ');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('÷').latex, r'\div ');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('=').latex, '=');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('□/□').latex, r'\frac{}{}');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('√□').latex, r'\sqrt{}');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('sin').latex, r'\sin\left(\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('log').latex, r'\log_{}\left(\right)');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('MORE').action, 'noOp');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('↵').action, 'evaluate');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('⌫').action, 'deleteBackward');
      expect(MathLiveKeyboardBridgePolicy.commandForLabel('C').action, 'clear');
    });

    test('blocks runtime main keyboard bridge until Q101 evidence, official runtime, and internal flag are real', () {
      final readiness = MathLiveMainKeyboardBridgePolicy.evaluateReadiness(
        q85BridgePresent: true,
        q106MountFlagPackageReady: true,
        q101LabSmokeEvidenceClosed: false,
        officialRuntimeVerified: false,
        explicitInternalFlagEnabled: false,
        protectedSurfacesUnchanged: true,
        keyboardUntouched: true,
        appShellUntouched: true,
        graphHistorySolutionUiUntouched: true,
        legacyRollbackAvailable: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        noFakeEvidence: true,
        frozenMappingSubsetPasses: true,
      );

      expect(readiness.status, 'MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED');
      expect(readiness.packageSideMainKeyboardBridgeReady, isTrue);
      expect(readiness.mayBindMainKeyboardBridgeAtRuntime, isFalse);
      expect(readiness.selectedDefaultEngine, 'legacyFlutterSlotEditor');
      expect(readiness.rollbackEngine, 'legacyFlutterSlotEditor');
      expect(readiness.mathLiveEnabledByDefault, isFalse);
      expect(readiness.maySwitchDefaultEditor, isFalse);
      expect(readiness.mayDeleteLegacyCursor, isFalse);
      expect(readiness.mayClaimCursorPass, isFalse);
      expect(readiness.mayMutateKeyboard, isFalse);
      expect(readiness.blockers, contains('Q101 Lab smoke evidence closure has not passed; Q107 runtime main bridge must remain blocked'));
    });

    test('builds main-bridge command envelopes without enabling runtime binding', () {
      final multiply = MathLiveMainKeyboardBridgePolicy.buildCommandEnvelope(label: '×');
      expect(multiply.phase, 'V172-Q107');
      expect(multiply.sourceBridgePhase, 'V172-Q85');
      expect(multiply.action, 'insertLatex');
      expect(multiply.latex, r'\times ');
      expect(multiply.runtimeBindingAllowed, isFalse);
      expect(multiply.mainWorkspaceBridgeImplementedInThisPackage, isFalse);
      expect(multiply.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(multiply.keyboardMutationAllowed, isFalse);
      expect(multiply.defaultEditorSwitchAllowed, isFalse);
      expect(multiply.legacyCursorDeletionAllowed, isFalse);

      final more = MathLiveMainKeyboardBridgePolicy.buildCommandEnvelope(label: 'MORE');
      expect(more.action, 'noOp');
      expect(more.acceptedByFrozenMapper, isFalse);
      expect(more.reason, contains('template tray'));
    });

    test('metadata and verifier contain Q107 hard guard markers without protected file markers', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final verifier = File('tool/verify_mathlive_main_keyboard_bridge.mjs').readAsStringSync();
      final audit = File('docs/audit/V172_Q107_MAIN_KEYBOARD_BRIDGE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q107_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      final keyConfig = File('lib/features/keyboard/key_config.dart').readAsStringSync();
      final mathKeyboard = File('lib/features/keyboard/math_keyboard.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();
      final graphCard = File('lib/features/graph/graph_card.dart').readAsStringSync();
      final historyPanel = File('lib/features/history/history_panel.dart').readAsStringSync();
      final solutionPanel = File('lib/features/solution/solution_steps_panel.dart').readAsStringSync();

      expect(manifest, contains('"q107MainKeyboardBridgePhase": "V172-Q107"'));
      expect(manifest, contains('"q107UsesQ85FrozenBridge": true'));
      expect(manifest, contains('"q107MainWorkspaceBridgeImplementedInThisPackage": false'));
      expect(manifest, contains('"q107MayMutateKeyboard": false'));
      expect(manifest, contains('"q107MaySwitchDefaultEditor": false'));
      expect(manifest, contains('"q107MayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q107 MathPro Keyboard → MathLive Main Bridge Hardening'));
      expect(verifier, contains('MATHLIVE_MAIN_KEYBOARD_BRIDGE_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED'));
      expect(audit, contains('Q107 hardens the MathPro Keyboard → MathLive main-bridge candidate'));
      expect(changed, contains('Protected files intentionally untouched'));
      expect(keyConfig, isNot(contains('V172-Q107')));
      expect(mathKeyboard, isNot(contains('V172-Q107')));
      expect(appShell, isNot(contains('V172-Q107')));
      expect(graphCard, isNot(contains('V172-Q107')));
      expect(historyPanel, isNot(contains('V172-Q107')));
      expect(solutionPanel, isNot(contains('V172-Q107')));
    });
  });
}
