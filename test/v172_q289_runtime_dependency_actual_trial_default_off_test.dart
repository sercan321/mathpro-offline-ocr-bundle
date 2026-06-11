import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_actual_trial_default_off.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_runtime_dependency_actual_trial_default_off_policy.dart';

void main() {
  group('V172-Q289 Runtime Dependency Actual Trial Behind Default-Off Flag', () {
    test('keeps the dependency trial contract default-off while Q288 SHA is pending', () {
      final result = GaussRuntimeDependencyActualTrialDefaultOff.evaluate();

      expect(result.phase, GaussRuntimeDependencyActualTrialDefaultOffPolicy.phase);
      expect(result.sourcePhase, 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE');
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.dependencyTrialFlag, 'gauss.ppFormulaNetS.runtimeDependencyTrial.defaultOff');
      expect(result.decision, GaussRuntimeDependencyActualTrialDefaultOffDecision.trialContractReadyButDependencyBlocked);
      expect(result.dependencyTrialDefaultEnabled, isFalse);
      expect(result.dependencyAddedToPubspec, isFalse);
      expect(result.dependencyImportedInProductionCode, isFalse);
      expect(result.runtimeActivationAllowed, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.ocrPassClaimed, isFalse);
    });

    test('requires real artifact, ABI, memory, latency and smoke evidence before activation', () {
      expect(GaussRuntimeDependencyActualTrialDefaultOffPolicy.q288SourceIntakeRequired, isTrue);
      expect(GaussRuntimeDependencyActualTrialDefaultOffPolicy.q288ArtifactSha256StillPending, isTrue);
      expect(GaussRuntimeDependencyActualTrialDefaultOffPolicy.realDeviceRuntimeSmokeRequiredBeforeActivation, isTrue);
      expect(GaussRuntimeDependencyActualTrialDefaultOffPolicy.rollbackRequiredBeforeActivation, isTrue);
      expect(
        GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialPreconditions,
        contains('android-abi-and-runtime-package-must-be-proven-before-pubspec-mutation'),
      );
      expect(
        GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialPreconditions,
        contains('memory-and-latency-budget-must-be-proven-on-real-device-before-activation'),
      );
      expect(
        GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialPreconditions,
        contains('editable-mathlive-review-and-explicit-user-approval-remain-mandatory'),
      );
      expect(
        GaussRuntimeDependencyActualTrialDefaultOffPolicy.dependencyTrialPreconditions,
        contains('direct-solve-graph-solution-history-remain-blocked-for-camera-output'),
      );
    });

    test('does not mutate pubspec, protected runtime files, or bundle OCR binaries', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final changed = File('docs/audit/V172_Q289_CHANGED_FILES.md').readAsStringSync();

      for (final forbidden in GaussRuntimeDependencyActualTrialDefaultOffPolicy.blockedDependencyFamilies) {
        expect(pubspec, isNot(contains(forbidden)));
      }

      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(changed, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
      expect(changed, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
      expect(changed, isNot(contains('- `lib/features/mathlive/mathlive_production_editor_surface.dart`')));
      expect(changed, isNot(contains('- `lib/features/camera/gauss_camera_capture_shell.dart`')));
    });
  });
}
