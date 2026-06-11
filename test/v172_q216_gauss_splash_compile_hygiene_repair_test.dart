import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_compile_hygiene_repair_policy.dart';

void main() {
  group('V172-Q216 GAUSS splash compile hygiene repair', () {
    test('policy records only the historical narrow analyze/test compile repair', () {
      expect(GaussSplashCompileHygieneRepairPolicy.phase, 'V172-Q216');
      expect(GaussSplashCompileHygieneRepairPolicy.triggeredByUserSideAnalyzeAndTestLog, isTrue);
      expect(GaussSplashCompileHygieneRepairPolicy.futureAnyConstructorRemoved, isTrue);
      expect(GaussSplashCompileHygieneRepairPolicy.runAppMaterialImportRestored, isTrue);
      expect(GaussSplashCompileHygieneRepairPolicy.suppliedSplashArtworkPreserved, isTrue);
      expect(GaussSplashCompileHygieneRepairPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.splashArtworkRedrawAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.graphRuntimeBehaviorMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.historyMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.mathLiveProductionRuntimeMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.businessLogicMutationAllowed, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(GaussSplashCompileHygieneRepairPolicy.androidRealDevicePassClaimedByAssistant, isFalse);
    });

    test('main imports Flutter material and no longer defers the first frame', () {
      final main = File('lib/main.dart').readAsStringSync();
      expect(main, contains("import 'package:flutter/material.dart';"));
      expect(main, isNot(contains("import 'app/gauss_splash_screen.dart';")));
      expect(main, isNot(contains('GaussSplashFirstFrameGate.deferFirstFrame();')));
      expect(main, contains('runApp(const MathProApp());'));
    });

    test('splash code has no Future.any and active boot route uses bounded zero-crop splash overlay' , () {
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      expect(splash, isNot(contains('Future<void>.any')));
      expect(splash, isNot(contains('Future.any')));
      expect(splash, isNot(contains('deferFirstFrame')));
      expect(splash, isNot(contains('allowFirstFrame')));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, contains('_warmSplashImageForQualityOnly'));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
    });
  });
}
