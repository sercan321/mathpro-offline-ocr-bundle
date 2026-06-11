import 'package:flutter/material.dart';

import '../../services/haptics_service.dart';
import '../../theme/mathpro_tokens.dart';

class SelectionToolbar extends StatelessWidget {
  const SelectionToolbar({
    super.key,
    required this.visible,
    required this.selectionLabel,
    required this.selectionHasContent,
    required this.hasClipboard,
    required this.hasUndo,
    required this.hasRedo,
    required this.onCopy,
    required this.onCut,
    required this.onDuplicate,
    required this.onPaste,
    required this.onUndo,
    required this.onRedo,
    required this.onClear,
  });

  final bool visible;
  final String selectionLabel;
  final bool selectionHasContent;
  final bool hasClipboard;
  final bool hasUndo;
  final bool hasRedo;
  final VoidCallback onCopy;
  final VoidCallback onCut;
  final VoidCallback onDuplicate;
  final VoidCallback onPaste;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();

    final actions = <_SelectionAction>[
      _SelectionAction('Kopyala', onCopy, disabled: !selectionHasContent),
      _SelectionAction('Kes', onCut, disabled: !selectionHasContent, danger: true),
      _SelectionAction('Çoğalt', onDuplicate, disabled: !selectionHasContent),
      _SelectionAction('Yapıştır', onPaste, disabled: !hasClipboard),
      _SelectionAction('Geri Al', onUndo, disabled: !hasUndo),
      _SelectionAction('Yinele', onRedo, disabled: !hasRedo),
      _SelectionAction('Temizle', onClear),
    ];

    return Container(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(24, 24, 24, 0.94),
        borderRadius: BorderRadius.circular(MathProRadius.xl),
        border: Border.all(color: const Color.fromRGBO(116, 170, 156, 0.18)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.20),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Seçim',
                style: TextStyle(
                  color: MathProColors.text,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.45,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  selectionLabel.trim().isEmpty ? 'Aktif alan' : selectionLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: MathProColors.textFaint,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: actions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) => _ActionChip(action: actions[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionAction {
  const _SelectionAction(this.label, this.onPressed, {this.disabled = false, this.danger = false});

  final String label;
  final VoidCallback onPressed;
  final bool disabled;
  final bool danger;
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.action});

  final _SelectionAction action;

  @override
  Widget build(BuildContext context) {
    final color = action.danger ? MathProColors.danger : MathProColors.text;
    final background = action.danger ? MathProColors.dangerSoft : const Color.fromRGBO(255, 255, 255, 0.07);
    final border = action.danger ? const Color.fromRGBO(242, 140, 24, 0.22) : const Color.fromRGBO(255, 255, 255, 0.10);

    return Opacity(
      opacity: action.disabled ? 0.38 : 1,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: action.disabled ? null : (_) => HapticsService.selectionClick(),
        onTap: action.disabled ? null : action.onPressed,
        child: Container(
          constraints: const BoxConstraints(minWidth: 58),
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(MathProRadius.pill),
            border: Border.all(color: border),
          ),
          child: Text(
            action.label,
            style: TextStyle(
              color: action.disabled ? MathProColors.textFaint : color,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.12,
            ),
          ),
        ),
      ),
    );
  }
}
