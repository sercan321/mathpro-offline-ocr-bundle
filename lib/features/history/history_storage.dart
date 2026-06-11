import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'history_models.dart';

class HistoryStorage {
  const HistoryStorage._();

  static const String _currentKey = 'mathpro.premium_history.v2';
  static const String _legacyKey = 'mathpro.premium_history.v1';
  static const int schemaVersion = 2;
  static const int maxStoredEntries = 80;

  static Future<List<HistoryEntry>> restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentRaw = prefs.getString(_currentKey);
      final current = _decode(currentRaw, envelopeExpected: true);
      if (current.isNotEmpty) return current;

      final legacyRaw = prefs.getString(_legacyKey);
      final legacy = _decode(legacyRaw, envelopeExpected: false);
      if (legacy.isNotEmpty) {
        await save(legacy);
      }
      return legacy;
    } catch (_) {
      return const <HistoryEntry>[];
    }
  }

  static Future<void> save(List<HistoryEntry> entries) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = encode(entries);
      await prefs.setString(_currentKey, encoded);
      await prefs.remove(_legacyKey);
    } catch (_) {
      // Persistence must never break the calculator runtime. If a platform
      // plugin is unavailable in a test shell, history stays in memory.
    }
  }

  static Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_currentKey);
      await prefs.remove(_legacyKey);
    } catch (_) {
      // Same safety policy as save().
    }
  }

  static String encode(List<HistoryEntry> entries) {
    final bounded = entries.take(maxStoredEntries).map((entry) => entry.toJson()).toList(growable: false);
    return jsonEncode(<String, Object?>{
      'schemaVersion': schemaVersion,
      'savedAt': DateTime.now().toIso8601String(),
      'entries': bounded,
    });
  }

  static List<HistoryEntry> decodeForTest(String? raw) => _decode(raw, envelopeExpected: true);

  static List<HistoryEntry> _decode(String? raw, {required bool envelopeExpected}) {
    if (raw == null || raw.trim().isEmpty) return const <HistoryEntry>[];
    try {
      final decoded = jsonDecode(raw);
      final listRaw = _entryListFromDecoded(decoded, envelopeExpected: envelopeExpected);
      if (listRaw == null) return const <HistoryEntry>[];
      final seenIds = <String>{};
      final entries = <HistoryEntry>[];
      for (final item in listRaw) {
        final entry = HistoryEntry.fromJson(item);
        if (entry == null) continue;
        if (!seenIds.add(entry.id)) continue;
        entries.add(entry);
        if (entries.length >= maxStoredEntries) break;
      }
      return entries;
    } catch (_) {
      return const <HistoryEntry>[];
    }
  }

  static List<Object?>? _entryListFromDecoded(Object? decoded, {required bool envelopeExpected}) {
    if (decoded is List && !envelopeExpected) {
      return List<Object?>.from(decoded);
    }
    if (decoded is! Map) return null;
    final map = Map<Object?, Object?>.from(decoded);
    final version = map['schemaVersion'];
    final entries = map['entries'];
    if (version != schemaVersion || entries is! List) return null;
    return List<Object?>.from(entries);
  }
}
