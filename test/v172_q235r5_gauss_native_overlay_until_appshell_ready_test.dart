import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_native_overlay_until_appshell_ready_policy.dart';

void main() {
  group('V172-Q235R5 GAUSS native overlay until AppShell ready', () {
    test('policy records Q235R5 history and Q235R6 ready-signal successor', () {
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.phase, 'V172-Q235R5');
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.triggeredBySmallNormalDarkThenAppReport, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.userProvidedSplashReferenceUsed, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.newSplashImageGenerationUsed, isFalse);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.nativeOverlayAboveFlutterViewEnabled, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.nativeOverlayUsesFullSplashArtwork, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.nativeOverlayUsesFitCenter, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.releaseSignalSentAfterAppShellChildFrame, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.appShellMountedOnlyAfterFlutterPoster, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.flutterPosterVisibleDurationMs, 2400);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.flutterPosterUsesBoxFitContain, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.appShellStackedBehindSplash, isFalse);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.q235R6ReadySignalOnlyReleaseActive, isTrue);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussNativeOverlayUntilAppShellReadyPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
    });

    test('Q235R6 successor removes hard native splash timers from MainActivity', () {
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();

      expect(mainActivity, contains('nativeSplashChannelName = "mathpro/native_splash"'));
      expect(mainActivity, contains('installNativeSplashOverlay()'));
      expect(mainActivity, contains('addContentView(splash, params)'));
      expect(mainActivity, contains('R.drawable.gauss_splash_screen_native'));
      expect(mainActivity, contains('ImageView.ScaleType.FIT_CENTER'));
      expect(mainActivity, contains('"releaseNativeSplash"'));
      expect(mainActivity, contains('hideNativeSplashOverlay()'));
      expect(mainActivity, isNot(contains('minNativeSplashVisibleMs = 6500L')));
      expect(mainActivity, isNot(contains('maxNativeSplashVisibleMs = 14000L')));
      expect(mainActivity, isNot(contains('flutterReleaseRequested && elapsedMs >= minNativeSplashVisibleMs')));
      expect(mainActivity, isNot(contains('maybeHideNativeSplashOverlay')));
      expect(mainActivity, isNot(contains('postDelayed({ hideNativeSplashOverlay() }')));

      expect(splash, contains("MethodChannel('mathpro/native_splash')"));
      expect(splash, contains('invokeMethod<void>(\'releaseNativeSplash\')'));
      expect(splash, contains('_scheduleNativeSplashReleaseAfterChildFrame'));
      expect(splash, contains('addPostFrameCallback'));
      expect(splash, contains('Duration(milliseconds: 350)'));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, isNot(contains('Stack(')));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
    });
  });
}
