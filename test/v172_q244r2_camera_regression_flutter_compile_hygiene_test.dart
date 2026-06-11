import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_regression_flutter_compile_hygiene_policy.dart';

void main() {
  group('V172-Q244R2 camera regression Flutter compile hygiene repair', () {
    test('policy records only compile hygiene repair scope', () {
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.phase, 'V172-Q244R2');
      expect(
        GaussCameraRegressionFlutterCompileHygienePolicy.repairsQ244R1WorkspaceMutedCompileError,
        isTrue,
      );
      expect(
        GaussCameraRegressionFlutterCompileHygienePolicy.workspaceCardIconButtonMutedReferencesRemoved,
        isTrue,
      );
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.ocrRuntimeAdded, isFalse);
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.keyboardMutationAllowed, isFalse);
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.mathLiveProductionMutationAllowed, isFalse);
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(GaussCameraRegressionFlutterCompileHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
    });

    test('workspace card icon button no longer references removed muted field', () {
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
      expect(workspace, contains("ValueKey('mathpro-workspace-camera-entry-button')"));
      expect(workspace, isNot(contains('this.muted = false')));
      expect(workspace, isNot(contains('final bool muted;')));
      expect(workspace, isNot(contains('muted ?')));
      expect(workspace, contains('Colors.white.withValues(alpha: 0.040)'));
      expect(workspace, contains('MathProColors.accent.withValues(alpha: 0.27)'));
    });

    test('stale ellipsis key remains removed from widget tests', () {
      final widgetTest = File('test/widget_test.dart').readAsStringSync();
      expect(widgetTest, contains("ValueKey('mathpro-workspace-camera-entry-button')"));
      expect(widgetTest, isNot(contains("ValueKey('mathpro-more-placeholder-button')")));
    });
  });
}
