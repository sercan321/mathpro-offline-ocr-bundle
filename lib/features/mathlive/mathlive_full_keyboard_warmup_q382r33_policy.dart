import 'package:flutter/foundation.dart';

import '../../logic/action_utils.dart';
import '../keyboard/key_config.dart';
import '../keyboard/keyboard_category_fast_paths_q382r29_policy.dart';
import 'mathlive_keyboard_bridge_policy.dart';

/// V172-Q382R33 — full keyboard warmup and fast path closure.
///
/// This phase does not expand optimistic echo and does not mutate keyboard,
/// MORE, or long-press inventories.  It builds a deterministic warmup inventory
/// from the existing source-of-truth lists and sends that inventory to the
/// production MathLive bridge once after the WebView is mounted.  The JS bridge
/// warms the document-LaTeX/template payload cache without inserting anything
/// into the visible math-field.
@immutable
class MathLiveFullKeyboardWarmupQ382R33Policy {
  const MathLiveFullKeyboardWarmupQ382R33Policy._();

  static const String phase = 'V172-Q382R33';
  static const String marker = 'q382r33-full-keyboard-warmup-fast-path-closure-active';

  static const bool webViewOnPageFinishedWarmupEnabled = true;
  static const bool warmupUsesExistingKeyboardInventory = true;
  static const bool warmupUsesExistingLongPressInventory = true;
  static const bool warmupUsesExistingMoreInventory = true;
  static const bool warmupDoesNotInsertIntoVisibleMathField = true;
  static const bool optimisticEchoScopeExpanded = false;
  static const bool keyboardLayoutOrderLabelsUntouched = true;
  static const bool longPressListsUntouched = true;
  static const bool moreInventoryUntouched = true;
  static const bool templateSlotCaretSemanticsPreserved = true;
  static const bool graphHistorySolutionSolverOcrAndroidUntouched = true;
  static const bool deleteClearBehaviorChanged = false;
  static const bool longPressPopupPrerenderEnabled = true;
  static const bool moreTrayKeepAliveEnabled = true;
  static const int maxWarmupEntries = 256;

  static const Set<String> warmupSkipActions = <String>{
    'clear',
    'deleteBackward',
    'evaluate',
    'noop',
  };

  static List<Map<String, Object?>> fullKeyInventory({String lastAnswer = ''}) {
    final seen = <String>{};
    final entries = <Map<String, Object?>>[];

    void addLabel(String label, String origin, {String activeTab = '', bool hasLongPress = false}) {
      final trimmed = label.trim();
      if (trimmed.isEmpty) return;
      // Q382R33R2: warmup is per dispatch label, not per tab/origin clone.
      // Earlier per-origin keys could let long-press duplicates consume the 256
      // entry cap before later primary tabs such as Kalkülüs/Lineer Cebir, so
      // labels like ∫□dx were not guaranteed to be in the dispatchable court.
      if (!seen.add(trimmed)) return;
      final command = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel(trimmed, lastAnswer: lastAnswer);
      final category = KeyboardCategoryFastPathsQ382R29Policy.categoryFor(
        label: trimmed,
        origin: origin,
        hasLongPress: hasLongPress,
      );
      entries.add(<String, Object?>{
        'phase': phase,
        'label': trimmed,
        'origin': origin,
        'activeTab': activeTab,
        'category': category.name,
        'action': command.action,
        'accepted': command.accepted,
        'latex': command.accepted && command.action == 'insertLatex'
            ? MathLiveKeyboardBridgePolicy.productionRuntimeRenderLatexForMainEditorLabel(trimmed, command.latex)
            : '',
        'hasLongPress': hasLongPress,
        'optimisticEchoProtected': !KeyboardCategoryFastPathsQ382R29Policy.mayUseOptimisticEcho(trimmed),
      });
    }

    for (final tab in KeyConfig.tabs) {
      final sections = KeyConfig.buildKeyboardSections(tab);
      final rows = sections.expandedGridRows ?? sections.coreRows;
      if (rows == null) continue;
      for (final row in rows) {
        for (final cell in row) {
          final label = cell.label;
          if (label == null) continue;
          addLabel(
            label,
            'mainKeyboard',
            activeTab: tab,
            hasLongPress: KeyConfig.hasLongPressOptions(label, tab),
          );
        }
      }
      for (final entry in KeyConfig.longPressMap.entries) {
        for (final option in KeyConfig.getLongPressOptions(entry.key, tab)) {
          if (option == entry.key) continue;
          addLabel(option, 'longPressOption', activeTab: tab);
        }
      }
    }

    for (final category in ActionUtils.morePanelCategories) {
      addLabel(category.title, 'moreCategory');
      for (final label in category.labels) {
        addLabel(label, 'moreTemplate');
      }
    }

    final dispatchable = entries.where((entry) {
      final action = (entry['action'] ?? '').toString();
      return !warmupSkipActions.contains(action) && entry['accepted'] == true;
    }).take(maxWarmupEntries).toList(growable: false);
    return List<Map<String, Object?>>.unmodifiable(dispatchable);
  }

  static List<List<String>> longPressOptionGroups() {
    final groups = <String, List<String>>{};
    for (final tab in KeyConfig.tabs) {
      for (final entry in KeyConfig.longPressMap.entries) {
        final options = KeyConfig.getLongPressOptions(entry.key, tab)
            .where((option) => option != entry.key)
            .toList(growable: false);
        if (options.isEmpty) continue;
        groups['$tab::${entry.key}'] = options;
      }
    }
    return List<List<String>>.unmodifiable(groups.values);
  }

  static List<String> moreTemplateLabels() {
    final labels = <String>{};
    for (final category in ActionUtils.morePanelCategories) {
      labels.addAll(category.labels);
    }
    return List<String>.unmodifiable(labels);
  }

  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool realDeviceLatencyPassClaimed = false;
}
