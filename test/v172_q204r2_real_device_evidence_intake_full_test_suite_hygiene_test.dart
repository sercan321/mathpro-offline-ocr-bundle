import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_evidence_intake_full_test_suite_hygiene_policy.dart';

void main() {
  group('V172-Q204R2 real device evidence intake full test-suite hygiene', () {
    test('policy keeps real-device evidence gate honest', () {
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.phase, 'V172-Q204R2');
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.q204EvidenceGatePreserved, isTrue);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.q204r1AnalyzeTestHygienePreserved, isTrue);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.fullMathLiveTestSuiteMigratedToQ197Q203Architecture, isTrue);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.retiredDiagnosticMarkersRevived, isFalse);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.returningResultApiRevived, isFalse);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.visibleFallbackOverlayRevived, isFalse);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
    });

    test('all MathLive tests avoid stale shim implementation markers', () {
      final testFiles = Directory('test')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('_test.dart'));
      const markers = MathLiveRealDeviceEvidenceIntakeFullTestSuiteHygienePolicy.forbiddenStaleTestMarkers;
      for (final file in testFiles) {
        final source = file.readAsStringSync();
        for (final marker in markers) {
          expect(source, isNot(contains(marker)), reason: '${file.path} still has a stale MathLive test marker');
        }
      }
    });

    test('shim and active production files remain separated', () {
      final shim = File('lib/features/mathlive/mathlive_main_editor_surface.dart').readAsStringSync();
      final production = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      final html = File('assets/mathlive/main_editor_prod.html').readAsStringSync();

      expect(shim, contains('return MathLiveProductionEditorSurface('));
      expect(shim, contains('staleCompatibilityShimMayRenderFallback = false'));
      expect(production, contains('class MathLiveProductionEditorSurface extends StatefulWidget'));
      expect(production, contains('scheduleMathProKey'));
      expect(bridge, contains('q203ProductionContractsFrozen: true'));
      expect(html, contains('<math-field id="mathlive-field"'));
    });
  });
}
