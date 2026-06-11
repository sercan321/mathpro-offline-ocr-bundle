import 'dart:math' as math;

/// V172-Q150 / Q153 — Premium popup fit policy.
///
/// This is a visual-fit policy only. It must not change keyboard order, MORE
/// inventory, long-press option order, selected labels, Graph/History/Solution
/// UI, or MathLive semantics. Its role is to make long-press and MORE panels
/// look like compact premium mobile surfaces instead of oversized/clipped cards.
class PremiumPopupFitPolicy {
  const PremiumPopupFitPolicy._();

  static const String phase = 'V172-Q150';
  static const String testContractRepairPhase = 'V172-Q153';
  static const String envelopeFinalRebalancePhase = 'V172-Q156';
  static const String premiumVisualPolishPhase = 'V172-Q170';
  static const String templateOpticalCorrectionPhase = 'V172-Q171';
  static const String legacyPopupContractRepairPhase = 'V172-Q172';
  static const String plus99FloatingSegmentMenuPhase = 'V172-Q231';
  static const bool visualFitOnly = true;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool moreCategoryMutationAllowed = false;
  static const bool mathLiveTemplateMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const double longPressPanelMinHeight = 60.0;
  static const double longPressPanelMaxHeight = 64.0;
  static const double longPressChipHeight = 48.0;
  static const double longPressChipMinWidth = 62.0;
  static const double longPressBoundedIntegralChipWidth = 98.0;
  static const double longPressPanelHorizontalInset = 12.0;
  static const double longPressPanelBottomInset = 7.0;
  static const double longPressPanelHorizontalPadding = 6.0;
  static const double longPressPanelVerticalPadding = 6.0;
  static const double longPressChipGap = 2.0;
  static const double longPressChipInnerHorizontalInset = 8.0;
  static const double longPressChipInnerVerticalInset = 6.0;
  static const double longPressMathFontSize = 14.2;
  static const double longPressTextFontSize = 13.6;

  static const double moreTrayHorizontalMargin = 8.0;
  static const double moreTrayHorizontalPadding = 8.0;
  static const double moreTrayVerticalPaddingCompact = 3.0;
  static const double moreTrayVerticalPaddingRegular = 4.0;
  static const double moreTrayHeaderHeightCompact = 18.0;
  static const double moreTrayHeaderHeightRegular = 22.0;
  static const double moreTrayCategoryHeightCompact = 23.0;
  static const double moreTrayCategoryHeightRegular = 26.0;
  static const double moreTrayChipHeightCompact = 29.0;
  static const double moreTrayChipHeightRegular = 32.0;
  static const double moreTrayGapCompact = 2.0;
  static const double moreTrayGapRegular = 3.0;
  static const double moreCategoryHorizontalPaddingCompact = 6.0;
  static const double moreCategoryHorizontalPaddingRegular = 8.0;
  static const double moreTemplateHorizontalPaddingCompact = 7.0;
  static const double moreTemplateHorizontalPaddingRegular = 9.0;
  static const double moreScrollHorizontalPadding = 6.0;

  static double desiredLongPressPanelWidth(
    Iterable<String> labels,
    double Function(String label) chipWidthFor,
  ) {
    final list = labels.toList(growable: false);
    final chipTotal = list.fold<double>(0, (sum, label) => sum + chipWidthFor(label));
    final gapTotal = list.length <= 1 ? 0.0 : longPressChipGap * (list.length - 1);
    final minimum = list.length <= 3 ? 148.0 : 176.0;
    return math.max(minimum, chipTotal + gapTotal + longPressPanelHorizontalPadding * 2);
  }

  static double longPressChipWidthFor({required String label, required double baseWidth}) {
    if (label == '∫ₐᵇ') return longPressBoundedIntegralChipWidth;
    final cap = isWidePopupLabel(label) ? 132.0 : 104.0;
    return baseWidth.clamp(longPressChipMinWidth, cap).toDouble();
  }

  static double moreChipMinWidth(double baseWidth, {required bool compact}) {
    final cap = compact ? 88.0 : 104.0;
    return baseWidth.clamp(compact ? 40.0 : 46.0, cap).toDouble();
  }

  static double moreChipMaxWidth(double baseWidth, {required bool compact}) {
    final cap = compact ? 126.0 : 148.0;
    return baseWidth.clamp(compact ? 76.0 : 88.0, cap).toDouble();
  }

  static bool isWidePopupLabel(String label) {
    return label.contains('Taylor') ||
        label.contains('Maclaurin') ||
        label.contains('Geometrik') ||
        label.contains('Binom') ||
        label.contains('denklem') ||
        label.contains('serisi') ||
        label.contains('∫') ||
        label.contains('Σ') ||
        label.contains('Π') ||
        label.contains('lim') ||
        label.contains('log') ||
        label.contains('d/dx') ||
        label.contains('∂/∂x');
  }
}
