/// V172-Q152 — MathLive Final Premium Package Freeze.
///
/// This phase freezes the package-side MathLive premium-rendering repair chain
/// after Q140–Q151. It is not a real-device PASS claim. It only records that
/// the shipped full ZIP must contain the current MathLive bridge/CSS/runtime
/// sync/chrome/template/popup package contracts, keep protected product surfaces
/// locked, stay clean of generated artifacts, and require one final user-side
/// Flutter/device court before any Photomath-level or cursor-fluidity claim.
class MathLiveFinalPremiumPackageFreezePolicy {
  const MathLiveFinalPremiumPackageFreezePolicy._();

  static const String phase = 'V172-Q152';
  static const String packageProfile = 'fullCleanZipPackageFreeze';
  static const bool patchOnlyDeliveryAllowed = false;
  static const bool staleStandardZipAllowed = false;
  static const bool protectedKeyboardLayoutMutationAllowed = false;
  static const bool protectedLongPressOrderMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool legacyFlutterCursorOverlayMayReturn = false;
  static const bool mathLiveVisibleChromeAllowed = false;
  static const bool rawNamedTemplateTextFallbackAllowed = false;
  static const bool fakeRuntimeEvidenceAllowed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;
  static const bool cursorPassClaimed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> requiredPackagePhases = <String>[
    'V172-Q140',
    'V172-Q141',
    'V172-Q142',
    'V172-Q143',
    'V172-Q144',
    'V172-Q145',
    'V172-Q146',
    'V172-Q148',
    'V172-Q149',
    'V172-Q150',
    'V172-Q151',
    'V172-Q152',
    'V172-Q153',
  ];

  static const List<String> protectedSurfaces = <String>[
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/premium_key.dart',
    'lib/features/solution/solution_steps_panel.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
  ];

  static const List<String> userSideFinalCourtCommands = <String>[
    'flutter clean',
    'flutter pub get',
    'node tool/install_mathlive_runtime.mjs',
    'flutter analyze',
    'flutter test',
    'node tool/verify_mathlive_runtime.mjs',
    'node tool/verify_mathlive_official_runtime_bundle.mjs',
    'node tool/verify_mathlive_full_main_editor_migration_v172_q135_q139.mjs',
    'node tool/verify_mathlive_premium_surface_repair_v172_q140.mjs',
    'node tool/verify_mathlive_premium_visual_refinement_v172_q141.mjs',
    'node tool/verify_mathlive_semantic_template_coverage_v172_q142.mjs',
    'node tool/verify_mathlive_pointer_caret_fluidity_v172_q143.mjs',
    'node tool/verify_mathlive_main_editor_state_authority_v172_q144.mjs',
    'node tool/verify_mathlive_premium_template_layout_v172_q145.mjs',
    'node tool/verify_mathlive_runtime_sync_binding_v172_q146.mjs',
    'node tool/verify_mathlive_viewport_fit_v172_q148.mjs',
    'node tool/verify_mathlive_visual_chrome_contract_v172_q149.mjs',
    'node tool/verify_mathpro_popup_premium_fit_v172_q150.mjs',
    'node tool/verify_mathlive_extended_template_court_v172_q151.mjs',
    'node tool/verify_mathlive_final_premium_package_freeze_v172_q152.mjs',
    'node tool/verify_mathlive_flutter_test_contract_repair_v172_q153.mjs',
    'flutter run -d 23106RN0DA',
  ];
}
