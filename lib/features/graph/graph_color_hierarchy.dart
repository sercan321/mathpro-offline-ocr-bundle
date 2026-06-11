import 'package:flutter/material.dart';

import 'graph_style.dart';

@immutable
class GraphFunctionColorOption {
  const GraphFunctionColorOption({required this.key, required this.label, required this.color});

  final String key;
  final String label;
  final Color color;
}

@immutable
class GraphLayerPalette {
  const GraphLayerPalette({
    required this.curveStrokeColor,
    required this.curveGlowColor,
    required this.axisStrokeColor,
    required this.axisTickColor,
    required this.axisLabelColor,
    required this.gridMinorColor,
    required this.gridMajorColor,
    required this.surfaceMeshColor,
    required this.surfaceEdgeColor,
  });

  final Color curveStrokeColor;
  final Color curveGlowColor;
  final Color axisStrokeColor;
  final Color axisTickColor;
  final Color axisLabelColor;
  final Color gridMinorColor;
  final Color gridMajorColor;
  final Color surfaceMeshColor;
  final Color surfaceEdgeColor;

  static GraphLayerPalette fromCurveColor(Color curveColor, {bool compact = false}) {
    const gridBase = Color(0xFF94A5A8);
    const axisBase = Color(0xFFC5D0D2);
    final meshBase = Color.lerp(curveColor, Colors.white, 0.18)!;
    return GraphLayerPalette(
      curveStrokeColor: curveColor,
      curveGlowColor: curveColor.withValues(alpha: compact ? 0.12 : 0.16),
      axisStrokeColor: axisBase.withValues(alpha: compact ? 0.34 : 0.42),
      axisTickColor: axisBase.withValues(alpha: compact ? 0.22 : 0.31),
      axisLabelColor: GraphStyle.axisLabel.withValues(alpha: compact ? 0.62 : 0.74),
      gridMinorColor: gridBase.withValues(alpha: compact ? 0.075 : 0.105),
      gridMajorColor: gridBase.withValues(alpha: compact ? 0.135 : 0.185),
      surfaceMeshColor: meshBase.withValues(alpha: compact ? 0.20 : 0.27),
      surfaceEdgeColor: curveColor.withValues(alpha: compact ? 0.50 : 0.66),
    );
  }
}

class GraphFunctionColorPalette {
  const GraphFunctionColorPalette._();

  static const String defaultKey = 'aquaTeal';
  static const Color defaultColor = Color(0xFF78F2E6);

  static const List<GraphFunctionColorOption> options = <GraphFunctionColorOption>[
    GraphFunctionColorOption(key: 'aquaTeal', label: 'Aqua Teal', color: Color(0xFF78F2E6)),
    GraphFunctionColorOption(key: 'iceBlue', label: 'Ice Blue', color: Color(0xFF6EA8FF)),
    GraphFunctionColorOption(key: 'violet', label: 'Violet', color: Color(0xFFB88CFF)),
    GraphFunctionColorOption(key: 'rose', label: 'Rose', color: Color(0xFFFF7AC8)),
    GraphFunctionColorOption(key: 'softAmber', label: 'Soft Amber', color: Color(0xFFFFC857)),
    GraphFunctionColorOption(key: 'mint', label: 'Mint', color: Color(0xFF8DFFB3)),
    GraphFunctionColorOption(key: 'coralRed', label: 'Coral Red', color: Color(0xFFFF6B6B)),
    GraphFunctionColorOption(key: 'pearl', label: 'Pearl', color: Color(0xFFE8EEF2)),
  ];

  static GraphFunctionColorOption byKey(String? key) {
    for (final option in options) {
      if (option.key == key) return option;
    }
    return options.first;
  }

  static GraphFunctionColorOption byColor(Color color) {
    for (final option in options) {
      if (option.color.toARGB32() == color.toARGB32()) return option;
    }
    return options.first;
  }

  static String keyForColor(Color color) => byColor(color).key;

  static Color colorForKey(String? key) => byKey(key).color;
}

class GraphSurfaceColorRamp {
  const GraphSurfaceColorRamp._();

  static const List<Color> _baseStops = <Color>[
    Color(0xFF2563FF),
    Color(0xFF00C8FF),
    Color(0xFF37E6A4),
    Color(0xFFF4E04D),
    Color(0xFFFF9E3D),
    Color(0xFFFF5B4A),
  ];

  static Color colorAt(double value, Color accent, {double alpha = 0.74}) {
    final t = value.clamp(0.0, 1.0).toDouble();
    final scaled = t * (_baseStops.length - 1);
    final lower = scaled.floor().clamp(0, _baseStops.length - 1);
    final upper = (lower + 1).clamp(0, _baseStops.length - 1);
    final localT = scaled - lower;
    final base = Color.lerp(_baseStops[lower], _baseStops[upper], localT)!;
    final accentInfluence = 0.10 + (1.0 - (t - 0.5).abs() * 2).clamp(0.0, 1.0) * 0.12;
    return Color.lerp(base, accent, accentInfluence)!.withValues(alpha: alpha);
  }
}
