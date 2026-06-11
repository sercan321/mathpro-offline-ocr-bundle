/// V172-Q191 — Runtime Render Contract Closure policy.
///
/// This phase is a code/static production-render contract closure. It does not
/// claim Flutter analyze PASS, Flutter test PASS, Android real-device PASS,
/// premium visual PASS, or caret PASS. It freezes the production MathLive
/// payloads that must render as mathematical structures instead of raw text or
/// historical insert-control tokens.
class MathLiveRuntimeRenderContractPolicy {
  const MathLiveRuntimeRenderContractPolicy._();

  static const String phase = 'V172-Q191';
  static const String baseline = 'V172-Q190R9_STATIC_PRE_ANALYZE_HYGIENE';
  static const String closureName = 'runtime-render-contract-closure';

  static const bool newFeatureAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;

  static const bool criticalTemplatesMustUseExplicitRenderContracts = true;
  static const bool rawInsertTokensMayCrossProductionBridge = false;
  static const bool renderPayloadMayBePlainVisibleLabel = false;
  static const bool productionBridgeMustRejectRawTokenLeak = true;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool androidRealDevicePassClaimed = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;

  static const List<String> criticalLabels = <String>[
    'lim',
    'lim x→□',
    'lim x→∞',
    'a/b',
    '□/□',
    '□⁄□',
    '√□',
    '√x',
    'x^y',
    '□^□',
    'Σ',
    'Π',
    '∫',
    '∫dx',
    '∫□dx',
    '∫ₐᵇ',
    'Taylor',
    'Maclaurin',
  ];
}
