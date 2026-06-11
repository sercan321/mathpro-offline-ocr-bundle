import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_real_mathlive_font_bundle_closure_policy.dart';

void main() {
  test('Q193 records official MathLive font bundle truth without fake closure', () {
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.phase, 'V172-Q193');
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.closureStatus, 'BLOCKED_OFFICIAL_FONT_FILES_ABSENT');
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.officialMathLiveCssPresent, isTrue);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.officialMathLiveFontCssRequiresFontsDirectory, isTrue);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.officialFontFilesBundled, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.fakeFontBundleClosureClaimAllowed, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.productionMayReferenceMissingFontFiles, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.q190r8MissingFontReferenceSanitizerMustRemainActive, isTrue);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.requiredOfficialFontFiles.length, 20);
  });

  test('Q193 does not claim unavailable runtime evidence', () {
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.flutterTestPassClaimedByAssistant, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.flutterRunPassClaimedByAssistant, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.androidRealDevicePassClaimed, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.premiumSymbolVisualPassClaimed, isFalse);
    expect(MathLiveRealMathLiveFontBundleClosurePolicy.caretRealDevicePassClaimed, isFalse);
  });
}
