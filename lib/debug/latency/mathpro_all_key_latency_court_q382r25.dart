import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../features/keyboard/key_config.dart';
import '../../features/keyboard/keyboard_category_fast_paths_q382r29_policy.dart';
import '../../features/keyboard/all_key_latency_closure_template_fast_paths_q382r32_policy.dart';
import '../../logic/action_utils.dart';
import 'mathpro_all_key_latency_court_q382r25_policy.dart';

class MathProAllKeyLatencyCourtEntryQ382R25 {
  const MathProAllKeyLatencyCourtEntryQ382R25({
    required this.id,
    required this.label,
    required this.origin,
    required this.category,
    required this.behavior,
    required this.sourceTab,
    required this.rowIndex,
    required this.columnIndex,
    this.parentLabel,
    this.moreCategory,
    required this.dispatchInDirectBridgeCourt,
    required this.q382r32TemplateFastPathCandidate,
    required this.q382r32OptimisticEchoProtected,
  });

  final String id;
  final String label;
  final String origin;
  final String category;
  final String behavior;
  final String sourceTab;
  final int rowIndex;
  final int columnIndex;
  final String? parentLabel;
  final String? moreCategory;
  final bool dispatchInDirectBridgeCourt;
  final bool q382r32TemplateFastPathCandidate;
  final bool q382r32OptimisticEchoProtected;

  Map<String, Object?> toJson() => <String, Object?>{
        'id': id,
        'label': label,
        'origin': origin,
        'category': category,
        'behavior': behavior,
        'sourceTab': sourceTab,
        'rowIndex': rowIndex,
        'columnIndex': columnIndex,
        if (parentLabel != null) 'parentLabel': parentLabel,
        if (moreCategory != null) 'moreCategory': moreCategory,
        'dispatchInDirectBridgeCourt': dispatchInDirectBridgeCourt,
        'q382r32TemplateFastPathCandidate': q382r32TemplateFastPathCandidate,
        'q382r32OptimisticEchoProtected': q382r32OptimisticEchoProtected,
      };
}

class MathProAllKeyLatencyCourtSummaryQ382R25 {
  const MathProAllKeyLatencyCourtSummaryQ382R25({
    required this.totalEntries,
    required this.mainKeyboardEntries,
    required this.longPressOptionEntries,
    required this.moreTemplateEntries,
    required this.moreCategoryEntries,
    required this.dispatchableEntries,
    required this.q382r32TemplateFastPathCandidates,
    required this.q382r32OptimisticEchoProtectedEntries,
  });

  final int totalEntries;
  final int mainKeyboardEntries;
  final int longPressOptionEntries;
  final int moreTemplateEntries;
  final int moreCategoryEntries;
  final int dispatchableEntries;
  final int q382r32TemplateFastPathCandidates;
  final int q382r32OptimisticEchoProtectedEntries;

  Map<String, Object?> toJson() => <String, Object?>{
        'phase': MathProAllKeyLatencyCourtQ382R25Policy.phase,
        'contractMarker': MathProAllKeyLatencyCourtQ382R25Policy.contractMarker,
        'totalEntries': totalEntries,
        'mainKeyboardEntries': mainKeyboardEntries,
        'longPressOptionEntries': longPressOptionEntries,
        'moreTemplateEntries': moreTemplateEntries,
        'moreCategoryEntries': moreCategoryEntries,
        'dispatchableEntries': dispatchableEntries,
        'q382r32Phase': AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.phase,
        'q382r32Marker': AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.marker,
        'q382r32TemplateFastPathCandidates': q382r32TemplateFastPathCandidates,
        'q382r32OptimisticEchoProtectedEntries': q382r32OptimisticEchoProtectedEntries,
      };
}

class MathProAllKeyLatencyCourtQ382R25 extends ChangeNotifier {
  MathProAllKeyLatencyCourtQ382R25._();

  static final MathProAllKeyLatencyCourtQ382R25 instance = MathProAllKeyLatencyCourtQ382R25._();

  bool _running = false;
  bool _completed = false;
  int _acceptedDispatches = 0;
  int _rejectedDispatches = 0;
  MathProAllKeyLatencyCourtSummaryQ382R25? _latestSummary;

  bool get running => _running;
  bool get completed => _completed;
  int get acceptedDispatches => _acceptedDispatches;
  int get rejectedDispatches => _rejectedDispatches;
  MathProAllKeyLatencyCourtSummaryQ382R25? get latestSummary => _latestSummary;

  static List<MathProAllKeyLatencyCourtEntryQ382R25> buildInventory() {
    final entries = <MathProAllKeyLatencyCourtEntryQ382R25>[];
    final seen = <String>{};

    void add({
      required String label,
      required String origin,
      required String sourceTab,
      required int rowIndex,
      required int columnIndex,
      String? parentLabel,
      String? moreCategory,
    }) {
      final trimmed = label.trim();
      if (trimmed.isEmpty) return;
      final behavior = KeyConfig.getKeyBehavior(trimmed);
      final category = _categoryFor(
        label: trimmed,
        origin: origin,
        behavior: behavior,
      );
      final id = <String>[
        origin,
        sourceTab,
        rowIndex.toString(),
        columnIndex.toString(),
        parentLabel ?? '',
        moreCategory ?? '',
        trimmed,
      ].join('|');
      if (!seen.add(id)) return;
      entries.add(
        MathProAllKeyLatencyCourtEntryQ382R25(
          id: id,
          label: trimmed,
          origin: origin,
          category: category,
          behavior: behavior.name,
          sourceTab: sourceTab,
          rowIndex: rowIndex,
          columnIndex: columnIndex,
          parentLabel: parentLabel,
          moreCategory: moreCategory,
          dispatchInDirectBridgeCourt: _dispatchInDirectBridgeCourt(
            label: trimmed,
            origin: origin,
            behavior: behavior,
          ),
          q382r32TemplateFastPathCandidate:
              AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.templateFamilyUsesQueuedFastPath(trimmed) ||
                  origin == 'moreTemplate' ||
                  origin == 'longPressOption',
          q382r32OptimisticEchoProtected:
              AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.isProtectedTemplateLabel(trimmed) ||
                  origin == 'moreTemplate' ||
                  origin == 'longPressOption',
        ),
      );
    }

    if (MathProAllKeyLatencyCourtQ382R25Policy.includeMainKeyboardEntries) {
      for (final tab in KeyConfig.tabs) {
        final sections = KeyConfig.buildKeyboardSections(tab);
        final rows = sections.expandedGridRows ?? sections.coreRows;
        if (rows == null) continue;
        for (var rowIndex = 0; rowIndex < rows.length; rowIndex += 1) {
          final row = rows[rowIndex];
          for (var columnIndex = 0; columnIndex < row.length; columnIndex += 1) {
            final label = row[columnIndex].label;
            if (label == null) continue;
            add(
              label: label,
              origin: 'mainKeyboard',
              sourceTab: tab,
              rowIndex: rowIndex,
              columnIndex: columnIndex,
            );
          }
        }
      }
    }

    if (MathProAllKeyLatencyCourtQ382R25Policy.includeLongPressOptionEntries) {
      for (final tab in KeyConfig.tabs) {
        for (final entry in KeyConfig.longPressMap.entries) {
          final options = KeyConfig.getLongPressOptions(entry.key, tab);
          for (var index = 0; index < options.length; index += 1) {
            final option = options[index];
            if (option == entry.key) continue;
            add(
              label: option,
              origin: 'longPressOption',
              sourceTab: tab,
              rowIndex: -1,
              columnIndex: index,
              parentLabel: entry.key,
            );
          }
        }
      }
    }

    if (MathProAllKeyLatencyCourtQ382R25Policy.includeMoreCategoryEntriesInInventory ||
        MathProAllKeyLatencyCourtQ382R25Policy.includeMoreTemplateEntries) {
      for (var categoryIndex = 0; categoryIndex < ActionUtils.morePanelCategories.length; categoryIndex += 1) {
        final category = ActionUtils.morePanelCategories[categoryIndex];
        if (MathProAllKeyLatencyCourtQ382R25Policy.includeMoreCategoryEntriesInInventory) {
          add(
            label: category.title,
            origin: 'moreCategory',
            sourceTab: 'MORE',
            rowIndex: categoryIndex,
            columnIndex: -1,
            moreCategory: category.title,
          );
        }
        if (MathProAllKeyLatencyCourtQ382R25Policy.includeMoreTemplateEntries) {
          for (var index = 0; index < category.labels.length; index += 1) {
            add(
              label: category.labels[index],
              origin: 'moreTemplate',
              sourceTab: 'MORE',
              rowIndex: categoryIndex,
              columnIndex: index,
              moreCategory: category.title,
            );
          }
        }
      }
    }

    return List<MathProAllKeyLatencyCourtEntryQ382R25>.unmodifiable(entries);
  }

  static MathProAllKeyLatencyCourtSummaryQ382R25 buildSummary([
    List<MathProAllKeyLatencyCourtEntryQ382R25>? inventory,
  ]) {
    final entries = inventory ?? buildInventory();
    int count(String origin) => entries.where((entry) => entry.origin == origin).length;
    return MathProAllKeyLatencyCourtSummaryQ382R25(
      totalEntries: entries.length,
      mainKeyboardEntries: count('mainKeyboard'),
      longPressOptionEntries: count('longPressOption'),
      moreTemplateEntries: count('moreTemplate'),
      moreCategoryEntries: count('moreCategory'),
      dispatchableEntries: entries.where((entry) => entry.dispatchInDirectBridgeCourt).length,
      q382r32TemplateFastPathCandidates:
          entries.where((entry) => entry.q382r32TemplateFastPathCandidate).length,
      q382r32OptimisticEchoProtectedEntries:
          entries.where((entry) => entry.q382r32OptimisticEchoProtected).length,
    );
  }

  static String exportInventoryJson() {
    final inventory = buildInventory();
    return const JsonEncoder.withIndent('  ').convert(<String, Object?>{
      'summary': buildSummary(inventory).toJson(),
      'entries': inventory.map((entry) => entry.toJson()).toList(growable: false),
    });
  }

  Future<void> maybeRunDirectBridgeCourt({
    required FutureOr<bool> Function(String label) dispatch,
  }) async {
    if (!kDebugMode || !MathProAllKeyLatencyCourtQ382R25Policy.enabledByDartDefine) return;
    if (_running || _completed) return;
    _running = true;
    _acceptedDispatches = 0;
    _rejectedDispatches = 0;
    notifyListeners();

    final inventory = buildInventory();
    final summary = buildSummary(inventory);
    _latestSummary = summary;
    debugPrint('[Q382R25_COURT] INVENTORY ${jsonEncode(summary.toJson())}');
    debugPrint('[Q382R32_CLOSURE] ALL_KEY_TEMPLATE_MORE_LONGPRESS ${jsonEncode(<String, Object?>{
      'phase': AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.phase,
      'marker': AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.marker,
      'templateFastPathCandidates': summary.q382r32TemplateFastPathCandidates,
      'optimisticEchoProtectedEntries': summary.q382r32OptimisticEchoProtectedEntries,
      'templatePayloadCacheLimit': AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.templatePayloadCacheLimit,
      'deleteDebounceMs': AllKeyLatencyClosureTemplateFastPathsQ382R32Policy.deleteDownstreamSyncDebounce.inMilliseconds,
    })}');
    debugPrint('[Q382R25_COURT] INVENTORY_JSON ${exportInventoryJson()}');

    await Future<void>.delayed(MathProAllKeyLatencyCourtQ382R25Policy.startupWarmup);
    final dispatchable = inventory
        .where((entry) => entry.dispatchInDirectBridgeCourt)
        .take(MathProAllKeyLatencyCourtQ382R25Policy.maxDirectBridgeEntriesPerRun)
        .toList(growable: false);

    debugPrint('[Q382R25_COURT] DIRECT_BRIDGE_START entries=${dispatchable.length}');
    for (final entry in dispatchable) {
      final accepted = await dispatch(entry.label);
      if (accepted) {
        _acceptedDispatches += 1;
      } else {
        _rejectedDispatches += 1;
      }
      debugPrint('[Q382R25_COURT] DIRECT_BRIDGE_ENTRY ${jsonEncode(<String, Object?>{
        ...entry.toJson(),
        'accepted': accepted,
      })}');
      notifyListeners();
      await Future<void>.delayed(MathProAllKeyLatencyCourtQ382R25Policy.dispatchCadence);
    }
    _completed = true;
    _running = false;
    debugPrint('[Q382R25_COURT] DIRECT_BRIDGE_END accepted=$_acceptedDispatches rejected=$_rejectedDispatches');
    notifyListeners();
  }

  static String _categoryFor({
    required String label,
    required String origin,
    required KeyBehaviorType behavior,
  }) {
    final category = KeyboardCategoryFastPathsQ382R29Policy.categoryFor(
      label: label,
      origin: origin,
      hasLongPress: KeyConfig.longPressMap.containsKey(label),
    );
    return switch (category) {
      KeyCategoryFastPathQ382R29.linearSafe => 'linear-safe',
      KeyCategoryFastPathQ382R29.operatorText => 'operator',
      KeyCategoryFastPathQ382R29.textSymbol => 'text-or-symbol',
      KeyCategoryFastPathQ382R29.structureTemplate => 'structure-template',
      KeyCategoryFastPathQ382R29.wrapperTemplate => 'wrapper-template',
      KeyCategoryFastPathQ382R29.postfixTemplate => 'postfix-template',
      KeyCategoryFastPathQ382R29.functionTemplate => 'function-template',
      KeyCategoryFastPathQ382R29.longPressParent => 'longpress-parent',
      KeyCategoryFastPathQ382R29.longPressChild => 'longpress-child',
      KeyCategoryFastPathQ382R29.moreTemplate => 'more-template',
      KeyCategoryFastPathQ382R29.moreCategory => 'more-category',
      KeyCategoryFastPathQ382R29.deleteRepeat => 'delete-repeat',
      KeyCategoryFastPathQ382R29.clearPriority => 'clear-priority',
      KeyCategoryFastPathQ382R29.evaluateAction => 'evaluate-action',
      KeyCategoryFastPathQ382R29.answerRecall => 'answer-recall',
      KeyCategoryFastPathQ382R29.uiCommand => 'destructive-or-ui-command',
    };
  }

  static bool _dispatchInDirectBridgeCourt({
    required String label,
    required String origin,
    required KeyBehaviorType behavior,
  }) {
    if (origin == 'moreCategory') return MathProAllKeyLatencyCourtQ382R25Policy.dispatchMoreCategoryEntries;
    if (_isDestructiveOrUiCommand(label)) return MathProAllKeyLatencyCourtQ382R25Policy.dispatchDestructiveOrUiCommands;
    if (behavior == KeyBehaviorType.command) return false;
    return origin == 'mainKeyboard' || origin == 'longPressOption' || origin == 'moreTemplate';
  }

  static bool _isDestructiveOrUiCommand(String label) => const <String>{
        'C',
        '⌫',
        '↵',
        'MORE',
        'Ans',
      }.contains(label);

}