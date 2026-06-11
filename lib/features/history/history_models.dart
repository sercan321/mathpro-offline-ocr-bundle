import 'package:flutter/foundation.dart';

import '../graph/graph_models.dart';

enum HistoryEntryKind {
  calculation,
  graph,
  error,
}

@immutable
class HistoryEntry {
  const HistoryEntry({
    required this.id,
    required this.expression,
    required this.result,
    required this.tabName,
    required this.timestamp,
    this.graphExpression,
    this.pinned = false,
    this.errorState,
  });

  final String id;
  final String expression;
  final String result;
  final String tabName;
  final DateTime timestamp;
  final GraphExpression? graphExpression;
  final bool pinned;
  final String? errorState;

  bool get hasGraph => graphExpression != null;
  bool get hasError => (errorState ?? '').trim().isNotEmpty;

  HistoryEntryKind get kind {
    if (hasError) return HistoryEntryKind.error;
    if (hasGraph) return HistoryEntryKind.graph;
    return HistoryEntryKind.calculation;
  }

  String get kindLabel {
    switch (kind) {
      case HistoryEntryKind.error:
        return 'Hata';
      case HistoryEntryKind.graph:
        return 'Grafik';
      case HistoryEntryKind.calculation:
        return 'Hesap';
    }
  }

  String get resultLabel {
    switch (kind) {
      case HistoryEntryKind.error:
        final reason = (errorState ?? '').trim();
        return reason.isEmpty ? 'İşlem tamamlanamadı' : reason;
      case HistoryEntryKind.graph:
        return 'Grafik çizildi';
      case HistoryEntryKind.calculation:
        return '= $result';
    }
  }

  String get compactMetaLabel => '$tabName • ${formatTime(timestamp)}';

  String get graphRangeLabel {
    final graph = graphExpression;
    if (graph == null) return '';
    return 'x: ${_compactNumber(graph.xMin)}…${_compactNumber(graph.xMax)}  y: ${_compactNumber(graph.yMin)}…${_compactNumber(graph.yMax)}';
  }

  String get graphTraceLabel {
    final graph = graphExpression;
    if (graph == null) return '';
    return graph.traceEnabled ? 'Trace açık' : 'Trace kapalı';
  }

  String get graphStorageKey {
    final graph = graphExpression;
    if (graph == null) return '';
    return graph.historyIdentityKey;
  }

  bool get canUseResult {
    final clean = result.trim();
    return kind == HistoryEntryKind.calculation && clean.isNotEmpty && clean != '—';
  }

  String get copyPayload {
    switch (kind) {
      case HistoryEntryKind.error:
        return '$expression\n${resultLabel.trim()}';
      case HistoryEntryKind.graph:
        final graph = graphExpression;
        final graphLine = graph == null ? 'Grafik çizildi' : '${graph.displayExpression}\n$graphRangeLabel\n$graphTraceLabel';
        return '$expression\n$graphLine';
      case HistoryEntryKind.calculation:
        return '$expression\n= $result';
    }
  }

  String get searchText {
    final graph = graphExpression;
    return <String>[
      expression,
      result,
      tabName,
      kindLabel,
      if (errorState != null) errorState!,
      if (graph != null) graph.displayExpression,
      if (graph != null) graph.normalizedExpression,
      if (graph != null) graph.type.name,
      graphRangeLabel,
      graphTraceLabel,
    ].join(' ').toLowerCase();
  }

  String get dedupeSignature {
    final graph = graphExpression;
    return <String>[
      kind.name,
      expression.trim(),
      result.trim(),
      if (graph != null) graph.normalizedExpression.trim(),
      if (errorState != null) errorState!.trim(),
    ].join('|');
  }

  HistoryEntry copyWith({
    String? expression,
    String? result,
    String? tabName,
    DateTime? timestamp,
    GraphExpression? graphExpression,
    bool? pinned,
    String? errorState,
  }) {
    return HistoryEntry(
      id: id,
      expression: expression ?? this.expression,
      result: result ?? this.result,
      tabName: tabName ?? this.tabName,
      timestamp: timestamp ?? this.timestamp,
      graphExpression: graphExpression ?? this.graphExpression,
      pinned: pinned ?? this.pinned,
      errorState: errorState ?? this.errorState,
    );
  }

  Map<String, Object?> toJson() => <String, Object?>{
        'id': id,
        'expression': expression,
        'result': result,
        'tabName': tabName,
        'timestamp': timestamp.toIso8601String(),
        'graphExpression': graphExpression?.toJson(),
        'pinned': pinned,
        'errorState': errorState,
      };

  static HistoryEntry? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final map = Map<String, Object?>.from(raw);
    final id = map['id'] as String?;
    final expression = map['expression'] as String?;
    final result = map['result'] as String?;
    final tabName = map['tabName'] as String?;
    final timestampRaw = map['timestamp'] as String?;
    final timestamp = timestampRaw == null ? null : DateTime.tryParse(timestampRaw);
    if (id == null || expression == null || result == null || tabName == null || timestamp == null) return null;
    return HistoryEntry(
      id: id,
      expression: expression,
      result: result,
      tabName: tabName,
      timestamp: timestamp,
      graphExpression: GraphExpression.fromJson(map['graphExpression']),
      pinned: map['pinned'] as bool? ?? false,
      errorState: map['errorState'] as String?,
    );
  }

  static String formatTime(DateTime value) => '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';

  static String _compactNumber(double value) {
    if (value.abs() >= 1000 || (value.abs() < 0.01 && value != 0)) return value.toStringAsExponential(2);
    var fixed = value.toStringAsFixed(value.abs() < 10 ? 2 : 1);
    while (fixed.contains('.') && fixed.endsWith('0')) {
      fixed = fixed.substring(0, fixed.length - 1);
    }
    if (fixed.endsWith('.')) fixed = fixed.substring(0, fixed.length - 1);
    return fixed;
  }
}

@immutable
class HistorySection {
  const HistorySection({required this.title, required this.entries});

  final String title;
  final List<HistoryEntry> entries;
}
