import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/mathlive/mathlive_official_font_bundle_ingestion_policy.dart';

void main() {
  test('V172-Q196 official MathLive font bundle ingestion is explicit and non-fake', () {
    expect(MathLiveOfficialFontBundleIngestionPolicy.phase, 'V172-Q196');
    expect(MathLiveOfficialFontBundleIngestionPolicy.officialFontFilesBundled, isTrue);
    expect(MathLiveOfficialFontBundleIngestionPolicy.requiredOfficialFontCount, 20);
    expect(MathLiveOfficialFontBundleIngestionPolicy.bundledOfficialFontCount, 20);
    expect(MathLiveOfficialFontBundleIngestionPolicy.requiredOfficialFontFiles.length, 20);
    expect(MathLiveOfficialFontBundleIngestionPolicy.productionInlineCssEmbedsOfficialFontDataUrls, isTrue);
    expect(MathLiveOfficialFontBundleIngestionPolicy.productionMayReferenceMissingFontFiles, isFalse);
    expect(MathLiveOfficialFontBundleIngestionPolicy.fakeFontBundleClosureAllowed, isFalse);
    expect(MathLiveOfficialFontBundleIngestionPolicy.premiumSymbolVisualPassClaimed, isFalse);
    expect(MathLiveOfficialFontBundleIngestionPolicy.flutterAnalyzePassClaimedByAssistant, isFalse);
    expect(MathLiveOfficialFontBundleIngestionPolicy.androidRealDevicePassClaimed, isFalse);
    expect(MathLiveOfficialFontBundleIngestionPolicy.finalReleasePassClaimed, isFalse);
  });
}
