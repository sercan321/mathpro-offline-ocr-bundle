import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/editor_adapter/mathlive_editor_adapter_contract.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_offline_asset_policy.dart';
import 'package:mathpro_flutter_phase17/logic/mathpro_package_contract.dart';

void main() {
  group('V172-Q83 Offline MathLive Asset Foundation', () {
    test('records offline asset foundation without claiming real MathLive runtime', () {
      expect(MathProPackageContract.version, '0.172.112+172');
      expect(MathProPackageContract.q83OfflineMathLiveAssetFoundationRule, contains('assets/mathlive/'));
      expect(MathProPackageContract.q83OfflineMathLiveAssetFoundationRule, contains('real MathLive runtime is not bundled yet'));
      expect(MathLiveOfflineAssetPolicy.realMathLiveRuntimeBundled, isFalse);
      expect(MathLiveOfflineAssetPolicy.labScreenImplemented, isFalse);
      expect(MathLiveOfflineAssetPolicy.mainEditorSwitchAllowed, isFalse);
      expect(MathLiveOfflineAssetPolicy.cdnDependencyAllowed, isFalse);
      expect(MathLiveOfflineAssetPolicy.remoteScriptLoadingAllowed, isFalse);
      expect(MathLiveOfflineAssetPolicy.mathLiveVirtualKeyboardEnabled, isFalse);
    });

    test('declares local bootstrap assets and keeps remote scripts out', () {
      for (final path in MathLiveOfflineAssetPolicy.requiredAssetPaths) {
        expect(File(path).existsSync(), isTrue, reason: '$path must exist');
      }
      final index = File(MathLiveOfflineAssetPolicy.indexHtmlAsset).readAsStringSync();
      final bridge = File(MathLiveOfflineAssetPolicy.bridgeJsAsset).readAsStringSync();
      final manifest = File(MathLiveOfflineAssetPolicy.manifestAsset).readAsStringSync();
      expect(index, contains('mathlive_bridge.js'));
      expect(index, isNot(contains('http://')));
      expect(index, isNot(contains('https://')));
      expect(bridge, contains('MathProMathLiveOfflineBridge'));
      expect(bridge, contains('realMathLiveRuntimeBundled: false'));
      expect(manifest, contains('"cdnDependencyAllowed": false'));
      expect(manifest, contains('"remoteScriptLoadingAllowed": false'));
    });

    test('pubspec registers the offline mathlive asset directory', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, contains(MathProPackageContract.pubspecDescription));
      expect(pubspec, contains('assets/mathlive/'));
      expect(MathLiveEditorAdapterContract.webViewAssetPath, MathLiveOfflineAssetPolicy.indexHtmlAsset);
      expect(
        MathLiveOfflineAssetPolicy.assetsAreSufficientForLabBootstrap(
          indexHtmlPresent: true,
          bridgeJsPresent: true,
          cssPresent: true,
          manifestPresent: true,
          usesRemoteScripts: false,
        ),
        isTrue,
      );
      expect(
        MathLiveOfflineAssetPolicy.mayClaimRealMathLiveRuntime(
          officialRuntimeAssetPresent: false,
          mathFieldConstructsOnDevice: true,
          realDeviceFocusPasses: true,
        ),
        isFalse,
      );
    });
  });
}
