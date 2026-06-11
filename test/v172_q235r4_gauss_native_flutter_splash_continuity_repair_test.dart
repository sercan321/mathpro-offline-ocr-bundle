import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_native_flutter_splash_continuity_repair_policy.dart';

void main() {
  group('V172-Q235R4 GAUSS native-to-Flutter splash continuity repair', () {
    test('policy records native hard-binding plus Flutter poster bridge without fake PASS', () {
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.phase, 'V172-Q235R4');
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.triggeredByNativeSplashTooShortThenDarkFrameReport, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.nativeSplashHardBindingPreserved, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.userProvidedSplashReferenceUsed, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.newSplashImageGenerationUsed, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.flutterSplashPosterRestored, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.appShellMountedOnlyAfterPosterDuration, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.appShellStackedBehindSplash, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.platformViewCanCoverSplashWhileVisible, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.posterUsesBoxFitContain, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.posterUsesBoxFitCover, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.posterVisibleDurationMs, 2400);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.posterFadeOutDurationMs, 180);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.productionHomeUsesGaussStartupSplash, isTrue);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.productionHomeDirectAppShellOnly, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.workspaceMutationAllowed, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussNativeFlutterSplashContinuityRepairPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
    });

    test('app route bridges native splash to Flutter poster before AppShell mount', () {
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();

      expect(app, contains("import 'gauss_splash_screen.dart';"));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, contains('fadeOutDuration = Duration(milliseconds: 180)'));
      expect(splash, contains('if (!_visible)'));
      expect(splash, contains('return widget.child;'));
      expect(splash, isNot(contains('Stack(')));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
      expect(splash, contains('_SplashDecodeFallback'));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
    });
  });
}
