import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/logic/real_device_ux_readiness_gate.dart';

void main() {
  group('V167 stale metadata closure repair', () {
    test('active package metadata has advanced while preserving closure wording compatibility', () {
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(MathProPackageContract.version, isNotEmpty);
      expect(MathProPackageContract.auditTitle, contains('Closure'));

      final pubspec = File('pubspec.yaml').readAsStringSync();
      final readmeHead = File('README.md').readAsStringSync().split('\n').take(8).join('\n');
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(readmeHead, contains(MathProPackageContract.readmeTitle));
    });

    test('real-device QA gate remains forward-compatible and still references V154/V155 evidence requirements', () {
      expect(RealDeviceUxReadinessGate.version, contains('real-device'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V154 critical-key surface checklist'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V155 final flutter analyze/test log'));
      expect(RealDeviceUxReadinessGate.evaluateStaticReadiness().passClaimAllowed, isFalse);
    });
  });
}
