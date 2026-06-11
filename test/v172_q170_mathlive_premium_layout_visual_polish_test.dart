import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/keyboard/premium_popup_fit_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_premium_layout_visual_polish_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_device_diagnostic_bridge_policy.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_single_source_bridge_policy.dart';

void main() {
  test('V172-Q170 premium polish suppresses user-facing diagnostics without claiming device pass', () {
    expect(MathLivePremiumLayoutVisualPolishPolicy.phase, 'V172-Q170');
    expect(MathLivePremiumLayoutVisualPolishPolicy.userFacingDiagnosticOverlayAllowed, isFalse);
    expect(MathLivePremiumLayoutVisualPolishPolicy.realDevicePremiumPassClaimed, isFalse);
    expect(MathLiveRealDeviceDiagnosticBridgePolicy.visibleDiagnosticOverlayEnabled, isFalse);
    expect(MathLiveRealDeviceDiagnosticBridgePolicy.diagnosticBridgeEnabled, isTrue);
  });

  test('V172-Q170 parser no longer consumes generic bridge states as court envelopes', () {
    const generic = '{"singleSourceBridgePhase":"V172-Q169R23","latex":"5"}';
    const envelope = '{"q169SingleSourceEnvelope":true,"mount":"ok","insert":"ok","value":"ok","channel":"ok","paint":"ok","rootCause":"none"}';
    expect(MathLiveSingleSourceBridgePolicy.shouldConsumeSingleSourceEnvelope(generic), isFalse);
    expect(MathLiveSingleSourceBridgePolicy.shouldConsumeSingleSourceEnvelope(envelope), isTrue);
  });

  test('V172-Q170 popup policy remains visual-fit only while Q172 preserves no-clip envelope', () {
    expect(PremiumPopupFitPolicy.premiumVisualPolishPhase, 'V172-Q170');
    expect(PremiumPopupFitPolicy.legacyPopupContractRepairPhase, 'V172-Q172');
    expect(PremiumPopupFitPolicy.visualFitOnly, isTrue);
    expect(PremiumPopupFitPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(PremiumPopupFitPolicy.plus99FloatingSegmentMenuPhase, 'V172-Q231');
    expect(PremiumPopupFitPolicy.longPressPanelMinHeight, 60.0);
    expect(PremiumPopupFitPolicy.longPressPanelMaxHeight, 64.0);
    expect(PremiumPopupFitPolicy.longPressChipHeight, 48.0);
  });

  test('V172-Q170 HTML contains premium visual markers and no visible diagnostic requirement', () {
    final html = File('assets/mathlive/main_editor.html').readAsStringSync();
    expect(html.contains('data-mathpro-premium-visual="V172-Q170"'), isTrue);
    expect(html.contains('MathProPremiumLayoutVisualPolish'), isTrue);
    expect(html.contains('userFacingDiagnosticOverlay: false'), isTrue);
  });
}
