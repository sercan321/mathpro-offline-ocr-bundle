import 'dart:async';

import 'package:flutter/foundation.dart';

import '../graph/graph_models.dart';
import 'history_models.dart';
import 'history_storage.dart';

class HistoryController extends ChangeNotifier {
  HistoryController({bool enablePersistence = true}) : _enablePersistence = enablePersistence {
    if (_enablePersistence) {
      _restoreTask = _restorePersisted();
    } else {
      _restored = true;
      _restoreTask = Future<void>.value();
    }
  }

  final bool _enablePersistence;
  final List<HistoryEntry> _entries = <HistoryEntry>[];
  bool _restored = false;
  bool _disposed = false;
  late final Future<void> _restoreTask;
  Future<void>? _lastPersistTask;

  List<HistoryEntry> get entries => List<HistoryEntry>.unmodifiable(_entries);
  bool get restored => _restored;
  Future<void> get restoreCompleted => _restoreTask;
  Future<void> get persistCompleted => _lastPersistTask ?? Future<void>.value();

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  HistoryEntry? entryById(String id) {
    for (final entry in _entries) {
      if (entry.id == id) return entry;
    }
    return null;
  }

  void addCalculation({
    required String expression,
    required String result,
    required String tabName,
    String? errorState,
  }) {
    if (expression.trim().isEmpty) return;
    _prepend(HistoryEntry(
      id: _newId(),
      expression: expression,
      result: result,
      tabName: tabName,
      timestamp: DateTime.now(),
      errorState: errorState,
    ));
  }

  HistoryEntry addGraph({required GraphExpression graphExpression, required String result, required String tabName}) {
    final safeResult = result.trim().isEmpty ? '—' : result;
    final existingIndex = _entries.indexWhere((entry) {
      final existingGraph = entry.graphExpression;
      return existingGraph != null && existingGraph.historyIdentityKey == graphExpression.historyIdentityKey;
    });

    if (existingIndex >= 0) {
      final previous = _entries.removeAt(existingIndex);
      final updated = previous.copyWith(
        expression: graphExpression.displayExpression,
        result: safeResult,
        tabName: tabName,
        timestamp: DateTime.now(),
        graphExpression: graphExpression,
        errorState: '',
      );
      _entries.insert(0, updated);
      _commitMutation();
      return updated;
    }

    final entry = HistoryEntry(
      id: _newId(),
      expression: graphExpression.displayExpression,
      result: safeResult,
      tabName: tabName,
      timestamp: DateTime.now(),
      graphExpression: graphExpression,
    );
    _entries.insert(0, entry);
    _commitMutation();
    return entry;
  }

  HistoryEntry? updateGraphEntry({
    required String id,
    required GraphExpression graphExpression,
    String? result,
    String? tabName,
    bool moveToTop = false,
  }) {
    final index = _entries.indexWhere((entry) => entry.id == id);
    if (index < 0) return null;
    final previous = _entries[index];
    if (!previous.hasGraph) return null;

    final updated = previous.copyWith(
      expression: graphExpression.displayExpression,
      result: result == null || result.trim().isEmpty ? previous.result : result,
      tabName: tabName ?? previous.tabName,
      graphExpression: graphExpression,
      errorState: '',
    );

    if (moveToTop) {
      _entries.removeAt(index);
      _entries.insert(0, updated);
    } else {
      _entries[index] = updated;
    }
    _commitMutation();
    return updated;
  }

  void clear() {
    clearAndReturn();
  }

  List<HistoryEntry> clearAndReturn() {
    if (_entries.isEmpty) return const <HistoryEntry>[];
    final removed = List<HistoryEntry>.from(_entries, growable: false);
    _entries.clear();
    _persist();
    notifyListeners();
    return removed;
  }

  HistoryEntry? delete(String id) {
    final index = _entries.indexWhere((entry) => entry.id == id);
    if (index < 0) return null;
    final removed = _entries.removeAt(index);
    _persist();
    notifyListeners();
    return removed;
  }

  void restoreDeleted(HistoryEntry entry, {int index = 0}) {
    if (_entries.any((current) => current.id == entry.id)) return;
    final safeIndex = index.clamp(0, _entries.length).toInt();
    _entries.insert(safeIndex, entry);
    _trimToLimit();
    _persist();
    notifyListeners();
  }

  void restoreBatch(List<HistoryEntry> entries) {
    if (entries.isEmpty) return;
    final existingIds = _entries.map((entry) => entry.id).toSet();
    final merged = <HistoryEntry>[
      ...entries.where((entry) => !existingIds.contains(entry.id)),
      ..._entries,
    ];
    _entries
      ..clear()
      ..addAll(merged.take(HistoryStorage.maxStoredEntries));
    _persist();
    notifyListeners();
  }

  void togglePinned(String id) {
    final index = _entries.indexWhere((entry) => entry.id == id);
    if (index < 0) return;
    _entries[index] = _entries[index].copyWith(pinned: !_entries[index].pinned);
    _persist();
    notifyListeners();
  }

  List<HistorySection> sections({String query = ''}) {
    final filtered = _filter(query);
    final pinned = filtered.where((entry) => entry.pinned).toList(growable: false);
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    final pinnedIds = pinned.map((entry) => entry.id).toSet();
    final unpinned = filtered.where((entry) => !pinnedIds.contains(entry.id)).toList(growable: false);
    final sections = <HistorySection>[];
    if (pinned.isNotEmpty) sections.add(HistorySection(title: 'Sabitlenenler', entries: pinned));
    _addSection(sections, 'Bugün', unpinned.where((entry) => _sameDay(entry.timestamp, today)).toList(growable: false));
    _addSection(sections, 'Dün', unpinned.where((entry) => _sameDay(entry.timestamp, yesterday)).toList(growable: false));
    _addSection(
      sections,
      'Son 7 Gün',
      unpinned
          .where((entry) => !_sameDay(entry.timestamp, today) && !_sameDay(entry.timestamp, yesterday) && today.difference(entry.timestamp).inDays < 7)
          .toList(growable: false),
    );
    _addSection(sections, 'Daha Eski', unpinned.where((entry) => today.difference(entry.timestamp).inDays >= 7).toList(growable: false));
    return sections;
  }

  List<HistoryEntry> _filter(String query) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return List<HistoryEntry>.from(_entries, growable: false);
    return _entries.where((entry) {
      return entry.searchText.contains(needle);
    }).toList(growable: false);
  }

  Future<void> _restorePersisted() async {
    final restoredEntries = await HistoryStorage.restore();
    if (_disposed) return;
    final existingIds = _entries.map((entry) => entry.id).toSet();
    for (final entry in restoredEntries) {
      if (!existingIds.add(entry.id)) continue;
      if (_entries.length >= HistoryStorage.maxStoredEntries) break;
      _entries.add(entry);
    }
    _entries.sort((a, b) {
      if (a.pinned != b.pinned) return a.pinned ? -1 : 1;
      return b.timestamp.compareTo(a.timestamp);
    });
    _trimToLimit();
    _restored = true;
    if (!_disposed) notifyListeners();
  }

  void _prepend(HistoryEntry entry) {
    _entries.removeWhere((existing) => existing.dedupeSignature == entry.dedupeSignature);
    _entries.insert(0, entry);
    _commitMutation();
  }

  void _commitMutation() {
    _trimToLimit();
    _persist();
    notifyListeners();
  }

  void _trimToLimit() {
    if (_entries.length > HistoryStorage.maxStoredEntries) {
      _entries.removeRange(HistoryStorage.maxStoredEntries, _entries.length);
    }
  }

  void _persist() {
    if (!_enablePersistence || _disposed) return;
    _lastPersistTask = HistoryStorage.save(_entries);
  }

  static void _addSection(List<HistorySection> sections, String title, List<HistoryEntry> entries) {
    if (entries.isNotEmpty) sections.add(HistorySection(title: title, entries: entries));
  }

  static bool _sameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

  static int _idSequence = 0;

  static String _newId() {
    _idSequence = (_idSequence + 1) & 0xFFFFFF;
    return '${DateTime.now().microsecondsSinceEpoch}_$_idSequence';
  }
}
