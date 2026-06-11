import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_default_renderer_purity_policy.dart';

void main() {
  group('V172-Q175 MathLive default renderer purity', () {
    test('targets MathLive default glyph layout without claiming device PASS', () {
      expect(MathLiveDefaultRendererPurityPolicy.phase, 'V172-Q175');
      expect(MathLiveDefaultRendererPurityPolicy.targetDefaultRendererSimilarity, 0.95);
      expect(MathLiveDefaultRendererPurityPolicy.mathLiveDefaultGlyphLayoutIsOwner, isTrue);
      expect(MathLiveDefaultRendererPurityPolicy.privateMathLiveGlyphClassStylingAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.internalFractionLineStylingAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.internalSqrtLineStylingAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.internalPlaceholderClassStylingAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.internalBaseFontClassStylingAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.realDevicePremiumPassClaimed, isFalse);
    });

    test('keeps protected MathPro surfaces frozen', () {
      expect(MathLiveDefaultRendererPurityPolicy.keyboardLayoutMutationAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.longPressOrderMutationAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.moreInventoryMutationAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.appShellMutationAllowed, isFalse);
      expect(MathLiveDefaultRendererPurityPolicy.graphHistorySolutionUiMutationAllowed, isFalse);
    });
  });
}
