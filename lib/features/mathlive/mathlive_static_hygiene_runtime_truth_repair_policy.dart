/// V172-Q169R28 package-side static hygiene and runtime-truth repair.
///
/// This phase is intentionally narrow. It repairs the Q169R8 static failure
/// reason drift after Q169R27 introduced a stricter native-paint proof reason,
/// and records the pre-device runtime truth without claiming Android PAINT:ok.
/// It does not touch keyboard layout, MORE, long-press order, AppShell,
/// Graph UI, History UI, Solution UI, solver behavior, or premium visuals.
class MathLiveStaticHygieneRuntimeTruthRepairPolicy {
  static const String phase = 'V172-Q169R28';

  static const bool keyboardLayoutMutationAllowed = false;
  static const bool morePanelMutationAllowed = false;
  static const bool longPressOrderMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionUiMutationAllowed = false;
  static const bool solverMutationAllowed = false;
  static const bool premiumVisualPolishAllowed = false;

  static const bool flutterAnalyzePassClaimed = false;
  static const bool flutterTestPassClaimed = false;
  static const bool flutterRunPassClaimed = false;
  static const bool realDevicePaintPassClaimed = false;
  static const bool mathLiveFullyTookOverClaimed = false;

  static const String runtimeInstallCommand = 'node tool/install_mathlive_runtime.mjs';
  static const String runtimeVerifyCommand = 'node tool/verify_mathlive_runtime.mjs';
  static const String activeRuntimeTruthSource = 'v172Q169CurrentRuntimeTruth';

  static const String legacyQ169R8PaintPendingReason = 'paint-pending-empty-value';
  static const String nativeQ169R27PaintPendingReason = 'paint-pending-empty-native-value';

  static const List<String> mustPassPackageVerifiers = <String>[
    'tool/verify_mathlive_single_source_bridge_rewrite_v172_q169r23.mjs',
    'tool/verify_mathlive_mount_authority_reset_v172_q169r24.mjs',
    'tool/verify_mathlive_single_command_bus_authority_v172_q169r25.mjs',
    'tool/verify_mathlive_insert_value_commit_authority_v172_q169r26.mjs',
    'tool/verify_mathlive_native_paint_ownership_authority_v172_q169r27.mjs',
    'tool/verify_mathlive_static_hygiene_runtime_truth_repair_v172_q169r28.mjs',
  ];
}
