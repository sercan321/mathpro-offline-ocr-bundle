import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_bundle_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R1 Official MathLive Runtime Bundle Intake Guard', () {
    test('records an intake guard without faking a bundled runtime', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r1OfficialMathLiveRuntimeBundleIntakeRule, contains('Official MathLive Runtime Bundle Intake Guard'));
      expect(MathLiveRuntimeBundlePolicy.phase, 'V172-Q90R1');
      expect(MathLiveRuntimeBundlePolicy.runtimeBundleIntakeGuardImplemented, isTrue);
      expect(MathLiveRuntimeBundlePolicy.installerScriptProvided, isTrue);
      expect(MathLiveRuntimeBundlePolicy.officialRuntimeBundledByAssistant, isFalse);
      expect(MathLiveRuntimeBundlePolicy.officialRuntimeClaimAllowedWithoutFiles, isFalse);
      expect(MathLiveRuntimeBundlePolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveRuntimeBundlePolicy.cdnDependencyAllowed, isFalse);
      expect(MathLiveRuntimeBundlePolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveRuntimeBundlePolicy.mainEditorSwitchAllowed, isFalse);
    });

    test('blocks official runtime claim while vendor files are absent', () {
      final verdict = MathLiveRuntimeBundlePolicy.evaluate(
        mathliveMinJsPresent: false,
        fontsCssPresent: false,
        staticCssPresent: false,
        licensePresent: false,
        packageJsonPresent: false,
        runtimeManifestPresent: false,
        manifestDeclaresNpmSource: false,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        protectedSurfacesUnchanged: true,
      );
      expect(verdict.status, 'BLOCKED_OFFICIAL_RUNTIME_NOT_BUNDLED');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.officialRuntimeBundled, isFalse);
      expect(verdict.labRuntimeMayBeExercised, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.diagnostic, 'q90r1-official-mathlive-runtime-bundle-blocked-no-fake-runtime-claim');
      expect(verdict.issues, contains('mathlive.min.js is not present in the local vendor directory'));
    });

    test('would allow lab runtime only after all local vendor evidence exists', () {
      final verdict = MathLiveRuntimeBundlePolicy.evaluate(
        mathliveMinJsPresent: true,
        fontsCssPresent: true,
        staticCssPresent: true,
        licensePresent: true,
        packageJsonPresent: true,
        runtimeManifestPresent: true,
        manifestDeclaresNpmSource: true,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        protectedSurfacesUnchanged: true,
      );
      expect(verdict.status, 'OFFICIAL_RUNTIME_BUNDLE_READY_FOR_LAB');
      expect(verdict.readyForLab, isTrue);
      expect(verdict.officialRuntimeBundled, isTrue);
      expect(verdict.labRuntimeMayBeExercised, isTrue);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.issues, isEmpty);
    });

    test('declares installer and manifest markers without remote scripts', () {
      final installer = File(MathLiveRuntimeBundlePolicy.installerScript).readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      expect(installer, contains('npm'));
      expect(installer, contains('mathlive'));
      expect(manifest, contains('"runtimeBundlePhase": "V172-Q90R1"'));
      expect(manifest, contains('"officialRuntimeInstallerScriptProvided": true'));
      expect(manifest, contains('"officialMathLiveRuntimeBundled": false'));
      expect(bridge, contains("runtimeBundlePhase: 'V172-Q90R1'"));
      expect(bridge, contains('officialRuntimeInstallerScriptProvided: true'));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
