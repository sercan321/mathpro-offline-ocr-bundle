import 'package:flutter/material.dart';

import 'key_config.dart';
import 'key_model.dart';
import 'premium_key.dart';
import 'keyboard_long_press_anchor.dart';

class MathKeyboard extends StatelessWidget {
  const MathKeyboard({
    super.key,
    required this.activeTab,
    required this.onKeyPressed,
    required this.onKeyLongPressed,
  });

  final String activeTab;
  final ValueChanged<String> onKeyPressed;
  final ValueChanged<KeyboardLongPressAnchor> onKeyLongPressed;

  @override
  Widget build(BuildContext context) {
    final sections = KeyConfig.buildKeyboardSections(activeTab);
    return sections.isBasic
        ? _BasicKeyboard(rows: sections.coreRows!, activeTab: activeTab, onKeyPressed: onKeyPressed, onKeyLongPressed: onKeyLongPressed)
        : _ExpandedKeyboard(rows: sections.expandedGridRows!, activeTab: activeTab, onKeyPressed: onKeyPressed, onKeyLongPressed: onKeyLongPressed);
  }
}

class _BasicKeyboard extends StatelessWidget {
  const _BasicKeyboard({
    required this.rows,
    required this.activeTab,
    required this.onKeyPressed,
    required this.onKeyLongPressed,
  });

  final List<List<MathKeyCell>> rows;
  final String activeTab;
  final ValueChanged<String> onKeyPressed;
  final ValueChanged<KeyboardLongPressAnchor> onKeyLongPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          Expanded(child: _KeyRow(row: rows[i], activeTab: activeTab, compact: false, onKeyPressed: onKeyPressed, onKeyLongPressed: onKeyLongPressed)),
        ],
      ],
    );
  }
}

class _ExpandedKeyboard extends StatelessWidget {
  const _ExpandedKeyboard({
    required this.rows,
    required this.activeTab,
    required this.onKeyPressed,
    required this.onKeyLongPressed,
  });

  final List<List<MathKeyCell>> rows;
  final String activeTab;
  final ValueChanged<String> onKeyPressed;
  final ValueChanged<KeyboardLongPressAnchor> onKeyLongPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          Expanded(child: _KeyRow(row: rows[i], activeTab: activeTab, compact: true, onKeyPressed: onKeyPressed, onKeyLongPressed: onKeyLongPressed)),
        ],
      ],
    );
  }
}

class _KeyRow extends StatelessWidget {
  const _KeyRow({
    required this.row,
    required this.activeTab,
    required this.compact,
    required this.onKeyPressed,
    required this.onKeyLongPressed,
  });

  final List<MathKeyCell> row;
  final String activeTab;
  final bool compact;
  final ValueChanged<String> onKeyPressed;
  final ValueChanged<KeyboardLongPressAnchor> onKeyLongPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < row.length; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          Expanded(
            flex: row[i].span,
            child: row[i].isEmpty
                ? const _EmptyGridCell()
                : PremiumKey(
                    label: row[i].label!,
                    variant: premiumVariantForLabel(row[i].label!),
                    compact: compact,
                    hasLongPress: KeyConfig.hasLongPressOptions(row[i].label!, activeTab),
                    onPressed: onKeyPressed,
                    onLongPressed: KeyConfig.hasLongPressOptions(row[i].label!, activeTab) ? onKeyLongPressed : null,
                  ),
          ),
        ],
      ],
    );
  }
}

class _EmptyGridCell extends StatelessWidget {
  const _EmptyGridCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }
}
