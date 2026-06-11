import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../editor/render/math_render_surface.dart';
import 'history_models.dart';
import 'history_style.dart';
import 'mini_graph_preview.dart';

class HistoryItemCard extends StatefulWidget {
  const HistoryItemCard({
    super.key,
    required this.entry,
    required this.onPrimaryTap,
    required this.onEdit,
    required this.onDelete,
    required this.onTogglePinned,
    required this.onGraphTap,
    this.onUseResult,
  });

  final HistoryEntry entry;
  final VoidCallback onPrimaryTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTogglePinned;
  final VoidCallback? onGraphTap;
  final VoidCallback? onUseResult;

  @override
  State<HistoryItemCard> createState() => _HistoryItemCardState();
}

class _HistoryItemCardState extends State<HistoryItemCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final accent = _accentFor(entry.kind);
    return GestureDetector(
      key: ValueKey('mathpro-history-entry-${entry.id}'),
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onPrimaryTap,
      onLongPress: () => _showActions(context),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 105),
        curve: Curves.easeOutCubic,
        scale: _pressed ? 0.985 : 1,
        child: AnimatedContainer(
          duration: HistoryStyle.microAnimationDuration,
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                entry.pinned ? HistoryStyle.cardTop : HistoryStyle.cardTop.withValues(alpha: 0.94),
                HistoryStyle.cardBackground,
                HistoryStyle.cardBottom,
              ],
            ),
            borderRadius: HistoryStyle.cardRadius,
            border: Border.all(color: entry.pinned ? HistoryStyle.accent.withValues(alpha: 0.56) : accent.withValues(alpha: _pressed ? 0.34 : 0.20)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: accent.withValues(alpha: entry.pinned ? 0.15 : (_pressed ? 0.10 : 0.06)), blurRadius: _pressed ? 24 : 20, offset: const Offset(0, 10)),
              const BoxShadow(color: HistoryStyle.shadow, blurRadius: 18, offset: Offset(0, 12)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _HistoryItemHeader(entry: entry, accent: accent),
              const SizedBox(height: 12),
              _ExpressionBlock(expression: entry.expression, accent: accent),
              AnimatedSwitcher(
                duration: HistoryStyle.microAnimationDuration,
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: entry.graphExpression != null
                    ? Column(
                        key: ValueKey('graph-preview-${entry.id}'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 12),
                          MiniGraphPreview(expression: entry.graphExpression!),
                          const SizedBox(height: 10),
                          _GraphMetadataChips(entry: entry),
                        ],
                      )
                    : const SizedBox.shrink(key: ValueKey('no-graph-preview')),
              ),
              if (entry.hasError) ...<Widget>[
                const SizedBox(height: 10),
                _ErrorBanner(message: entry.resultLabel),
              ] else ...<Widget>[
                const SizedBox(height: 10),
                _ResultLine(entry: entry),
              ],
              const SizedBox(height: 10),
              _InlineActions(
                entry: entry,
                onEdit: widget.onEdit,
                onGraphTap: widget.onGraphTap,
                onUseResult: entry.canUseResult ? widget.onUseResult : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final canUseResult = widget.entry.canUseResult && widget.onUseResult != null;
        return SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[HistoryStyle.cardTop, HistoryStyle.cardBottom],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              border: Border.all(color: HistoryStyle.border.withValues(alpha: 0.82)),
              boxShadow: const <BoxShadow>[BoxShadow(color: HistoryStyle.deepShadow, blurRadius: 30, offset: Offset(0, -12))],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: HistoryStyle.secondaryText.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 8),
                _ActionTile(icon: Icons.edit_rounded, label: 'Editöre al', onTap: () => _closeAndRun(context, widget.onEdit)),
                if (canUseResult) _ActionTile(icon: Icons.subdirectory_arrow_left_rounded, label: 'Sonucu kullan', onTap: () => _closeAndRun(context, widget.onUseResult!)),
                if (widget.entry.graphExpression != null && widget.onGraphTap != null)
                  _ActionTile(icon: Icons.show_chart_rounded, label: 'Grafiği aç', onTap: () => _closeAndRun(context, widget.onGraphTap!)),
                _ActionTile(icon: Icons.copy_rounded, label: 'Kopyala', onTap: () => _copyEntry(context)),
                _ActionTile(icon: Icons.push_pin_rounded, label: widget.entry.pinned ? 'Sabitlemeyi kaldır' : 'Sabitle', onTap: () => _closeAndRun(context, widget.onTogglePinned)),
                _ActionTile(icon: Icons.delete_rounded, label: 'Sil', destructive: true, onTap: () => _closeAndRun(context, widget.onDelete)),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _copyEntry(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    Clipboard.setData(ClipboardData(text: widget.entry.copyPayload));
    Navigator.of(context).pop();
    messenger.showSnackBar(
      const SnackBar(content: Text('Geçmiş öğesi kopyalandı.'), behavior: SnackBarBehavior.floating, backgroundColor: HistoryStyle.elevatedSurface),
    );
  }

  void _closeAndRun(BuildContext context, VoidCallback action) {
    Navigator.of(context).pop();
    action();
  }

  static Color _accentFor(HistoryEntryKind kind) {
    switch (kind) {
      case HistoryEntryKind.error:
        return HistoryStyle.delete;
      case HistoryEntryKind.graph:
        return HistoryStyle.accent;
      case HistoryEntryKind.calculation:
        return HistoryStyle.resultBlue;
    }
  }
}

class _HistoryItemHeader extends StatelessWidget {
  const _HistoryItemHeader({required this.entry, required this.accent});

  final HistoryEntry entry;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _TypeBadge(kind: entry.kind, label: entry.kindLabel, accent: accent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            entry.compactMetaLabel,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: HistoryStyle.secondaryText, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
        if (entry.pinned)
          Container(
            margin: const EdgeInsets.only(left: 8),
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: HistoryStyle.accent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: HistoryStyle.accent.withValues(alpha: 0.30)),
            ),
            child: const Icon(Icons.push_pin_rounded, color: HistoryStyle.accent, size: 15),
          ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.kind, required this.label, required this.accent});

  final HistoryEntryKind kind;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final icon = switch (kind) {
      HistoryEntryKind.error => Icons.error_outline_rounded,
      HistoryEntryKind.graph => Icons.show_chart_rounded,
      HistoryEntryKind.calculation => Icons.functions_rounded,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withValues(alpha: 0.34)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: accent, size: 14),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.2)),
        ],
      ),
    );
  }
}

class _ExpressionBlock extends StatelessWidget {
  const _ExpressionBlock({required this.expression, required this.accent});

  final String expression;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[HistoryStyle.innerSurface, Color(0xFF07090A)],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accent.withValues(alpha: 0.16)),
        boxShadow: const <BoxShadow>[BoxShadow(color: Color(0x40000000), blurRadius: 12, offset: Offset(0, 8))],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: MathRenderSurface(expression: expression, role: MathRenderSurfaceRole.inline, textAlign: TextAlign.left),
      ),
    );
  }
}

class _ResultLine extends StatelessWidget {
  const _ResultLine({required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final color = entry.kind == HistoryEntryKind.graph ? HistoryStyle.accent : HistoryStyle.resultBlue;
    return Row(
      children: <Widget>[
        Icon(entry.kind == HistoryEntryKind.graph ? Icons.done_rounded : Icons.drag_handle_rounded, color: color, size: 18),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            entry.resultLabel,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900, height: 1.2),
          ),
        ),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: HistoryStyle.delete.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: HistoryStyle.delete.withValues(alpha: 0.30)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.error_outline_rounded, color: HistoryStyle.delete, size: 17),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: HistoryStyle.delete, fontSize: 12.5, fontWeight: FontWeight.w800, height: 1.25),
            ),
          ),
        ],
      ),
    );
  }
}

class _GraphMetadataChips extends StatelessWidget {
  const _GraphMetadataChips({required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        _MetaChip(icon: Icons.straighten_rounded, label: entry.graphRangeLabel),
        _MetaChip(icon: Icons.radio_button_checked_rounded, label: entry.graphTraceLabel),
      ],
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    if (label.trim().isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: HistoryStyle.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: HistoryStyle.accent.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: HistoryStyle.accent, size: 13),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(color: HistoryStyle.secondaryText, fontSize: 11, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _InlineActions extends StatelessWidget {
  const _InlineActions({required this.entry, required this.onEdit, required this.onGraphTap, required this.onUseResult});

  final HistoryEntry entry;
  final VoidCallback onEdit;
  final VoidCallback? onGraphTap;
  final VoidCallback? onUseResult;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: <Widget>[
        _PillAction(icon: Icons.edit_rounded, label: 'Editöre al', onTap: onEdit),
        if (onUseResult != null) _PillAction(icon: Icons.subdirectory_arrow_left_rounded, label: 'Sonucu kullan', onTap: onUseResult!),
        if (entry.graphExpression != null && onGraphTap != null) _PillAction(icon: Icons.show_chart_rounded, label: 'Grafiği Aç', onTap: onGraphTap!),
      ],
    );
  }
}

class _PillAction extends StatelessWidget {
  const _PillAction({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: HistoryStyle.innerSurface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: HistoryStyle.borderSoft),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: HistoryStyle.secondaryText, size: 14),
            const SizedBox(width: 5),
            Text(label, style: const TextStyle(color: HistoryStyle.secondaryText, fontSize: 11.5, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label, required this.onTap, this.destructive = false});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? HistoryStyle.delete : HistoryStyle.primaryText;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
      trailing: destructive ? null : const Icon(Icons.chevron_right_rounded, color: HistoryStyle.tertiaryText),
    );
  }
}
