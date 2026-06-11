import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_startup_black_screen_repair_policy.dart';

void main() {
  group('V172-Q218 GAUSS splash startup black-screen repair', () {
    test('policy records the real-device black-screen repair without PASS claims', () {
      expect(GaussSplashStartupBlackScreenRepairPolicy.phase, 'V172-Q218');
      expect(GaussSplashStartupBlackScreenRepairPolicy.triggeredByRealDeviceBlackScreenReport, isTrue);
      expect(GaussSplashStartupBlackScreenRepairPolicy.firstFrameDeferralRemoved, isTrue);
      expect(GaussSplashStartupBlackScreenRepairPolicy.startupIndependentFromImageDecode, isTrue);
      expect(GaussSplashStartupBlackScreenRepairPolicy.nativeSplashUsesFullscreenBitmapInIconSlot, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.flutterOverlayIsBoundedByTimer, isTrue);
      expect(GaussSplashStartupBlackScreenRepairPolicy.supersededByQ219BootVisibilityDirectShell, isTrue);
      expect(GaussSplashStartupBlackScreenRepairPolicy.suppliedSplashArtworkPreserved, isTrue);
      expect(GaussSplashStartupBlackScreenRepairPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.splashArtworkRedrawAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.graphRuntimeBehaviorMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.historyMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.mathLiveProductionRuntimeMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.businessLogicMutationAllowed, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(GaussSplashStartupBlackScreenRepairPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
    });

    test('Q235 active boot route uses bounded zero-crop splash overlay or first-frame gate' , () {
      final main = File('lib/main.dart').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();

      expect(main, isNot(contains('deferFirstFrame')));
      expect(splash, isNot(contains('GaussSplashFirstFrameGate')));
      expect(splash, isNot(contains('deferFirstFrame')));
      expect(splash, isNot(contains('allowFirstFrame')));
      expect(app, contains("import 'gauss_splash_screen.dart';"));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, contains('Image.asset'));
      expect(splash, contains('errorBuilder'));
      expect(splash, contains('_warmSplashImageForQualityOnly'));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
    });

    test('Android native splash is dark/background-only and cannot crop the full GAUSS artwork into the icon slot', () {
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      final systemIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();

      expect(valuesV31, contains('windowSplashScreenBackground'));
      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(valuesV31, contains('@drawable/launch_background'));
      expect(systemIcon, isNot(contains('@drawable/gauss_splash_screen_native')));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(launchBackground, contains('#02050A'));
    });
  });
}
