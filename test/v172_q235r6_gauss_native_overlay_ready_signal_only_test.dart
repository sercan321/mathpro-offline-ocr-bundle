import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_native_overlay_ready_signal_only_policy.dart';

void main() {
  group('V172-Q235R6 GAUSS native overlay ready-signal-only release', () {
    test('policy removes hard native splash timeout and avoids fake PASS claims', () {
      expect(GaussNativeOverlayReadySignalOnlyPolicy.phase, 'V172-Q235R6');
      expect(GaussNativeOverlayReadySignalOnlyPolicy.triggeredByNoFixedSplashDurationRequest, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.userProvidedSplashReferenceUsed, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.newSplashImageGenerationUsed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.nativeOverlayAboveFlutterViewEnabled, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.nativeOverlayUsesFullSplashArtwork, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.nativeOverlayUsesFitCenter, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.hardMaxNativeSplashTimeoutRemoved, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.hardMinNativeSplashTimeoutRemoved, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.releaseOnlyOnFlutterReadySignal, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.releaseSignalSentAfterAppShellChildFrame, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.splashCanRemainAsLongAsStartupNeeds, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.nativeOverlayHasNoTimeCap, isTrue);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussNativeOverlayReadySignalOnlyPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
    });

    test('MainActivity hides native splash only after Flutter release signal', () {
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();

      expect(mainActivity, contains('nativeSplashChannelName = "mathpro/native_splash"'));
      expect(mainActivity, contains('installNativeSplashOverlay()'));
      expect(mainActivity, contains('addContentView(splash, params)'));
      expect(mainActivity, contains('R.drawable.gauss_splash_screen_native'));
      expect(mainActivity, contains('ImageView.ScaleType.FIT_CENTER'));
      expect(mainActivity, contains('"releaseNativeSplash"'));
      expect(mainActivity, contains('hideNativeSplashOverlay()'));
      expect(mainActivity, isNot(contains('maxNativeSplashVisibleMs')));
      expect(mainActivity, isNot(contains('minNativeSplashVisibleMs')));
      expect(mainActivity, isNot(contains('postDelayed({ hideNativeSplashOverlay() }')));
      expect(mainActivity, isNot(contains('postDelayed({ maybeHideNativeSplashOverlay() }')));
      expect(mainActivity, isNot(contains('maybeHideNativeSplashOverlay')));
      expect(mainActivity, isNot(contains('flutterReleaseRequested')));

      expect(splash, contains("MethodChannel('mathpro/native_splash')"));
      expect(splash, contains("invokeMethod<void>('releaseNativeSplash')"));
      expect(splash, contains('_scheduleNativeSplashReleaseAfterChildFrame'));
      expect(splash, contains('addPostFrameCallback'));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, isNot(contains('Stack(')));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
    });
  });
}
