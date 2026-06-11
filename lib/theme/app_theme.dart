import 'package:flutter/material.dart';

import 'mathpro_tokens.dart';

@immutable
class MathProTheme {
  const MathProTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: MathProColors.bg,
      colorScheme: const ColorScheme.dark(
        surface: MathProColors.surface,
        primary: MathProColors.accent,
        secondary: MathProColors.accentStrong,
        error: MathProColors.danger,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: MathProColors.accent,
        selectionColor: MathProColors.accentSoft,
      ),
    );
  }
}
