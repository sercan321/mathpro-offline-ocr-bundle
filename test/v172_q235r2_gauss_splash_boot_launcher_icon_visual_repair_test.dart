import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_boot_and_launcher_icon_visual_repair_policy.dart';

void main() {
  group('V172-Q235R2 GAUSS splash boot + launcher icon visual repair', () {
    test('policy records black-splash and launcher zoom repair without fake PASS', () {
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.phase, 'V172-Q235R2');
      expect(
        GaussSplashBootAndLauncherIconVisualRepairPolicy.triggeredByUserSideBlackSplashAndBadLauncherIconReport,
        isTrue,
      );
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.userProvidedSplashReferenceUsed, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.userProvidedLauncherIconReferenceUsed, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.newSplashImageGenerationUsed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.newLauncherIconGenerationUsed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.splashShowsBeforeAppShellMount, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.appShellMountedAfterBoundedSplash, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.splashUsesBoxFitContain, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.splashUsesBoxFitCover, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.adaptiveIconXmlRouteRemoved, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.launcherUsesExactUserReferencePngRoute, isTrue);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.workspaceMutationAllowed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
      expect(GaussSplashBootAndLauncherIconVisualRepairPolicy.androidRealDeviceLauncherIconPassClaimedByAssistant, isFalse);
    });

    test('splash is no longer stacked over AppShell black layer during the splash period', () {
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, isNot(contains('Stack(')));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
      expect(splash, isNot(contains('deferFirstFrame')));
      expect(splash, contains('_SplashDecodeFallback'));
    });

    test('launcher icon uses exact PNG resources and disables adaptive XML zoom route', () {
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
    });
  });
}
