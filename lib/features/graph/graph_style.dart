import 'package:flutter/material.dart';

class GraphStyle {
  const GraphStyle._();

  // V56 unified Graphite Glass Pro panel language.
  // The graph stack is intentionally quieter than neon: graphite glass panels,
  // titanium-soft borders, restrained teal curves, and readable low-contrast grid.
  static const Color appBackground = Color(0xFF050607);
  static const Color card = Color(0xFF0D1012);
  static const Color cardAlt = Color(0xFF14181A);
  static const Color canvas = Color(0xFF060809);
  static const Color canvasAlt = Color(0xFF0B0E10);
  static const Color border = Color(0xFF252B30);
  static const Color graphiteLine = Color.fromRGBO(224, 235, 238, 0.115);
  static const Color tealBorder = Color.fromRGBO(116, 190, 180, 0.28);
  static const Color accent = Color(0xFF74BEB4);
  static const Color accentMuted = Color(0xFF5FAEA2);
  static const Color gridMinor = Color(0xFF14191B);
  static const Color gridMajor = Color(0xFF232C30);
  static const Color axis = Color(0xFF7F8A8E);
  static const Color axisLabel = Color(0xFFADB5B8);
  static const Color curve = Color(0xFF78F2E6);
  static const Color secondCurve = Color(0xFFE08A24);
  static const Color blue = Color(0xFF6FA9F8);
  static const Color text = Color(0xFFF4F6F6);
  static const Color textSecondary = Color(0xFFA0A8AA);
  static const Color danger = Color(0xFFFF5A52);

  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(24));

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF14181A),
      Color(0xFF0D1012),
      Color(0xFF07090A),
    ],
    stops: <double>[0.0, 0.54, 1.0],
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF0B0F11),
      Color(0xFF07090A),
      Color(0xFF050607),
    ],
    stops: <double>[0.0, 0.58, 1.0],
  );


  static const LinearGradient premiumSurfaceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF10171A),
      Color(0xFF080D0F),
      Color(0xFF040607),
    ],
    stops: <double>[0.0, 0.58, 1.0],
  );

  static const LinearGradient controlGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color.fromRGBO(255, 255, 255, 0.075),
      Color.fromRGBO(255, 255, 255, 0.030),
      Color.fromRGBO(116, 190, 180, 0.075),
    ],
    stops: <double>[0.0, 0.58, 1.0],
  );

  static List<BoxShadow> get cardShadow => const <BoxShadow>[
        BoxShadow(
          blurRadius: 30,
          spreadRadius: -14,
          color: Color.fromRGBO(0, 0, 0, 0.66),
          offset: Offset(0, 18),
        ),
        BoxShadow(
          blurRadius: 1,
          spreadRadius: 0,
          color: Color.fromRGBO(255, 255, 255, 0.040),
          offset: Offset(0, -1),
        ),
      ];

  static List<BoxShadow> cardShadowFor(bool active) => <BoxShadow>[
        const BoxShadow(
          blurRadius: 30,
          spreadRadius: -14,
          color: Color.fromRGBO(0, 0, 0, 0.68),
          offset: Offset(0, 18),
        ),
        BoxShadow(
          blurRadius: active ? 22 : 14,
          spreadRadius: active ? -10 : -12,
          color: accent.withValues(alpha: active ? 0.22 : 0.105),
          offset: Offset.zero,
        ),
        const BoxShadow(
          blurRadius: 1,
          spreadRadius: 0,
          color: Color.fromRGBO(255, 255, 255, 0.050),
          offset: Offset(0, -1),
        ),
      ];

  static List<BoxShadow> get surfaceShadow => const <BoxShadow>[
        BoxShadow(
          blurRadius: 16,
          spreadRadius: -10,
          color: Color.fromRGBO(0, 0, 0, 0.54),
          offset: Offset(0, 10),
        ),
      ];

  static List<BoxShadow> controlShadow({bool active = false}) => <BoxShadow>[
        BoxShadow(
          blurRadius: active ? 16 : 10,
          spreadRadius: active ? -7 : -8,
          color: active ? accent.withValues(alpha: 0.18) : const Color.fromRGBO(0, 0, 0, 0.30),
          offset: active ? Offset.zero : const Offset(0, 6),
        ),
      ];
}
