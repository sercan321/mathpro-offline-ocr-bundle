import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_native_splash_hard_binding_repair_policy.dart';

void main() {
  group('V172-Q235R3 GAUSS native splash hard binding repair', () {
    test('policy records native splash ownership and direct AppShell boot', () {
      expect(GaussNativeSplashHardBindingRepairPolicy.phase, 'V172-Q235R3');
      expect(GaussNativeSplashHardBindingRepairPolicy.triggeredByRepeatedBlackSplashReport, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.userProvidedSplashReferenceUsed, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.newSplashImageGenerationUsed, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.nativeLaunchBackgroundUsesFullSplashArtwork, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.nativeLaunchBackgroundBlackOnlyRetired, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.android12TransparentIconRetired, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.android12UsesBrandedSplashIcon, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.q235R7Android12SmallIconEliminated, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.normalThemeUsesLaunchBackgroundDuringHandoff, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.flutterOverlayRemovedFromProductionHome, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.productionHomeBootsDirectlyToAppShell, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.calculatorStartupCannotWaitForSplashOverlayTimer, isTrue);
      expect(GaussNativeSplashHardBindingRepairPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.workspaceMutationAllowed, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.androidManifestMutationAllowed, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.flutterRunPassClaimedByAssistant, isFalse);
      expect(GaussNativeSplashHardBindingRepairPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
    });

    test('Android native resources show splash artwork instead of black-only startup', () {
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();
      final values = File('android/app/src/main/res/values/styles.xml').readAsStringSync();
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();

      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(launchBackground, contains('#02050A'));
      expect(values, contains('<item name="android:windowBackground">@drawable/launch_background</item>'));
      expect(valuesV31, contains('<item name="android:windowSplashScreenAnimatedIcon">@drawable/splash_transparent_icon</item>'));
      expect(valuesV31, contains('<item name="android:windowBackground">@drawable/launch_background</item>'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains("import 'gauss_splash_screen.dart';"));
    });

    test('native splash assets exist at expected safe sizes', () {
      expect(File('assets/branding/gauss_splash_screen.png').existsSync(), isTrue);
      expect(File('android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png').existsSync(), isTrue);
      expect(File('android/app/src/main/res/drawable/splash_transparent_icon.xml').existsSync(), isTrue);
      expect(_pngSize(File('android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png').readAsBytesSync()), const _PngSize(1080, 2400));
      final transparentIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      expect(transparentIcon, contains('android:width="1dp"'));
      expect(transparentIcon, contains('#00000000'));
    });
  });
}

class _PngSize {
  const _PngSize(this.width, this.height);
  final int width;
  final int height;

  @override
  bool operator ==(Object other) => other is _PngSize && other.width == width && other.height == height;

  @override
  int get hashCode => Object.hash(width, height);
}

_PngSize _pngSize(List<int> bytes) {
  expect(bytes.length, greaterThan(24));
  expect(bytes[0], 0x89);
  expect(bytes[1], 0x50);
  expect(bytes[2], 0x4E);
  expect(bytes[3], 0x47);
  return _PngSize(_readUint32(bytes, 16), _readUint32(bytes, 20));
}

int _readUint32(List<int> bytes, int offset) {
  return (bytes[offset] << 24) | (bytes[offset + 1] << 16) | (bytes[offset + 2] << 8) | bytes[offset + 3];
}
