import 'package:flutter/material.dart';

import 'graph_color_hierarchy.dart';

enum GraphEligibilityKind {
  graphableExplicit,
  constantSuggestion,
  implicitPending,
  notGraphable,
}

enum GraphType {
  explicit,
  constant,
  implicitPending,
}

enum GraphRenderMode {
  twoD,
  threeD,
}

@immutable
class GraphEligibilityResult {
  const GraphEligibilityResult({
    required this.kind,
    required this.message,
    this.normalizedExpression,
    this.constantValue,
  });

  final GraphEligibilityKind kind;
  final String message;
  final String? normalizedExpression;
  final double? constantValue;

  bool get canOpenDirectly => kind == GraphEligibilityKind.graphableExplicit;
  bool get asksForConstant => kind == GraphEligibilityKind.constantSuggestion;
}

@immutable
class GraphExpression {
  const GraphExpression({
    required this.originalExpression,
    required this.normalizedExpression,
    required this.type,
    this.xMin = -10,
    this.xMax = 10,
    this.yMin = -10,
    this.yMax = 10,
    this.traceEnabled = false,
    this.showGrid = true,
    this.showAxes = true,
    this.graphColor = GraphFunctionColorPalette.defaultColor,
    this.graphColorKey = GraphFunctionColorPalette.defaultKey,
  });

  final String originalExpression;
  final String normalizedExpression;
  final GraphType type;
  final double xMin;
  final double xMax;
  final double yMin;
  final double yMax;
  final bool traceEnabled;
  final bool showGrid;
  final bool showAxes;
  final Color graphColor;
  final String graphColorKey;

  bool get prefersThreeDimensionalSurface {
    final originalCompact = originalExpression.trim().toLowerCase();
    final normalizedCompact = normalizedExpression.trim().toLowerCase();
    return RegExp(r'^\s*z\s*=').hasMatch(originalCompact) || _containsGraphVariable(normalizedCompact, 'y');
  }

  GraphRenderMode get preferredRenderMode => prefersThreeDimensionalSurface ? GraphRenderMode.threeD : GraphRenderMode.twoD;

  String get displayExpression {
    if (type == GraphType.constant) return 'y = $normalizedExpression';
    final compact = normalizedExpression.trim().replaceAll(' ', '');
    if (compact.startsWith('y=')) {
      return normalizedExpression.replaceFirst(RegExp(r'^\s*y\s*='), 'y = ');
    }
    return 'y = $normalizedExpression';
  }

  String displayExpressionFor(GraphRenderMode renderMode) {
    if (renderMode == GraphRenderMode.threeD || prefersThreeDimensionalSurface) {
      final surface = normalizedExpression.trim().replaceFirst(RegExp(r'^\s*[yz]\s*=', caseSensitive: false), '').trim();
      return 'z = ${surface.isEmpty ? '0' : surface}';
    }
    return displayExpression;
  }

  static bool _containsGraphVariable(String expression, String variable) {
    return RegExp('(^|[^a-zA-Z])$variable([^a-zA-Z]|\$)').hasMatch(expression);
  }

  String get historyIdentityKey {
    final normalized = normalizedExpression.toLowerCase().replaceAll(RegExp(r'\s+'), '');
    return '${type.name}|$normalized';
  }

  GraphExpression copyWith({
    String? originalExpression,
    String? normalizedExpression,
    GraphType? type,
    double? xMin,
    double? xMax,
    double? yMin,
    double? yMax,
    bool? traceEnabled,
    bool? showGrid,
    bool? showAxes,
    Color? graphColor,
    String? graphColorKey,
  }) {
    final resolvedColor = graphColor ?? this.graphColor;
    return GraphExpression(
      originalExpression: originalExpression ?? this.originalExpression,
      normalizedExpression: normalizedExpression ?? this.normalizedExpression,
      type: type ?? this.type,
      xMin: xMin ?? this.xMin,
      xMax: xMax ?? this.xMax,
      yMin: yMin ?? this.yMin,
      yMax: yMax ?? this.yMax,
      traceEnabled: traceEnabled ?? this.traceEnabled,
      showGrid: showGrid ?? this.showGrid,
      showAxes: showAxes ?? this.showAxes,
      graphColor: resolvedColor,
      graphColorKey: graphColorKey ?? (graphColor == null ? this.graphColorKey : GraphFunctionColorPalette.keyForColor(resolvedColor)),
    );
  }

  GraphExpression resetViewport() {
    if (type == GraphType.constant) {
      final constant = double.tryParse(normalizedExpression.replaceAll(',', '.')) ?? 0;
      final low = constant - 5;
      final high = constant + 5;
      return copyWith(xMin: -10, xMax: 10, yMin: low == high ? low - 1 : low, yMax: low == high ? high + 1 : high);
    }
    return copyWith(xMin: -10, xMax: 10, yMin: -10, yMax: 10);
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'originalExpression': originalExpression,
        'normalizedExpression': normalizedExpression,
        'type': type.name,
        'xMin': xMin,
        'xMax': xMax,
        'yMin': yMin,
        'yMax': yMax,
        'traceEnabled': traceEnabled,
        'showGrid': showGrid,
        'showAxes': showAxes,
        'graphColor': graphColor.toARGB32(),
        'graphColorKey': graphColorKey,
      };

  static GraphExpression? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final map = Map<String, Object?>.from(raw);
    final normalizedExpression = map['normalizedExpression'] as String?;
    final originalExpression = map['originalExpression'] as String?;
    if (normalizedExpression == null || originalExpression == null) return null;
    final typeName = map['type'] as String?;
    final type = _typeFromName(typeName);
    final storedColorKey = map['graphColorKey'] as String?;
    final legacyColor = Color((map['graphColor'] as num?)?.toInt() ?? GraphFunctionColorPalette.defaultColor.toARGB32());
    final option = storedColorKey == null ? GraphFunctionColorPalette.byColor(legacyColor) : GraphFunctionColorPalette.byKey(storedColorKey);
    return GraphExpression(
      originalExpression: originalExpression,
      normalizedExpression: normalizedExpression,
      type: type,
      xMin: _num(map['xMin'], -10),
      xMax: _num(map['xMax'], 10),
      yMin: _num(map['yMin'], -10),
      yMax: _num(map['yMax'], 10),
      traceEnabled: map['traceEnabled'] as bool? ?? false,
      showGrid: map['showGrid'] as bool? ?? true,
      showAxes: map['showAxes'] as bool? ?? true,
      graphColor: option.color,
      graphColorKey: option.key,
    );
  }

  static GraphType _typeFromName(String? value) {
    for (final type in GraphType.values) {
      if (type.name == value) return type;
    }
    return GraphType.explicit;
  }

  static double _num(Object? value, double fallback) => value is num ? value.toDouble() : fallback;
}

class GraphViewportPolicy {
  const GraphViewportPolicy._();

  static const double minRange = 0.0001;
  static const double maxRange = 1000000;
  static const double maxAbsValue = 1000000000;

  static String? validateExpression(GraphExpression expression) {
    return validateRange(
      xMin: expression.xMin,
      xMax: expression.xMax,
      yMin: expression.yMin,
      yMax: expression.yMax,
    );
  }

  static String? validateRange({
    required double xMin,
    required double xMax,
    required double yMin,
    required double yMax,
  }) {
    final values = <double>[xMin, xMax, yMin, yMax];
    if (values.any((value) => value.isNaN || value.isInfinite)) {
      return 'Aralık değerleri sonlu sayı olmalı.';
    }
    if (values.any((value) => value.abs() > maxAbsValue)) {
      return 'Aralık değerleri çok büyük. Daha okunabilir bir pencere seç.';
    }
    if (xMin >= xMax || yMin >= yMax) {
      return 'Minimum değer maksimum değerden küçük olmalı.';
    }
    final xRange = xMax - xMin;
    final yRange = yMax - yMin;
    if (xRange < minRange || yRange < minRange) {
      return 'Aralık çok dar. Daha geniş bir grafik penceresi seç.';
    }
    if (xRange > maxRange || yRange > maxRange) {
      return 'Aralık çok geniş. Daha okunabilir bir grafik penceresi seç.';
    }
    return null;
  }

  static GraphExpression sanitize(GraphExpression expression) {
    if (validateExpression(expression) == null) return expression;
    return expression.resetViewport();
  }
}
