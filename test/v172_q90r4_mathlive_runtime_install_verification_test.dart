import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_install_verification_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R4 MathLive Runtime Install Verification', () {
    test('records a lab-only verification gate without enabling the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r4MathLiveRuntimeInstallVerificationRule, contains('MathLive Runtime Install Verification'));
      expect(MathLiveRuntimeInstallVerificationPolicy.phase, 'V172-Q90R4');
      expect(MathLiveRuntimeInstallVerificationPolicy.verifierScript, 'tool/verify_mathlive_runtime.mjs');
      expect(MathLiveRuntimeInstallVerificationPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveRuntimeInstallVerificationPolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveRuntimeInstallVerificationPolicy.legacyEngineRemainsDefault, isTrue);
      expect(MathLiveRuntimeInstallVerificationPolicy.legacyEngineRemainsRollback, isTrue);
      expect(MathLiveRuntimeInstallVerificationPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveRuntimeInstallVerificationPolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveRuntimeInstallVerificationPolicy.mathLiveVirtualKeyboardMustStayDisabled, isTrue);
      expect(MathLiveRuntimeInstallVerificationPolicy.cursorPassClaimAllowedFromInstallVerification, isFalse);
    });

    test('blocks verification when installer evidence is incomplete', () {
      final verdict = MathLiveRuntimeInstallVerificationPolicy.evaluate(
        mathliveMinJsPresent: false,
        mathliveMinJsBytes: 0,
        fontsCssPresent: false,
        staticCssPresent: false,
        licensePresent: false,
        packageJsonPresent: false,
        packageJsonNameIsMathlive: false,
        packageJsonVersionPresent: false,
        runtimeManifestPresent: false,
        runtimeManifestDeclaresNpmSource: false,
        runtimeManifestDeclaresRuntimeBundled: false,
        runtimeManifestDisablesRemoteScripts: false,
        runtimeManifestDisablesVirtualKeyboard: false,
        projectManifestForbidsRemoteScripts: true,
        protectedSurfacesUnchanged: true,
      );
      expect(verdict.status, 'BLOCKED_MATHLIVE_RUNTIME_INSTALL_VERIFICATION');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.installVerified, isFalse);
      expect(verdict.q90r2SmokeMayRun, isFalse);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.issues, contains('mathlive.min.js is missing'));
      expect(verdict.diagnostic, 'q90r4-runtime-install-blocked-no-fake-runtime-claim');
    });

    test('allows only Q90R2 lab smoke after complete local runtime evidence', () {
      final verdict = MathLiveRuntimeInstallVerificationPolicy.evaluate(
        mathliveMinJsPresent: true,
        mathliveMinJsBytes: 150000,
        fontsCssPresent: true,
        staticCssPresent: true,
        licensePresent: true,
        packageJsonPresent: true,
        packageJsonNameIsMathlive: true,
        packageJsonVersionPresent: true,
        runtimeManifestPresent: true,
        runtimeManifestDeclaresNpmSource: true,
        runtimeManifestDeclaresRuntimeBundled: true,
        runtimeManifestDisablesRemoteScripts: true,
        runtimeManifestDisablesVirtualKeyboard: true,
        projectManifestForbidsRemoteScripts: true,
        protectedSurfacesUnchanged: true,
      );
      expect(verdict.status, 'MATHLIVE_RUNTIME_INSTALL_VERIFIED_FOR_LAB_SMOKE');
      expect(verdict.installVerified, isTrue);
      expect(verdict.q90r2SmokeMayRun, isTrue);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.issues, isEmpty);
    });

    test('ships a Windows-safe verifier script and manifest markers without remote scripts', () {
      final verifier = File(MathLiveRuntimeInstallVerificationPolicy.verifierScript).readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(verifier, contains("phase: 'V172-Q90R4'"));
      expect(verifier, contains('fileURLToPath(import.meta.url)'));
      expect(verifier, contains('runtime_manifest.json'));
      expect(verifier, contains('mainEditorSwitchAllowed: false'));
      expect(verifier, isNot(contains('http://')));
      expect(verifier, isNot(contains('https://')));
      expect(manifest, contains('"runtimeInstallVerificationPhase": "V172-Q90R4"'));
      expect(manifest, contains('"runtimeInstallVerified": false'));
      expect(manifest, contains('"runtimeInstallVerificationRequiredBeforeSmoke": true'));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
