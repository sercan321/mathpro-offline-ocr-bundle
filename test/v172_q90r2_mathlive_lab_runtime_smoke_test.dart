import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_bundle_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_runtime_smoke_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R2 MathLive Lab Real Runtime Smoke Test Gate', () {
    test('records a lab-only runtime smoke gate without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r2MathLiveRuntimeSmokeRule, contains('MathLive Lab Real Runtime Smoke Test Gate'));
      expect(MathLiveRuntimeSmokePolicy.phase, 'V172-Q90R2');
      expect(MathLiveRuntimeSmokePolicy.labRoute, '/mathlive-lab');
      expect(MathLiveRuntimeSmokePolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveRuntimeSmokePolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveRuntimeSmokePolicy.legacyEngineRemainsDefault, isTrue);
      expect(MathLiveRuntimeSmokePolicy.legacyEngineRemainsRollback, isTrue);
      expect(MathLiveRuntimeSmokePolicy.mathLiveVirtualKeyboardMustStayDisabled, isTrue);
      expect(MathLiveRuntimeSmokePolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveRuntimeSmokePolicy.officialRuntimeClaimAllowedWithoutSmoke, isFalse);
      expect(MathLiveRuntimeSmokePolicy.cursorPassClaimAllowedWithoutRealDeviceCourt, isFalse);
    });

    test('blocks smoke when the official runtime bundle is not ready', () {
      final bundle = MathLiveRuntimeBundlePolicy.evaluate(
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
      final smoke = MathLiveRuntimeSmokePolicy.evaluate(
        bundleVerdict: bundle,
        labScreenLoaded: true,
        localRuntimeScriptLoaded: false,
        mathfieldElementDefined: false,
        mathfieldInstanceMounted: false,
        bridgeCanInsertLatex: false,
        bridgeCanDeleteBackward: false,
        bridgeCanExportLatex: false,
        stateAdapterAcceptedExport: false,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        protectedSurfacesUnchanged: true,
        smokeCommandPasses: 0,
        smokeCommandTotal: MathLiveRuntimeSmokePolicy.minimumSmokeCommands,
      );
      expect(smoke.status, 'BLOCKED_MATHLIVE_LAB_RUNTIME_SMOKE');
      expect(smoke.isBlocked, isTrue);
      expect(smoke.labRuntimeSmokePassed, isFalse);
      expect(smoke.cursorCourtMayRun, isFalse);
      expect(smoke.mainEditorSwitchAllowed, isFalse);
      expect(smoke.diagnostic, 'q90r2-mathlive-lab-runtime-smoke-blocked-no-main-editor-switch');
      expect(smoke.issues, contains('official MathLive runtime bundle is not ready for lab'));
    });

    test('allows only cursor-court readiness after all isolated lab smoke evidence exists', () {
      final bundle = MathLiveRuntimeBundlePolicy.evaluate(
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
      final smoke = MathLiveRuntimeSmokePolicy.evaluate(
        bundleVerdict: bundle,
        labScreenLoaded: true,
        localRuntimeScriptLoaded: true,
        mathfieldElementDefined: true,
        mathfieldInstanceMounted: true,
        bridgeCanInsertLatex: true,
        bridgeCanDeleteBackward: true,
        bridgeCanExportLatex: true,
        stateAdapterAcceptedExport: true,
        virtualKeyboardDisabled: true,
        remoteScriptsDisabled: true,
        protectedSurfacesUnchanged: true,
        smokeCommandPasses: MathLiveRuntimeSmokePolicy.minimumSmokeCommands,
        smokeCommandTotal: MathLiveRuntimeSmokePolicy.minimumSmokeCommands,
      );
      expect(smoke.status, 'MATHLIVE_LAB_RUNTIME_SMOKE_READY_FOR_CURSOR_COURT');
      expect(smoke.readyForCursorCourt, isTrue);
      expect(smoke.labRuntimeSmokePassed, isTrue);
      expect(smoke.cursorCourtMayRun, isTrue);
      expect(smoke.mainEditorSwitchAllowed, isFalse);
      expect(smoke.issues, isEmpty);
    });

    test('lab assets expose only local runtime smoke hooks and no remote script dependency', () {
      final index = File('assets/mathlive/index.html').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(index, contains('vendor/mathlive/mathlive.min.js'));
      expect(index, contains('MathProOfficialMathLiveRuntimeProbe'));
      expect(bridge, contains("runtimeSmokePhase: 'V172-Q90R2'"));
      expect(bridge, contains('runRuntimeSmokeProbe'));
      expect(bridge, contains('tryMountOfficialMathLive'));
      expect(bridge, contains('math-field'));
      expect(manifest, contains('"runtimeSmokePhase": "V172-Q90R2"'));
      expect(manifest, contains('"runtimeSmokePassClaimed": false'));
      expect(bridge, isNot(contains('http://')));
      expect(bridge, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
