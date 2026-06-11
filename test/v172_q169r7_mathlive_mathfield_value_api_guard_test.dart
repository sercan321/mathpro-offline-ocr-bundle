
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('V172-Q169R7 MathLive mathfield value API guard', () {
    test('JS bridge guards value reads and force-commits sanitized document latex after empty insert', () {
      final bridge = File('assets/mathlive/mathlive_bridge.js').readAsStringSync();
      expect(bridge, contains('mathfieldValueApiGuardPhase: \'V172-Q169R7\''));
      expect(bridge, contains('q169r7-mathfield-value-api-guarded'));
      expect(bridge, contains('commitDocumentLatexToMathfield'));
      expect(bridge, contains('q169r7-empty-after-insert-direct-value-commit'));
      expect(bridge, contains('mathfield.setValue(value, { silenceNotifications: false })'));
      expect(bridge, contains('mathfield.value = value'));
      expect(bridge, contains("markJsCommandStatus(inserted ? 'ok' : 'fail', 'q169-after-insert-mathfield q169r7-value-api-guard')"));
    });

    test('policy and package metadata document that Q169R7 is not a device PASS claim', () {
      final policy = File('lib/features/mathlive/mathlive_mathfield_value_api_guard_policy.dart').readAsStringSync();
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();

      expect(policy, contains("phase = 'V172-Q169R7'"));
      expect(policy, contains('realDevicePaintPassClaimed = false'));
      expect(manifest, contains('v172Q169R7MathfieldValueApiGuard'));
      expect(manifest, contains('realDevicePassClaimed'));
      expect(readme, contains('V172-Q169R7 — MathLive Mathfield Value API Guard'));
    });
  });
}
