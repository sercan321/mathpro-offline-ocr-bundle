import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_official_runtime_bundle_closure_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q100 official MathLive runtime bundle closure', () {
    test('Q100 blocks bundle closure when official runtime files or sha256 evidence are missing', () {
      final verdict = MathLiveOfficialRuntimeBundleClosurePolicy.evaluate(
        allRequiredRuntimeFilesPresent: false,
        runtimeManifestPresent: false,
        runtimeManifestJsonValid: false,
        runtimeManifestDeclaresNpmMathlive: false,
        runtimeManifestDeclaresRuntimeBundled: false,
        runtimeManifestDeclaresRemoteScriptsDisabled: true,
        runtimeManifestDeclaresVirtualKeyboardDisabled: true,
        runtimeManifestContainsSha256Evidence: false,
        runtimeFileHashesMatchManifest: false,
        packageJsonDeclaresMathlive: false,
        packageJsonHasVersion: false,
        q90r4RuntimeVerifierPassed: false,
        protectedSurfacesUnchanged: true,
        noMainEditorSwitchAttempted: true,
        noLegacyDeletionAttempted: true,
        packageHygieneClean: true,
      );

      expect(MathLiveOfficialRuntimeBundleClosurePolicy.phase, 'V172-Q100');
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.officialRuntimeBundleClosureGateProvided, isTrue);
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.createsFakeRuntimeFiles, isFalse);
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.downloadsRuntimeDuringVerification, isFalse);
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveOfficialRuntimeBundleClosurePolicy.legacyCursorDeletionAllowed, isFalse);
      expect(verdict.status, 'BLOCKED_MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE');
      expect(verdict.officialRuntimeBundleClosed, isFalse);
      expect(verdict.mayRunLabSmokeEvidence, isFalse);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
      expect(verdict.blockers, contains('official MathLive runtime file set is incomplete'));
      expect(verdict.blockers, contains('runtime_manifest.json is missing'));
      expect(verdict.blockers, contains('runtime_manifest.json is missing sha256 file evidence'));
    });

    test('Q100 bundle closure only unlocks Lab smoke evidence, not cursor PASS or editor switch', () {
      final verdict = MathLiveOfficialRuntimeBundleClosurePolicy.evaluate(
        allRequiredRuntimeFilesPresent: true,
        runtimeManifestPresent: true,
        runtimeManifestJsonValid: true,
        runtimeManifestDeclaresNpmMathlive: true,
        runtimeManifestDeclaresRuntimeBundled: true,
        runtimeManifestDeclaresRemoteScriptsDisabled: true,
        runtimeManifestDeclaresVirtualKeyboardDisabled: true,
        runtimeManifestContainsSha256Evidence: true,
        runtimeFileHashesMatchManifest: true,
        packageJsonDeclaresMathlive: true,
        packageJsonHasVersion: true,
        q90r4RuntimeVerifierPassed: true,
        protectedSurfacesUnchanged: true,
        noMainEditorSwitchAttempted: true,
        noLegacyDeletionAttempted: true,
        packageHygieneClean: true,
      );

      expect(verdict.status, 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED_FOR_SMOKE_EVIDENCE');
      expect(verdict.officialRuntimeBundleClosed, isTrue);
      expect(verdict.mayRunLabSmokeEvidence, isTrue);
      expect(verdict.mayClaimCursorPass, isFalse);
      expect(verdict.maySwitchMainEditor, isFalse);
      expect(verdict.mayEnableMathLiveByDefault, isFalse);
      expect(verdict.mayDeleteLegacyCursor, isFalse);
    });

    test('Q100 tool, metadata and audit files are present and keep protected surfaces locked', () {
      final tool = File('tool/verify_mathlive_official_runtime_bundle.mjs').readAsStringSync();
      final installer = File('tool/install_mathlive_runtime.mjs').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q100_OFFICIAL_RUNTIME_BUNDLE_CLOSURE_AUDIT_REPORT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q100_CHANGED_FILES_MANIFEST.md').readAsStringSync();

      expect(MathProPackageContract.readmeTitle, contains('V172-Q100 Official Runtime Bundle Closure'));
      expect(MathProPackageContract.q100OfficialRuntimeBundleClosureRule, contains('V172-Q100'));
      expect(tool, contains('V172-Q100'));
      expect(tool, contains('BLOCKED_MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE'));
      expect(tool, contains('maySwitchMainEditor: false'));
      expect(tool, contains('mayDeleteLegacyCursor: false'));
      expect(installer, contains('fileSha256'));
      expect(installer, contains('q100OfficialRuntimeBundleClosureRequired'));
      expect(manifest, contains('"q100OfficialRuntimeBundleClosurePhase": "V172-Q100"'));
      expect(manifest, contains('"q100MaySwitchMainEditor": false'));
      expect(manifest, contains('"q100MayDeleteLegacyCursor": false'));
      expect(manifest, contains('"q100ProtectedUiSurfaceMutationAllowed": false'));
      expect(readme, contains('V172-Q100 Official MathLive Runtime Bundle Closure'));
      expect(audit, contains('No fake official runtime files'));
      expect(changed, contains('Protected files intentionally untouched'));
    });
  });
}
