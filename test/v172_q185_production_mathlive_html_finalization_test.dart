import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_production_html_finalization_policy.dart';

void main() {
  test('V172-Q185 production MathLive HTML finalization policy is conservative', () {
    expect(MathLiveProductionHtmlFinalizationPolicy.phase, 'V172-Q185');
    expect(MathLiveProductionHtmlFinalizationPolicy.usesProductionHtml, isTrue);
    expect(MathLiveProductionHtmlFinalizationPolicy.usesProductionBridge, isTrue);
    expect(MathLiveProductionHtmlFinalizationPolicy.diagnosticCourtInProduction, isFalse);
    expect(MathLiveProductionHtmlFinalizationPolicy.mathLivePrivateGlyphCssAllowed, isFalse);
    expect(MathLiveProductionHtmlFinalizationPolicy.keyboardLayoutMutationAllowed, isFalse);
    expect(MathLiveProductionHtmlFinalizationPolicy.graphHistorySolutionMutationAllowed, isFalse);
    expect(MathLiveProductionHtmlFinalizationPolicy.realDevicePremiumPassClaimed, isFalse);
  });
}
