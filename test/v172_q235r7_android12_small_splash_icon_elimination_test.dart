import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_android12_small_splash_icon_elimination_policy.dart';

void main() {
  group('V172-Q235R7 Android 12 small splash icon elimination', () {
    test('policy records small-icon removal without fake PASS claims', () {
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.phase, 'V172-Q235R7');
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.triggeredBySmallThenLargeSplashReport, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.android12SystemIconSlotRendersSmallArtwork, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.android12BrandedIconSlotRemoved, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.android12TransparentIconRestored, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.fullSplashOwnedByNativeOverlay, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.nativeOverlayUsesFullSplashArtwork, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.readySignalOnlyReleasePreserved, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.noHardNativeSplashTimeoutPreserved, isTrue);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.splashArtworkChanged, isFalse);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussAndroid12SmallSplashIconEliminationPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
    });

    test('Android 12 system icon slot is transparent while native overlay owns full splash', () {
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      final transparentIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();

      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(transparentIcon, contains('android:width="1dp"'));
      expect(transparentIcon, contains('android:height="1dp"'));
      expect(transparentIcon, contains('#00000000'));
      expect(mainActivity, contains('R.drawable.gauss_splash_screen_native'));
      expect(mainActivity, contains('ImageView.ScaleType.FIT_CENTER'));
      expect(mainActivity, contains('"releaseNativeSplash"'));
      expect(mainActivity, isNot(contains('maxNativeSplashVisibleMs')));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
    });
  });
}
