import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_pixel_perfect_safe_fit_policy.dart';

void main() {
  group('V172-Q235 GAUSS splash pixel-perfect safe fit', () {
    test('policy records splash-only safe-fit integration without fake PASS claims', () {
      expect(GaussSplashPixelPerfectSafeFitPolicy.phase, 'V172-Q235');
      expect(GaussSplashPixelPerfectSafeFitPolicy.splashOnlyPhase, isTrue);
      expect(GaussSplashPixelPerfectSafeFitPolicy.userProvidedSplashReferenceUsed, isTrue);
      expect(GaussSplashPixelPerfectSafeFitPolicy.newSplashImageGenerationUsed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.flutterOverlayReenabled, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.appShellBuiltImmediately, isTrue);
      expect(GaussSplashPixelPerfectSafeFitPolicy.firstFrameDeferralAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.androidIconSlotFullscreenBitmapAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.flutterSplashUsesBoxFitContain, isTrue);
      expect(GaussSplashPixelPerfectSafeFitPolicy.flutterSplashCropsArtwork, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.flutterSplashStretchesArtwork, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.nativeSplashCannotCropFullArtwork, isTrue);
      expect(GaussSplashPixelPerfectSafeFitPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.longPressMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.moreMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.graphRuntimeMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.workspaceMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.resultPanelMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.historyMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.solverMutationAllowed, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.flutterTestPassClaimedByAssistant, isFalse);
      expect(GaussSplashPixelPerfectSafeFitPolicy.androidRealDeviceSplashPassClaimedByAssistant, isFalse);
    });

    test('source route uses non-blocking contain-fit splash overlay around AppShell', () {
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      final splash = File('lib/app/gauss_splash_screen.dart').readAsStringSync();
      final valuesV31 = File('android/app/src/main/res/values-v31/styles.xml').readAsStringSync();
      final launchBackground = File('android/app/src/main/res/drawable/launch_background.xml').readAsStringSync();

      expect(app, contains("import 'gauss_splash_screen.dart';"));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(splash, contains('fit: BoxFit.contain'));
      expect(splash, contains('visibleDuration = Duration(milliseconds: 2400)'));
      expect(splash, isNot(contains('fit: BoxFit.cover')));
      expect(splash, isNot(contains('deferFirstFrame')));
      expect(splash, isNot(contains('allowFirstFrame')));
      expect(splash, contains('visibleDuration'));
      expect(splash, contains('errorBuilder'));
      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(valuesV31, contains('@drawable/launch_background'));
      expect(launchBackground, contains('#02050A'));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
    });

    test('ships user-provided splash artwork in the expected safe master sizes', () {
      final flutterAsset = File('assets/branding/gauss_splash_screen.png');
      final nativeAsset = File('android/app/src/main/res/drawable-nodpi/gauss_splash_screen_native.png');
      expect(flutterAsset.existsSync(), isTrue);
      expect(nativeAsset.existsSync(), isTrue);
      expect(_pngSize(flutterAsset.readAsBytesSync()), const _PngSize(1440, 2560));
      expect(_pngSize(nativeAsset.readAsBytesSync()), const _PngSize(1080, 2400));
      expect(flutterAsset.lengthSync(), greaterThan(100000));
      expect(nativeAsset.lengthSync(), greaterThan(100000));
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
  final width = _readUint32(bytes, 16);
  final height = _readUint32(bytes, 20);
  return _PngSize(width, height);
}

int _readUint32(List<int> bytes, int offset) {
  return (bytes[offset] << 24) | (bytes[offset + 1] << 16) | (bytes[offset + 2] << 8) | bytes[offset + 3];
}
