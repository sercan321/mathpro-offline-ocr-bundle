import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_screen.dart';
import 'package:mathpro_flutter_phase17/app/gauss_splash_screen_policy.dart';

void main() {
  group('V172-Q212 GAUSS splash screen surgical integration', () {
    test('records a splash-only contract without launcher, keyboard, graph, history, solution or MathLive mutation', () {
      expect(GaussSplashScreenPolicy.phase, 'V172-Q212');
      expect(GaussSplashScreenPolicy.masterAsset, GaussStartupSplash.assetPath);
      expect(GaussSplashScreenPolicy.launcherIconMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.keyboardMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.graphMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.historyMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.solutionMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.mathLiveMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.businessLogicMutationAllowed, isFalse);
      expect(GaussSplashScreenPolicy.imageRedrawAllowed, isFalse);
      expect(GaussSplashScreenPolicy.extraDecorationAllowed, isFalse);
    });

    test('ships the supplied GAUSS splash asset as a tall lossless PNG master', () {
      final asset = File(GaussSplashScreenPolicy.masterAsset);
      expect(asset.existsSync(), isTrue);
      final bytes = asset.readAsBytesSync();
      expect(_pngSize(bytes), const _PngSize(1440, 2560));
      expect(bytes.length, greaterThan(100000));
    });

    test('uses safe native dark splash plus Flutter GAUSS overlay without launcher icon mutation', () {
      final launchBackground = File(GaussSplashScreenPolicy.androidLaunchBackground).readAsStringSync();
      final values = File(GaussSplashScreenPolicy.androidValuesStyle).readAsStringSync();
      final valuesV31 = File(GaussSplashScreenPolicy.androidValuesV31Style).readAsStringSync();
      final systemIcon = File('android/app/src/main/res/drawable/splash_transparent_icon.xml').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final app = File('lib/app/mathpro_app.dart').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync();

      expect(launchBackground, contains('#02050A'));
      expect(launchBackground, contains('@drawable/gauss_splash_screen_native'));
      expect(systemIcon, isNot(contains('@drawable/gauss_splash_screen_native')));
      expect(values, contains('@drawable/launch_background'));
      expect(values, contains('NormalTheme'));
      expect(valuesV31, contains('windowSplashScreenBackground'));
      expect(valuesV31, contains('@drawable/splash_transparent_icon'));
      expect(valuesV31, isNot(contains('@drawable/gauss_splash_v31_icon')));
      expect(valuesV31, isNot(contains('android:postSplashScreenTheme')));
      expect(manifest, contains('io.flutter.embedding.android.NormalTheme'));
      expect(app, contains("import 'gauss_splash_screen.dart';"));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('home: const GaussStartupSplash(child: MathProAppShell()),'));
      expect(app, contains('MathProAppShell'));
      // Q219 supersedes the active splash wrapper until boot visibility is proven on device.
      expect(pubspec, contains('assets/branding/gauss_splash_screen.png'));
      expect(launchBackground, isNot(contains('@mipmap/ic_launcher')));
      expect(valuesV31, isNot(contains('@mipmap/ic_launcher')));
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
