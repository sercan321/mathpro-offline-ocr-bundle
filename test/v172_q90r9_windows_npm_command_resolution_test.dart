import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_windows_npm_command_resolution_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q90R9 Windows NPM Command Resolution Repair', () {
    test('records Windows npm.cmd resolution without changing editor surfaces', () {
      expect(MathLiveWindowsNpmCommandResolutionPolicy.phase, 'V172-Q90R9');
      expect(MathLiveWindowsNpmCommandResolutionPolicy.usesNpmCmdOnWindows, isTrue);
      expect(MathLiveWindowsNpmCommandResolutionPolicy.blockedStatus, 'BLOCKED_NPM_NOT_FOUND');
      expect(MathLiveWindowsNpmCommandResolutionPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveWindowsNpmCommandResolutionPolicy.physicalLegacyDeletionAllowed, isFalse);
      expect(MathLiveWindowsNpmCommandResolutionPolicy.remoteScriptsAllowed, isFalse);
      expect(MathLiveWindowsNpmCommandResolutionPolicy.mathLiveVirtualKeyboardEnabled, isFalse);
      expect(MathLiveWindowsNpmCommandResolutionPolicy.protectedUiSurfaceMutationAllowed, isFalse);
      expect(MathProPackageContract.q90r9WindowsNpmCommandResolutionRepairRule, contains('npm.cmd'));
    });

    test('installer script tries npm.cmd on Windows and reports blocked status', () {
      final source = File('tool/install_mathlive_runtime.mjs').readAsStringSync();
      expect(source, contains("process.platform === 'win32' ? ['npm.cmd', 'npm'] : ['npm']"));
      expect(source, contains('BLOCKED_NPM_NOT_FOUND'));
      expect(source, contains("runNpm(['init', '-y'], tempRoot)"));
      expect(source, contains("runNpm(['install'"));
      expect(source, isNot(contains("run('npm', ['init'")));
    });
  });
}
