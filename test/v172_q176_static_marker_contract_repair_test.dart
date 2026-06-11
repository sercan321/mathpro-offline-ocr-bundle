import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_static_marker_contract_repair_policy.dart';

void main() {
  test('V172-Q176 restores static Q149/Q170 markers without renderer backslide', () {
    expect(MathLiveStaticMarkerContractRepairPolicy.phase, 'V172-Q176');
    expect(MathLiveStaticMarkerContractRepairPolicy.restoresQ149VisualChromeMarker, isTrue);
    expect(MathLiveStaticMarkerContractRepairPolicy.restoresQ170PremiumVisualMarker, isTrue);
    expect(MathLiveStaticMarkerContractRepairPolicy.userFacingDiagnosticOverlayAllowed, isFalse);
    expect(MathLiveStaticMarkerContractRepairPolicy.privateMathLiveGlyphStylingRestored, isFalse);
    expect(MathLiveStaticMarkerContractRepairPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveStaticMarkerContractRepairPolicy.realDevicePremiumPassClaimed, isFalse);

    final html = File('assets/mathlive/main_editor.html').readAsStringSync();
    expect(html, contains('V172-Q149: final visible chrome sweep'));
    expect(html, contains('MathProPremiumLayoutVisualPolish'));
    expect(html, contains('userFacingDiagnosticOverlay: false'));
    expect(html, contains('data-mathpro-default-renderer-purity="V172-Q175"'));
  });
}
