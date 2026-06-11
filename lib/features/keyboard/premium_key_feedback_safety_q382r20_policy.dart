/// V172-Q382R20: keeps MathPro keyboard input feedback fast without changing
/// the keyboard contract.  This policy intentionally does not move command
/// dispatch to onTapDown because long-press/template/focus semantics are more
/// important than a speculative early-fire optimization.
class PremiumKeyFeedbackSafetyQ382R20Policy {
  const PremiumKeyFeedbackSafetyQ382R20Policy._();

  static const String phase = 'V172-Q382R20';

  /// Command dispatch remains on GestureDetector.onTap so long-press and
  /// MathLive focus semantics keep their established behavior.
  static const bool commandDispatchRemainsOnTap = true;

  /// The expensive decoration tween was removed from the hot key path.  Pressed
  /// visuals now switch decoration instantly while the lighter scale feedback
  /// preserves the premium tactile feel.
  static const bool animatedContainerRemovedFromPremiumKeyHotPath = true;

  /// Keep one lightweight transform animation only.
  static const Duration pressedScaleDuration = Duration(milliseconds: 48);

  /// Long-press behavior, popup lists, labels and layout are outside this phase.
  static const bool longPressContractPreserved = true;
  static const bool keyboardLayoutPreserved = true;
}
