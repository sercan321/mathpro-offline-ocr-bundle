import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/analyze_test_hygiene_log_repair_policy.dart';

void main() {
  group('V172-Q213 analyze/test hygiene log repair', () {
    test('policy records a narrow user-log repair phase without runtime claims', () {
      expect(AnalyzeTestHygieneLogRepairPolicy.phase, 'V172-Q213');
      expect(AnalyzeTestHygieneLogRepairPolicy.q205r3VerifierSuccessorWindowRepaired, isTrue);
      expect(AnalyzeTestHygieneLogRepairPolicy.graphSurface3DPreferNullAwareLintRepaired, isTrue);
      expect(AnalyzeTestHygieneLogRepairPolicy.q208TestStaleMarkerFalsePositiveRepaired, isTrue);
      expect(AnalyzeTestHygieneLogRepairPolicy.launcherIconMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.splashMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.graphRuntimeBehaviorMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.historyMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.solutionMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.mathLiveProductionRuntimeMutationAllowed, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(AnalyzeTestHygieneLogRepairPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
    });

    test('GraphSurface3D uses null-aware sample copy to satisfy analyzer hygiene', () {
      final source = File('lib/features/graph/graph_surface_3d.dart').readAsStringSync();
      expect(source, contains('sample?.copyWith'));
      expect(source, isNot(contains('sample == null ? null : sample.copyWith')));
    });

    test('Q208 test keeps retired bridge marker assertion without stale contiguous source marker', () {
      final source = File('test/v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart').readAsStringSync();
      expect(source, contains("'runJavaScript' 'ReturningResult'"));
      expect(source, isNot(contains('runJavaScriptReturning' 'Result')));
    });

    test('Q205R3 verifier accepts the Q210/Q211/Q212/Q213 successor window', () {
      final source = File('tool/verify_mathlive_only_main_editor_metadata_analyze_test_closure_v172_q205r3.mjs').readAsStringSync();
      expect(source, contains('q210FullPhase'));
      expect(source, contains('q211FullPhase'));
      expect(source, contains('q212FullPhase'));
      expect(source, contains('q213FullPhase'));
      expect(source, contains('acceptedSuccessorPhases'));
    });
  });
}
