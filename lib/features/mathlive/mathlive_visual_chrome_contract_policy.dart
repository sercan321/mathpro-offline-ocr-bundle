/// V172-Q149 — MathLive visual chrome contract sweep.
///
/// The main editor may use MathLive internally, but the user-facing surface must
/// look like MathPro: no visible MathLive badge, keyboard toggle, menu toggle,
/// debug loading label, or native keyboard chrome may cover the expression.
class MathLiveVisualChromeContractPolicy {
  const MathLiveVisualChromeContractPolicy._();

  static const String phase = 'V172-Q149';
  static const bool visibleMathLiveBrandingAllowed = false;
  static const bool visibleVirtualKeyboardToggleAllowed = false;
  static const bool visibleMenuToggleAllowed = false;
  static const bool debugBadgeAllowedInMainEditor = false;
  static const bool nativeKeyboardChromeAllowed = false;
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedLongPressMutationAllowed = false;
  static const bool protectedGraphHistorySolutionMutationAllowed = false;
  static const bool realDevicePassClaimed = false;
  static const bool photomathLevelClaimed = false;

  static const List<String> suppressedChromeFamilies = <String>[
    'MathLive badge/debug label',
    'virtual keyboard toggle',
    'menu toggle',
    'keyboard/menu shadow-root buttons',
    'visible runtime loading brand text',
  ];

  static bool isSuppressedChromeFamily(String value) =>
      suppressedChromeFamilies.contains(value);
}
