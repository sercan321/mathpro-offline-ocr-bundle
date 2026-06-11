import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_no_black_startup_repair_policy.dart';

void main() {
  group('V172-Q215 GAUSS splash no-black-startup repair', () {
    test('policy remains a historical record and Q218 supersedes its first-frame gate approach', () {
      expect(GaussSplashNoBlackStartupRepairPolicy.phase, 'V172-Q215');
      expect(GaussSplashNoBlackStartupRepairPolicy.triggeredByUserSideBlackStartupReport, isTrue);
      expect(GaussSplashNoBlackStartupRepairPolicy.firstFlutterFrameDeferredUntilSplashImageReady, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.android12SystemSplashNoLongerTransparentOnly, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.supersededByQ218NonBlockingOverlay, isTrue);
      expect(GaussSplashNoBlackStartupRepairPolicy.supersededByQ219BootVisibilityDirectShell, isTrue);
      expect(GaussSplashNoBlackStartupRepairPolicy.suppliedSplashArtworkPreserved, isTrue);
      expect(GaussSplashNoBlackStartupRepairPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.splashArtworkRedrawAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.graphRuntimeBehaviorMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.historyMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.mathLiveProductionRuntimeMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.businessLogicMutationAllowed, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussSplashNoBlackStartupRepairPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
    });

    test('Q219 keeps first-frame deferral absent and builds AppShell inside bounded splash overlay' , () {
      final main = File('lib/main.dart').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();

      expect(main, isNot(contains('GaussSplashFirstFrameGate.deferFirstFrame();')));
      expect(main, isNot(contains('deferFirstFrame')));
      expect(splash, isNot(contains('class GaussSplashFirstFrameGate')));
      expect(splash, isNot(contains('deferFirstFrame()')));
      expect(splash, isNot(contains('allowFirstFrame()')));
      expect(app, contains("import 'gauss_splash_screen.dart';"));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, contains('_warmSplashImageForQualityOnly'));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
      expect(splash, contains('errorBuilder'));
      expect(splash, isNot(contains('CircularProgressIndicator')));
      expect(splash, isNot(contains('LinearProgressIndicator')));
    });

    test('Android 12+ system splash does not place the full GAUSS bitmap in the icon slot', () {
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      final systemIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();

      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(systemIcon, isNot(contains('@drawable/gauss_splash_screen_native')));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(valuesV31, isNot(contains('android:postSplashScreenTheme')));
      expect(valuesV31, isNot(contains('@mipmap/ic_launcher')));
    });
  });
}
