import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_native_overlay_ready_signal_only_test_hygiene_policy.dart';

void main() {
  group('V172-Q235R6R1 GAUSS ready-signal-only test hygiene', () {
    test('policy records test-only repair without fake PASS claims', () {
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.phase, 'V172-Q235R6R1');
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.triggeredByUserSideFlutterTestFailure, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.staleQ235R5TestExpectationRepaired, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.q235R6ReadySignalOnlyRuntimePreserved, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.hardMaxNativeSplashTimeoutStillRemoved, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.hardMinNativeSplashTimeoutStillRemoved, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.releaseOnlyOnFlutterReadySignalStillRequired, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.runtimeMainActivityChanged, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.splashArtworkChanged, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.keyboardMutationAllowed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyTestHygienePolicy.flutterTestPassClaimedByAssistant, isFalse);
    });

    test('Q235R5 regression test now asserts Q235R6 successor runtime', () {
      final q235r5Test = File('test/v172_q235r5_gauss_native_overlay_until_appshell_ready_test.dart').readAsStringSync();
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();

      expect(q235r5Test, contains('q235R6ReadySignalOnlyReleaseActive'));
      expect(q235r5Test, contains("isNot(contains('minNativeSplashVisibleMs = 6500L'))"));
      expect(q235r5Test, contains("isNot(contains('maxNativeSplashVisibleMs = 14000L'))"));
      expect(mainActivity, isNot(contains('minNativeSplashVisibleMs')));
      expect(mainActivity, isNot(contains('maxNativeSplashVisibleMs')));
      expect(mainActivity, isNot(contains('maybeHideNativeSplashOverlay')));
      expect(mainActivity, isNot(contains('flutterReleaseRequested')));
      expect(mainActivity, contains('"releaseNativeSplash"'));
      expect(mainActivity, contains('hideNativeSplashOverlay()'));
    });
  });
}
