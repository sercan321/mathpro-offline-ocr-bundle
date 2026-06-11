import 'package:flutter/material.dart';

@immutable
class MathProColors {
  const MathProColors._();

  // V46 Elite Premium Plus micro-polish palette.
  // The palette deliberately avoids gamer-neon effects: it uses quiet graphite,
  // ceramic blacks, titanium borders, amber control emphasis and restrained teal.
  static const Color bg = Color(0xFF050607);
  static const Color bgElevated = Color(0xFF080A0B);
  static const Color panel = Color.fromRGBO(15, 17, 19, 0.97);
  static const Color panelStrong = Color.fromRGBO(10, 12, 14, 0.985);
  static const Color overlay = Color.fromRGBO(255, 255, 255, 0.032);
  static const Color surface = Color(0xFF0F1214);
  static const Color surfaceAlt = Color(0xFF161A1D);
  static const Color surfaceSoft = Color(0xFF20262A);

  static const Color keyPrimary = Color(0xFF15191C);
  static const Color keySecondary = Color(0xFF22272B);
  static const Color keyTertiary = Color(0xFF0B0D0F);

  static const Color border = Color.fromRGBO(222, 232, 235, 0.130);
  static const Color borderSoft = Color.fromRGBO(222, 232, 235, 0.082);

  static const Color text = Color(0xFFF4F6F6);
  static const Color textSoft = Color(0xFFD9DEDD);
  static const Color textMuted = Color(0xFFABB4B5);
  static const Color textFaint = Color(0xFF858E90);

  static const Color accent = Color(0xFF74BEB4);
  static const Color accentSoft = Color.fromRGBO(116, 190, 180, 0.16);
  static const Color accentStrong = Color(0xFF57988E);

  static const Color danger = Color(0xFFE08A24);
  static const Color dangerSoft = Color.fromRGBO(224, 138, 36, 0.16);
}

@immutable
class MathProRadius {
  const MathProRadius._();

  static const double xs = 10;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 28;
  static const double pill = 999;
}

@immutable
class MathProSpacing {
  const MathProSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

@immutable
class MathProTypographyTokens {
  const MathProTypographyTokens._();

  static const double tight = -0.4;
  static const double normal = 0;
  static const double button = 0.3;
  static const double label = 0.8;
}

@immutable
class MathProShadows {
  const MathProShadows._();

  static List<BoxShadow> get card => const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.58),
          blurRadius: 30,
          spreadRadius: -13,
          offset: Offset(0, 20),
        ),
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.042),
          blurRadius: 1,
          offset: Offset(0, -1),
        ),
      ];

  static List<BoxShadow> get dock => const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.48),
          blurRadius: 22,
          spreadRadius: -11,
          offset: Offset(0, 14),
        ),
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.020),
          blurRadius: 1,
          offset: Offset(0, -1),
        ),
      ];

  static List<BoxShadow> get key => const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.34),
          blurRadius: 11,
          spreadRadius: -5,
          offset: Offset(0, 6),
        ),
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, 0.025),
          blurRadius: 1,
          offset: Offset(0, -1),
        ),
      ];

  static List<BoxShadow> get actionKey => const [
        BoxShadow(
          color: Color.fromRGBO(116, 190, 180, 0.22),
          blurRadius: 13,
          spreadRadius: -6,
          offset: Offset(0, 6),
        ),
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.32),
          blurRadius: 8,
          spreadRadius: -4,
          offset: Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get templateKey => const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.26),
          blurRadius: 9,
          spreadRadius: -4,
          offset: Offset(0, 5),
        ),
        BoxShadow(
          color: Color.fromRGBO(116, 190, 180, 0.045),
          blurRadius: 9,
          spreadRadius: -4,
          offset: Offset(0, 3),
        ),
      ];

  static List<BoxShadow> get keyPressed => const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.18),
          blurRadius: 4,
          spreadRadius: -2,
          offset: Offset(0, 2),
        ),
      ];
}
