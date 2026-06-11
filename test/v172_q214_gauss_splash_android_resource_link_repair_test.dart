import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_android_resource_link_repair_policy.dart';

void main() {
  group('V172-Q214 GAUSS splash Android resource-link repair', () {
    test('policy records the narrow Android resource-link repair without runtime claims', () {
      expect(GaussSplashAndroidResourceLinkRepairPolicy.phase, 'V172-Q214');
      expect(GaussSplashAndroidResourceLinkRepairPolicy.triggeredByUserSideFlutterRunLog, isTrue);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.failingTask, ':app:processDebugResources');
      expect(
        GaussSplashAndroidResourceLinkRepairPolicy.removedUnavailableFrameworkAttribute,
        'android:postSplashScreenTheme',
      );
      expect(GaussSplashAndroidResourceLinkRepairPolicy.androidValuesV31CompileSafe, isTrue);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.q212SplashArtworkPreserved, isTrue);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.splashArtworkRedrawAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.graphRuntimeBehaviorMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.historyMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.mathLiveProductionRuntimeMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.businessLogicMutationAllowed, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussSplashAndroidResourceLinkRepairPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
    });

    test('Android 12+ splash style does not reference unavailable android:postSplashScreenTheme', () {
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      expect(valuesV31, contains('windowSplashScreenBackground'));
      expect(valuesV31, contains('windowSplashScreenAnimatedIcon'));
      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(valuesV31, contains('@drawable/launch_background'));
      expect(valuesV31, isNot(contains('android:postSplashScreenTheme')));
    });

    test('Q218 keeps native splash compile-safe and avoids Android icon-slot bitmap crop', () {
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();
      final systemIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();

      expect(File('assets/branding/gauss_splash_screen.png').existsSync(), isTrue);
      expect(File('android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png').existsSync(), isTrue);
      expect(File('assets/branding/gauss_app_icon_1024.png').existsSync(), isTrue);
      expect(launchBackground, contains('#02050A'));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(systemIcon, isNot(contains('@drawable/gauss_splash_screen_native')));
      expect(manifest, contains('android:icon="@mipmap/ic_launcher"'));
      expect(manifest, contains('android:roundIcon="@mipmap/ic_launcher_round"'));
      expect(pubspec, contains('assets/branding/gauss_splash_screen.png'));
    });
  });
}
