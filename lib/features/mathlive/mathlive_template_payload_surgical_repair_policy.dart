/// V172-Q190R5 — Template Payload Surgical Repair.
///
/// Q190R4 made the production bridge strict enough to refuse half/raw template
/// fallback when MathLive insert-control tokens (#0/#?/#@) did not commit. That
/// prevented false success, but it also left critical structural templates
/// vulnerable to being rejected instead of rendered as editable document
/// placeholders. Q190R5 closes the code-level template payload contract: the
/// production WebView payload must cross the bridge as document LaTeX using
/// explicit `\placeholder{}` nodes, while the historical command map may keep
/// its older insert-control tokens for compatibility tests.
class MathLiveTemplatePayloadSurgicalRepairPolicy {
  const MathLiveTemplatePayloadSurgicalRepairPolicy._();

  static const String phase = 'V172-Q190R5';
  static const String baseline = 'V172-Q190R4_PRODUCTION_BRIDGE_QUEUE_FOCUS_REPAIR';
  static const String repairScope = 'production-template-payload-document-placeholder-repair';

  static const bool newFeatureAllowed = false;
  static const bool finalReleaseClaimAllowed = false;
  static const bool keyboardLayoutMutationAllowed = false;
  static const bool moreInventoryMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool graphUiMutationAllowed = false;
  static const bool graphControllerMutationAllowed = false;
  static const bool historyControllerMutationAllowed = false;
  static const bool historyPanelMutationAllowed = false;
  static const bool solutionStepsPanelMutationAllowed = false;

  static const bool productionPayloadMustUseDocumentPlaceholders = true;
  static const bool rawInsertTokensMayCrossProductionBridge = false;
  static const bool q190R4RawTemplateFallbackBlockPreserved = true;
  static const bool jsBridgeAlsoNormalizesPayload = true;
  static const bool historicalCommandMapCompatibilityPreserved = true;
  static const bool visualDebugOverlayAllowed = false;
  static const bool productionPublicApiExpansionAllowed = false;

  static const bool androidRealDevicePassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool premiumSymbolVisualPassClaimed = false;
  static const bool caretRealDevicePassClaimed = false;
  static const bool legacySurfacePhysicalCleanupCompleted = false;
}
