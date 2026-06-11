import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';

/// V172-N premium cursor visual polish contract.
///
/// This policy is intentionally visual-only. It does not add an editor loupe,
/// textual Pay/Payda/Üs labels, or the legacy green slot-focus overlay. The
/// no-loupe cursor must feel premium through a restrained caret line, stable
/// blink timing, and quiet glow rather than debug boxes.
class PremiumCursorVisualPolishPolicy {
  const PremiumCursorVisualPolishPolicy._();

  static const String version = 'mathpro-v172n-v172q32-v172q36-premium-cursor-visual-polish-role-scaled-v3';

  static const bool editorLoupeEnabled = false;
  static const bool editorLongPressMenuEnabled = false;
  static const bool greenDebugOverlayEnabled = false;
  static const bool legacySlotBoxAllowed = false;

  static const double minCaretWidth = 1.7;
  static const double maxCaretWidth = 2.35;
  static const double minCaretHeight = 12.0;
  static const double maxCaretHeight = 40.0;

  static const int blinkDurationMs = 690;
  static const double blinkOpacityMin = 0.46;
  static const double blinkOpacityMax = 1.0;

  static double polishedCaretWidth(double rawWidth) {
    return rawWidth.clamp(minCaretWidth, maxCaretWidth).toDouble();
  }

  static double polishedCaretHeight(double rawHeight) {
    return rawHeight.clamp(minCaretHeight, maxCaretHeight).toDouble();
  }

  static Animation<double> blinkOpacity(AnimationController controller) {
    return Tween<double>(begin: blinkOpacityMin, end: blinkOpacityMax).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
    );
  }

  static BoxDecoration caretDecoration() {
    return BoxDecoration(
      color: MathProColors.accent,
      borderRadius: BorderRadius.circular(MathProRadius.pill),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: MathProColors.accent.withValues(alpha: 0.28),
          blurRadius: 8.5,
          spreadRadius: -0.35,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.16),
          blurRadius: 1.8,
          spreadRadius: -0.45,
        ),
      ],
    );
  }
}
