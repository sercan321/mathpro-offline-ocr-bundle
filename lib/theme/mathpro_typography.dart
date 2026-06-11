import 'package:flutter/material.dart';

import 'mathpro_tokens.dart';

@immutable
class MathProTypography {
  const MathProTypography._();

  static const String mathFontFamily = 'serif';

  static const TextStyle keyText = TextStyle(
    color: MathProColors.text,
    fontSize: 15.8,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.20,
    height: 1.02,
  );

  static const TextStyle keyTextExpanded = TextStyle(
    color: MathProColors.text,
    fontSize: 12.7,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.14,
    height: 1.02,
  );

  static const TextStyle tabText = TextStyle(
    color: MathProColors.textFaint,
    fontSize: 10.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.02,
    height: 1.0,
  );

  static const TextStyle resultText = TextStyle(
    color: MathProColors.text,
    fontSize: 40,
    fontWeight: FontWeight.w800,
    letterSpacing: -1,
    height: 1.15,
  );

  static const TextStyle editorExpression = TextStyle(
    color: MathProColors.text,
    fontSize: 35,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.7,
    height: 1.12,
  );

  static const TextStyle workspaceHint = TextStyle(
    color: MathProColors.textFaint,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.08,
  );
}
