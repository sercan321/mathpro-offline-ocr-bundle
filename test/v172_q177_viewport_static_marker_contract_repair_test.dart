import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_viewport_static_marker_contract_repair_policy.dart';

void main() {
  test('V172-Q177 restores Q148 viewport marker without weakening Q175 renderer purity', () {
    final html = File('assets/mathlive/main_editor.html').readAsStringSync();

    expect(MathLiveViewportStaticMarkerContractRepairPolicy.phase, 'V172-Q177');
    expect(html, contains(MathLiveViewportStaticMarkerContractRepairPolicy.repairedMarker));
    expect(html, contains('mathpro-fit-micro'));
    expect(html, contains('MathProDefaultRendererPurity'));
    expect(html, contains('internalGlyphClassStylingForbidden: true'));

    expect(MathLiveViewportStaticMarkerContractRepairPolicy.q148ViewportMarkerRestored, isTrue);
    expect(MathLiveViewportStaticMarkerContractRepairPolicy.defaultRendererPurityPreserved, isTrue);
    expect(MathLiveViewportStaticMarkerContractRepairPolicy.keyboardLayoutMutated, isFalse);
    expect(MathLiveViewportStaticMarkerContractRepairPolicy.appShellMutated, isFalse);
    expect(MathLiveViewportStaticMarkerContractRepairPolicy.graphHistorySolutionMutated, isFalse);
    expect(MathLiveViewportStaticMarkerContractRepairPolicy.flutterPassClaimedByAssistant, isFalse);
    expect(MathLiveViewportStaticMarkerContractRepairPolicy.realDevicePremiumPassClaimed, isFalse);
  });
}
