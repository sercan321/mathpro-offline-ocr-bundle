import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_tap_latency_cadence_policy.dart';

void main() {
  group('V172-Q277R3 Camera/OCR runtime premium regression tap latency cadence', () {
    test('records the real-device tap-to-workspace latency micro repair without OCR runtime claims', () {
      expect(
        MathLiveProductionTapLatencyCadencePolicy.phase,
        'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE',
      );
      expect(
        MathLiveProductionTapLatencyCadencePolicy.sourcePhase,
        'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE',
      );
      expect(MathLiveProductionTapLatencyCadencePolicy.userReportedTapToWorkspaceLatency, isTrue);
      expect(MathLiveProductionTapLatencyCadencePolicy.repairModeIsRealDeviceLatencyMicroRepair, isTrue);

      expect(MathLiveProductionTapLatencyCadencePolicy.keyboardLayoutChanged, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.moreTemplateTrayChanged, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.longPressListsChanged, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.graphSolutionHistoryRuntimeChanged, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.cameraOcrReviewSafetyChanged, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.mathLiveProductionRouteChanged, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.legacyFlutterCursorRouteReintroduced, isFalse);

      expect(MathLiveProductionTapLatencyCadencePolicy.commandTailMayAwaitFlutterStateEcho, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.emitOptimisticStateBeforeJsDispatch, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.awaitPostDispatchFlutterStateEcho, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.redundantDartStateRefreshAfterEveryKeyDispatch, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.webViewJavaScriptDispatchRemainsSerial, isTrue);
      expect(MathLiveProductionTapLatencyCadencePolicy.nativeMathLiveRemainsRendererAuthority, isTrue);

      expect(MathLiveProductionTapLatencyCadencePolicy.realOcrRuntimeAdded, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.paddleRuntimeAdded, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.paddleOcrDependencyAdded, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.realImageToLatexInferenceExecuted, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.tapLatencyPassClaimed, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.ocrPassClaimed, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.cameraOcrRuntimePassClaimed, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.premiumFinalPassClaimed, isFalse);
      expect(MathLiveProductionTapLatencyCadencePolicy.releasePassClaimed, isFalse);
    });

    test('keeps the serial JS command tail from awaiting Flutter state echo or redundant refresh', () {
      final source = File('lib/features/mathlive/mathlive_production_editor_surface.dart').readAsStringSync();

      expect(source, contains('q277r3-dart-dispatch-scheduled-fast-cadence'));
      expect(source, contains('q277r3-dart-command-tail-does-not-await-flutter-state-echo'));
      expect(source, contains('MathLiveProductionTapLatencyCadencePolicy.emitOptimisticStateBeforeJsDispatch'));
      expect(source, contains('MathLiveProductionTapLatencyCadencePolicy.redundantDartStateRefreshAfterEveryKeyDispatch'));
      // Q382R24R1: Q277R3's historical exact-string expectation for an
      // unconditional synthetic Dart echo is stale after Q382R24. The production
      // surface now keeps the Q277R3 no-await contract, but suppresses the echo
      // behind an explicit Q382R24 policy guard on the hot keyboard path.
      expect(source, contains('MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands'));
      expect(source, contains('if (!MathLiveKeyboardLatencyClosureQ382R24Policy.syntheticDartEchoSuppressedForKeyboardCommands)'));
      expect(source, contains('q382r24-fire-and-forget-js-dispatch'));
      expect(source, isNot(contains('await _emitState(\n          reason: _lastProductionCommandTrace,\n          lastCommandLabel: label,\n        );\n        if (epoch == _productionCommandEpoch || priorityReset)')));
      expect(source, isNot(contains("unawaited(_refreshProductionStateDeferred(reason: 'q200-production-command-refresh-")));
    });

    test('documents the single protected production surface change and keeps other red lines out', () {
      final changed = File('docs/audit/V172_Q277R3_CHANGED_FILES.md').readAsStringSync();
      final modified = changed.split('## Modified').last.split('## Explicitly Not Modified').first;
      final explicitlyNotModified = changed.split('## Explicitly Not Modified').last;

      expect(modified, contains('lib/features/mathlive/mathlive_production_editor_surface.dart'));
      expect(modified, contains('protected surface changed intentionally'));
      expect(modified, isNot(contains('- `lib/features/keyboard/key_config.dart`')));
      expect(modified, isNot(contains('- `lib/features/keyboard/math_keyboard.dart`')));
      expect(modified, isNot(contains('- `lib/features/keyboard/long_press_popup.dart`')));
      expect(modified, isNot(contains('- `lib/features/workspace/template_tray.dart`')));
      expect(modified, isNot(contains('- `assets/mathlive/mathlive_prod_bridge.js`')));
      expect(modified, isNot(contains('- `lib/features/graph/graph_card.dart`')));
      expect(modified, isNot(contains('- `lib/features/solution/solution_steps_panel.dart`')));
      expect(modified, isNot(contains('- `lib/features/history/history_panel.dart`')));
      expect(modified, isNot(contains('- `lib/app/app_shell.dart`')));
      expect(modified, isNot(contains('- `android/app/src/main/AndroidManifest.xml`')));
      expect(explicitlyNotModified, contains('- `assets/mathlive/mathlive_prod_bridge.js`'));
      expect(explicitlyNotModified, contains('- Graph/Solution/History UI/runtime files.'));
    });
  });
}
