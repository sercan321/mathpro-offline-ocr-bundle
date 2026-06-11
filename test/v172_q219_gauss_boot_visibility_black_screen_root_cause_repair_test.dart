import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_boot_visibility_black_screen_root_cause_repair_policy.dart';

void main() {
  group('V172-Q219 GAUSS boot visibility / black-screen root-cause repair', () {
    test('policy records direct AppShell boot proof without real-device PASS claims', () {
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.phase, 'V172-Q219');
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.triggeredByRealDeviceBlackScreenAfterQ218, isTrue);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.splashOverlayDisabledForBootProof, isTrue);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.appBootsDirectlyIntoMathProAppShell, isTrue);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.nativeSplashIsDarkBackgroundOnly, isTrue);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.android12IconSlotUsesFullscreenBitmap, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.startupDependsOnSplashAssetDecode, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.startupDependsOnPrecacheImage, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.firstFrameDeferralAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.suppliedSplashArtworkPreservedButInactive, isTrue);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.graphRuntimeBehaviorMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.historyMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.mathLiveCommandBridgeMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.solverMutationAllowed, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussBootVisibilityBlackScreenRootCauseRepairPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
    });

    test('MathProApp builds MathProAppShell inside the Q235 splash overlay', () {
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      final main = File('lib/main.dart').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();

      expect(main, contains('runApp(const MathProApp());'));
      expect(main, isNot(contains('deferFirstFrame')));
      expect(app, contains("import 'gauss_splash_screen.dart';"));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, isNot(contains('GaussSplashFirstFrameGate')));
      expect(splash, isNot(contains('deferFirstFrame')));
      expect(splash, isNot(contains('allowFirstFrame')));
    });

    test('Android native splash stays dark and cannot crop the full GAUSS bitmap in the icon slot', () {
      final values = File('android/app/src/main/res/values/styles.xml').readAsStringSync();
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      final systemIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

      expect(values, contains('@drawable/launch_background'));
      expect(valuesV31, contains('windowSplashScreenBackground'));
      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(valuesV31, contains('@drawable/launch_background'));
      expect(valuesV31, isNot(contains('android:postSplashScreenTheme')));
      expect(systemIcon, isNot(contains('@drawable/gauss_splash_screen_native')));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(launchBackground, contains('#02050A'));
      expect(manifest, contains('io.flutter.embedding.android.NormalTheme'));
    });
  });
}
