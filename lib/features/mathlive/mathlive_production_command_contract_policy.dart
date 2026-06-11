/// V172-Q199 — Production command contract finalization.
///
/// This table is the single production truth for the critical MathPro keyboard
/// labels that previously had overlapping historical bridge maps. It does not
/// mutate keyboard layout, MORE inventory, long-press order, Graph UI, History
/// UI, or Solution UI. It only defines what the production MathLive bridge may
/// receive for each critical label.
abstract final class MathLiveProductionCommandContractPolicy {
  static const String phase = 'V172-Q199';
  static const String fullPhase = 'V172-Q199-PRODUCTION-COMMAND-CONTRACT-FINALIZATION';
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool historyUiMutationAllowed = false;
  static const bool solutionUiMutationAllowed = false;
  static const bool rawInsertTokensMayCrossProductionBridge = false;
  static const bool rawVisibleLabelsMayCrossProductionBridgeForCriticalTemplates = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;

  static const List<MathLiveProductionCommandContractEntry> criticalContracts = <MathLiveProductionCommandContractEntry>[
    MathLiveProductionCommandContractEntry(
      label: 'lim',
      action: 'insertLatex',
      productionLatex: r'\textstyle\lim_{x\to #?} #0',
      documentLatex: r'\lim_{x\to \placeholder{}}\placeholder{}',
      placeholderCount: 2,
      sourceCategory: 'calculus-limit',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-limit-template-with-target-and-body-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'lim x→□',
      action: 'insertLatex',
      productionLatex: r'\textstyle\lim_{x\to #?} #0',
      documentLatex: r'\lim_{x\to \placeholder{}}\placeholder{}',
      placeholderCount: 2,
      sourceCategory: 'calculus-limit',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-limit-template-with-target-and-body-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'lim x→∞',
      action: 'insertLatex',
      productionLatex: r'\textstyle\lim_{x\to \infty} #0',
      documentLatex: r'\lim_{x\to \infty}\placeholder{}',
      placeholderCount: 1,
      sourceCategory: 'calculus-limit',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-limit-template-with-infinity-target-and-body-placeholder',
    ),
    MathLiveProductionCommandContractEntry(
      label: '□/□',
      action: 'insertLatex',
      productionLatex: r'\frac{#0}{#?}',
      documentLatex: r'\frac{\placeholder{}}{\placeholder{}}',
      placeholderCount: 2,
      sourceCategory: 'fraction',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-fraction-with-editable-numerator-and-denominator',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'a/b',
      action: 'insertLatex',
      productionLatex: r'\frac{#0}{#?}',
      documentLatex: r'\frac{\placeholder{}}{\placeholder{}}',
      placeholderCount: 2,
      sourceCategory: 'fraction',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-fraction-with-editable-numerator-and-denominator',
    ),
    MathLiveProductionCommandContractEntry(
      label: '□⁄□',
      action: 'insertLatex',
      productionLatex: r'\frac{#0}{#?}',
      documentLatex: r'\frac{\placeholder{}}{\placeholder{}}',
      placeholderCount: 2,
      sourceCategory: 'fraction',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-fraction-with-editable-numerator-and-denominator',
    ),
    MathLiveProductionCommandContractEntry(
      label: '√□',
      action: 'insertLatex',
      productionLatex: r'\sqrt{#0}',
      documentLatex: r'\sqrt{\placeholder{}}',
      placeholderCount: 1,
      sourceCategory: 'root',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-square-root-with-radicand-placeholder',
    ),
    MathLiveProductionCommandContractEntry(
      label: '√x',
      action: 'insertLatex',
      productionLatex: r'\sqrt{#0}',
      documentLatex: r'\sqrt{\placeholder{}}',
      placeholderCount: 1,
      sourceCategory: 'root',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-square-root-with-radicand-placeholder',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'x^y',
      action: 'insertLatex',
      productionLatex: r'#@^{#?}',
      documentLatex: r'\placeholder{}^{\placeholder{}}',
      placeholderCount: 2,
      sourceCategory: 'power',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-power-template-with-base-and-exponent-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: '□^□',
      action: 'insertLatex',
      productionLatex: r'#@^{#?}',
      documentLatex: r'\placeholder{}^{\placeholder{}}',
      placeholderCount: 2,
      sourceCategory: 'power',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-power-template-with-base-and-exponent-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'Σ',
      action: 'insertLatex',
      productionLatex: r'\textstyle\sum_{n=#?}^{#?} #0',
      documentLatex: r'\sum_{n=\placeholder{}}^{\placeholder{}}\placeholder{}',
      placeholderCount: 3,
      sourceCategory: 'series-sum',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-sigma-template-with-lower-upper-and-body-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'Π',
      action: 'insertLatex',
      productionLatex: r'\textstyle\prod_{n=#?}^{#?} #0',
      documentLatex: r'\prod_{n=\placeholder{}}^{\placeholder{}}\placeholder{}',
      placeholderCount: 3,
      sourceCategory: 'series-product',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-product-template-with-lower-upper-and-body-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: '∫',
      action: 'insertLatex',
      productionLatex: r'\int #0\,dx',
      documentLatex: r'\int \placeholder{}\,dx',
      placeholderCount: 1,
      sourceCategory: 'calculus-integral',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-indefinite-integral-with-body-placeholder',
    ),
    MathLiveProductionCommandContractEntry(
      label: '∫dx',
      action: 'insertLatex',
      productionLatex: r'\int #0\,dx',
      documentLatex: r'\int \placeholder{}\,dx',
      placeholderCount: 1,
      sourceCategory: 'calculus-integral',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-indefinite-integral-with-body-placeholder',
    ),
    MathLiveProductionCommandContractEntry(
      label: '∫□dx',
      action: 'insertLatex',
      productionLatex: r'\int #0\,dx',
      documentLatex: r'\int \placeholder{}\,dx',
      placeholderCount: 1,
      sourceCategory: 'calculus-integral',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-indefinite-integral-with-body-placeholder',
    ),
    MathLiveProductionCommandContractEntry(
      label: '∫ₐᵇ',
      action: 'insertLatex',
      productionLatex: r'\int_{#?}^{#?} #0\,dx',
      documentLatex: r'\int_{\placeholder{}}^{\placeholder{}}\placeholder{}\,dx',
      placeholderCount: 3,
      sourceCategory: 'calculus-integral',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-definite-integral-with-lower-upper-and-body-placeholders',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'Taylor',
      action: 'insertLatex',
      productionLatex: r'\textstyle f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(a\right)}{n!}\left(x-a\right)^n',
      documentLatex: r'f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(a\right)}{n!}\left(x-a\right)^n',
      placeholderCount: 0,
      sourceCategory: 'series-named-template',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-taylor-series-expression-not-plain-text-label',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'Maclaurin',
      action: 'insertLatex',
      productionLatex: r'\textstyle f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(0\right)}{n!}x^n',
      documentLatex: r'f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(0\right)}{n!}x^n',
      placeholderCount: 0,
      sourceCategory: 'series-named-template',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-maclaurin-series-expression-not-plain-text-label',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'C',
      action: 'clear',
      productionLatex: '',
      documentLatex: '',
      placeholderCount: 0,
      sourceCategory: 'editing-clear',
      graphHistorySolutionImpact: 'clear-production-mathlive-state-and-controller-mirror',
      expectedPostCommandStateBehavior: 'clear-command-resets-queue-latex-and-controller-expression',
    ),
    MathLiveProductionCommandContractEntry(
      label: '⌫',
      action: 'deleteBackward',
      productionLatex: '',
      documentLatex: '',
      placeholderCount: 0,
      sourceCategory: 'editing-delete',
      graphHistorySolutionImpact: 'mathlive-production-state-after-delete-state-push',
      expectedPostCommandStateBehavior: 'native-mathlive-delete-backward-with-focus-and-state-push',
    ),
    MathLiveProductionCommandContractEntry(
      label: '↵',
      action: 'evaluate',
      productionLatex: '',
      documentLatex: '',
      placeholderCount: 0,
      sourceCategory: 'evaluation-enter',
      graphHistorySolutionImpact: 'evaluate-current-mathlive-production-state',
      expectedPostCommandStateBehavior: 'request-evaluation-without-inserting-visible-enter-label',
    ),
    MathLiveProductionCommandContractEntry(
      label: 'Ans',
      action: 'insertLastAnswer',
      productionLatex: 'dynamic-last-answer',
      documentLatex: 'dynamic-last-answer',
      placeholderCount: 0,
      sourceCategory: 'answer-reuse',
      graphHistorySolutionImpact: 'mathlive-production-state-after-last-answer-insert',
      expectedPostCommandStateBehavior: 'insert-supplied-last-answer-or-noop-when-empty',
    ),
    MathLiveProductionCommandContractEntry(
      label: '=',
      action: 'insertLatex',
      productionLatex: '=',
      documentLatex: '=',
      placeholderCount: 0,
      sourceCategory: 'relation',
      graphHistorySolutionImpact: 'mathlive-production-state-after-bridge-state-push',
      expectedPostCommandStateBehavior: 'insert-equals-relation-not-evaluate-command',
    ),
  ];

  static final Map<String, MathLiveProductionCommandContractEntry> criticalContractsByLabel = <String, MathLiveProductionCommandContractEntry>{
    for (final entry in criticalContracts) entry.label: entry,
  };

  static MathLiveProductionCommandContractEntry? contractForLabel(String label) => criticalContractsByLabel[label];

  static bool isCriticalLabel(String label) => criticalContractsByLabel.containsKey(label);

  static bool hasRawInsertToken(String value) => value.contains('#@') || value.contains('#0') || value.contains('#?');

  static int documentPlaceholderCount(String value) => RegExp(r'\\placeholder\{\}').allMatches(value).length;

  static bool documentLatexMatchesPlaceholderContract(MathLiveProductionCommandContractEntry entry) {
    if (entry.action != 'insertLatex') return entry.placeholderCount == 0;
    return documentPlaceholderCount(entry.documentLatex) == entry.placeholderCount;
  }
}

class MathLiveProductionCommandContractEntry {
  const MathLiveProductionCommandContractEntry({
    required this.label,
    required this.action,
    required this.productionLatex,
    required this.documentLatex,
    required this.placeholderCount,
    required this.sourceCategory,
    required this.graphHistorySolutionImpact,
    required this.expectedPostCommandStateBehavior,
    this.rawInsertTokenAllowed = false,
  });

  final String label;
  final String action;
  final String productionLatex;
  final String documentLatex;
  final int placeholderCount;
  final String sourceCategory;
  final String graphHistorySolutionImpact;
  final String expectedPostCommandStateBehavior;
  final bool rawInsertTokenAllowed;
}
