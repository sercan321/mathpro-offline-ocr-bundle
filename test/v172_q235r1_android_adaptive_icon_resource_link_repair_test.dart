import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_android_adaptive_icon_resource_link_repair_policy.dart';

void main() {
  group('V172-Q235R1 Android adaptive icon resource-link repair', () {
    test('policy records exact AAPT repair and Q235R2 visual successor', () {
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.phase, 'V172-Q235R1');
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.triggeredByUserSideAaptFailure, isTrue);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.invalidDrawableNodpiReferenceRemoved, isTrue);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.q235R2AdaptiveIconXmlRouteRemoved, isTrue);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.q235R2ExactPngLauncherRouteActive, isTrue);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.splashFitBehaviorChanged, isFalse);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.userProvidedSplashReferenceStillUsed, isTrue);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.boxFitContainPreserved, isTrue);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.workspaceMutationAllowed, isFalse);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashAndroidAdaptiveIconResourceLinkRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
    });

    test('Q235R2 removes adaptive XML route and keeps exact PNG launcher resources', () {
      expect(File('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml').existsSync(), isFalse);
      expect(File('android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml').existsSync(), isFalse);
      for (final path in <String>[
        'assets/branding/gauss_app_icon_1024.png',
        'android/app/src/main/res/mipmap-mdpi/ic_launcher.png',
        'android/app/src/main/res/mipmap-hdpi/ic_launcher.png',
        'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png',
        'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
        'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
      ]) {
        expect(File(path).existsSync(), isTrue, reason: 'missing launcher PNG: $path');
      }

      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
    });
  });
}
