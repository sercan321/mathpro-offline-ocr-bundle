import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_lab_real_device_access_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R8 MathLive Lab Real Device Access Guard', () {
    test('records a direct Lab-only real-device access path without switching the main editor', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q90r8MathLiveLabRealDeviceAccessRule, contains('MathLive Lab Real Device Access'));
      expect(MathLiveLabRealDeviceAccessPolicy.phase, 'V172-Q90R8');
      expect(MathLiveLabRealDeviceAccessPolicy.directEntrypoint, 'lib/main_mathlive_lab.dart');
      expect(MathLiveLabRealDeviceAccessPolicy.runCommand, 'flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA');
      expect(MathLiveLabRealDeviceAccessPolicy.labRoute, '/mathlive-lab');
      expect(MathLiveLabRealDeviceAccessPolicy.labOnly, isTrue);
      expect(MathLiveLabRealDeviceAccessPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveLabRealDeviceAccessPolicy.mainEditorMountAllowed, isFalse);
      expect(MathLiveLabRealDeviceAccessPolicy.legacyEditorRemainsDefault, isTrue);
      expect(MathLiveLabRealDeviceAccessPolicy.legacyEditorRemainsRollback, isTrue);
      expect(MathLiveLabRealDeviceAccessPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveLabRealDeviceAccessPolicy.cursorPassClaimAllowedFromAccess, isFalse);
      expect(MathLiveLabRealDeviceAccessPolicy.photomathLevelClaimAllowedFromAccess, isFalse);
      expect(MathLiveLabRealDeviceAccessPolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveLabRealDeviceAccessPolicy.mathLiveVirtualKeyboardMustStayDisabled, isTrue);
    });

    test('blocks evidence review when real runtime or direct Lab access is missing', () {
      final verdict = MathLiveLabRealDeviceAccessPolicy.evaluate(
        runtimeInstallVerified: false,
        directEntrypointPresent: false,
        routeRegistered: false,
        labScreenImplemented: true,
        labCanRunOnRealDevice: false,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
      );
      expect(verdict.status, 'BLOCKED_MATHLIVE_LAB_REAL_DEVICE_ACCESS');
      expect(verdict.isBlocked, isTrue);
      expect(verdict.labAccessReady, isFalse);
      expect(verdict.q90r5EvidenceMayBeCaptured, isFalse);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, contains('Q90R4 runtime install verification has not passed'));
      expect(verdict.issues, contains('direct MathLive Lab entrypoint is missing'));
    });

    test('permits only Lab evidence capture readiness, not Q87 court or legacy deletion', () {
      final verdict = MathLiveLabRealDeviceAccessPolicy.evaluate(
        runtimeInstallVerified: true,
        directEntrypointPresent: true,
        routeRegistered: true,
        labScreenImplemented: true,
        labCanRunOnRealDevice: true,
        remoteScriptsDisabled: true,
        virtualKeyboardDisabled: true,
        mainEditorStillLegacy: true,
        protectedSurfacesUnchanged: true,
        fakeCursorPassClaimAbsent: true,
      );
      expect(verdict.status, 'MATHLIVE_LAB_REAL_DEVICE_ACCESS_READY_FOR_EVIDENCE_REVIEW');
      expect(verdict.labAccessReady, isTrue);
      expect(verdict.q90r5EvidenceMayBeCaptured, isTrue);
      expect(verdict.q87CursorCourtMayRun, isFalse);
      expect(verdict.mainEditorSwitchAllowed, isFalse);
      expect(verdict.physicalLegacyDeletionAllowed, isFalse);
      expect(verdict.issues, isEmpty);
    });

    test('ships route, direct entrypoint, manifest, README and audit markers without remote scripts', () {
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      final entrypoint = File('lib/main_mathlive_lab.dart').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      expect(app, contains('home: const MathProAppShell()'));
      expect(app, contains('MathLiveLabScreen.routeName'));
      expect(entrypoint, contains('MathLiveLabOnlyApp'));
      expect(entrypoint, contains('MathLiveLabScreen'));
      expect(entrypoint, contains('flutter run -t lib/main_mathlive_lab.dart -d 23106RN0DA'));
      expect(manifest, contains('"realDeviceLabAccessPhase": "V172-Q90R8"'));
      expect(manifest, contains('"realDeviceLabAccessMaySwitchMainEditor": false'));
      expect(manifest, contains('"realDeviceLabAccessMayDeleteLegacyCursor": false'));
      expect(readme, contains('V172-Q90R8'));
      expect(app, isNot(contains('http://')));
      expect(app, isNot(contains('https://')));
      expect(entrypoint, isNot(contains('http://')));
      expect(entrypoint, isNot(contains('https://')));
      expect(manifest, isNot(contains('http://')));
      expect(manifest, isNot(contains('https://')));
    });
  });
}
