import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';
import 'package:mathpro_flutter_phase17/logic/real_device_ux_readiness_gate.dart';

void main() {
  group('V155 final regression evidence ledger and release hygiene closure', () {
    test('active package metadata has advanced while older V155/V154 metadata is stale', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(MathProPackageContract.phase, startsWith('V'));
      expect(pubspec, contains('version: ${MathProPackageContract.version}'));
      expect(MathProPackageContract.auditTitle, isNotEmpty);
      expect(MathProPackageContract.nextPhase, startsWith('V'));
      expect(MathProPackageContract.staleVersionMarkers, contains('version: 0.155.0+155'));
      expect(MathProPackageContract.staleVersionMarkers, contains('version: 0.154.0+154'));
    });

    test('real-device gate requires final regression and hygiene evidence', () {
      expect(RealDeviceUxReadinessGate.version, contains('real-device-ux-readiness-gate'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('flutter analyze log'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('flutter test log'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('flutter run -d 23106RN0DA launch evidence'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V155 final flutter analyze/test log'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V155 zip hygiene verification'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V155 protected-surface unchanged verification'));
      expect(RealDeviceUxReadinessGate.requiredEvidenceItems, contains('V155 release verdict with no fake PASS wording'));
    });

    test('V155 audit docs and manifest are present and honest about no fake PASS', () {
      final audit = File('docs/audit/V155_FINAL_REGRESSION_EVIDENCE_LEDGER_RELEASE_HYGIENE_AUDIT.md').readAsStringSync();
      final manifest = File('docs/audit/V155_CHANGED_FILES_MANIFEST.md').readAsStringSync();
      expect(audit, contains('does not claim physical-device PASS'));
      expect(audit, contains('Static package checks alone are not PASS'));
      expect(audit, contains('Manual phone issues override automated tests'));
      expect(manifest, contains('Protected Files Intentionally Not Changed'));
      expect(manifest, contains('lib/features/keyboard/key_config.dart'));
    });

    test('static readiness still cannot grant PASS without attached phone evidence', () {
      final verdict = RealDeviceUxReadinessGate.evaluateStaticReadiness();
      expect(verdict.passClaimAllowed, isFalse);
      expect(verdict.warnings.join('\n'), contains('Static readiness is not a real-device PASS'));
    });
  });
}
