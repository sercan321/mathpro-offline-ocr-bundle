/// V172-Q170 — MathLive Premium Layout & Visual Polish Court.
///
/// This phase is intentionally visual/production-surface only. It suppresses
/// user-facing diagnostic overlays, tightens MathLive viewport/placeholder CSS,
/// and keeps the official MathLive math-field as the renderer. It does not
/// mutate protected keyboard layout, MORE order, long-press order, AppShell,
/// Graph, History, Solution, or solver behavior.
class MathLivePremiumLayoutVisualPolishPolicy {
  const MathLivePremiumLayoutVisualPolishPolicy._();

  static const String phase = 'V172-Q170';
  static const bool visualPolishOnly = true;
  static const bool userFacingDiagnosticOverlayAllowed = false;
  static const bool debugDiagnosticsRemainInternal = true;
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool appShellMutationAllowed = false;
  static const bool graphHistorySolutionMutationAllowed = false;
  static const bool mathLiveNativeRendererRequired = true;
  static const bool flutterFallbackMayClaimPremium = false;
  static const bool realDevicePremiumPassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> protectedSurfaces = <String>[
    'lib/app/app_shell.dart',
    'lib/features/keyboard/key_config.dart',
    'lib/features/keyboard/math_keyboard.dart',
    'lib/features/keyboard/bottom_dock.dart',
    'lib/features/keyboard/long_press_popup.dart',
    'lib/features/keyboard/premium_key.dart',
    'lib/features/workspace/math_label.dart',
    'lib/features/workspace/template_tray.dart',
    'lib/features/solution/solution_steps_panel.dart',
    'lib/features/graph/graph_card.dart',
    'lib/features/history/history_controller.dart',
    'lib/features/history/history_panel.dart',
  ];
}
