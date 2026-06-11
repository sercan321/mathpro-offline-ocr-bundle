import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'history_controller.dart';
import 'history_item_card.dart';
import 'history_models.dart';
import 'history_style.dart';

class HistoryPanel extends StatefulWidget {
  const HistoryPanel({
    super.key,
    required this.controller,
    required this.onClose,
    required this.onEntrySelected,
    required this.onGraphSelected,
    required this.onResultSelected,
  });

  final HistoryController controller;
  final VoidCallback onClose;
  final ValueChanged<HistoryEntry> onEntrySelected;
  final ValueChanged<HistoryEntry> onGraphSelected;
  final ValueChanged<HistoryEntry> onResultSelected;

  @override
  State<HistoryPanel> createState() => _HistoryPanelState();
}

class _HistoryPanelState extends State<HistoryPanel> {
  static const double _dismissDistance = -54;
  static const double _dismissVelocity = -360;

  final TextEditingController _searchController = TextEditingController();
  bool _searchOpen = false;
  double _dragOffset = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[widget.controller, _searchController]),
      builder: (context, _) {
        final query = _searchController.text;
        final sections = widget.controller.sections(query: query);
        final totalCount = widget.controller.entries.length;
        final pinnedCount = widget.controller.entries.where((entry) => entry.pinned).length;
        final dismissProgress = (-_dragOffset / 88).clamp(0.0, 1.0).toDouble();
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onVerticalDragUpdate: _handleVerticalDragUpdate,
          onVerticalDragEnd: _handleVerticalDragEnd,
          child: AnimatedOpacity(
            duration: HistoryStyle.microAnimationDuration,
            curve: Curves.easeOutCubic,
            opacity: 1 - dismissProgress * 0.20,
            child: AnimatedScale(
              duration: HistoryStyle.microAnimationDuration,
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              scale: 1 - dismissProgress * 0.018,
              child: AnimatedContainer(
                duration: HistoryStyle.microAnimationDuration,
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(0, _dragOffset, 0),
                child: RepaintBoundary(
                  child: Container(
                    key: const ValueKey('mathpro-premium-history-panel'),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          HistoryStyle.panelTop,
                          HistoryStyle.panelMid,
                          HistoryStyle.panelBottom,
                        ],
                      ),
                      borderRadius: HistoryStyle.panelRadius,
                      border: Border(
                        bottom: BorderSide(color: HistoryStyle.border.withValues(alpha: 0.86)),
                      ),
                      boxShadow: <BoxShadow>[
                        const BoxShadow(color: HistoryStyle.deepShadow, blurRadius: 34, offset: Offset(0, 18)),
                        BoxShadow(color: HistoryStyle.accent.withValues(alpha: 0.06 + dismissProgress * 0.05), blurRadius: 32, offset: Offset.zero),
                        const BoxShadow(color: HistoryStyle.graphiteHighlight, blurRadius: 1, offset: Offset(0, 1)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: HistoryStyle.panelRadius,
                      child: SafeArea(
                        bottom: false,
                        child: Column(
                          children: <Widget>[
                            _HistoryHeader(
                              searchOpen: _searchOpen,
                              searchController: _searchController,
                              totalCount: totalCount,
                              pinnedCount: pinnedCount,
                              restored: widget.controller.restored,
                              onToggleSearch: _toggleSearch,
                              onClose: widget.onClose,
                              onClear: widget.controller.entries.isEmpty ? null : _confirmClearHistory,
                            ),
                            Expanded(
                              child: sections.isEmpty
                                  ? _EmptyHistory(searching: query.trim().isNotEmpty)
                                  : ListView.builder(
                                      key: const ValueKey('mathpro-premium-history-list'),
                                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
                                      itemCount: sections.length,
                                      itemBuilder: (context, index) => _HistorySectionView(
                                        section: sections[index],
                                        onEntrySelected: widget.onEntrySelected,
                                        onGraphSelected: widget.onGraphSelected,
                                        onResultSelected: widget.onResultSelected,
                                        onDeleteEntry: _deleteEntry,
                                        onTogglePinned: _togglePinned,
                                      ),
                                    ),
                            ),
                            const _HistoryCloseGrip(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dy >= 0 && _dragOffset == 0) return;
    setState(() {
      _dragOffset = math.min(0.0, math.max(-88.0, _dragOffset + details.delta.dy));
    });
  }

  void _handleVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (_dragOffset <= _dismissDistance || velocity <= _dismissVelocity) {
      widget.onClose();
      return;
    }
    if (_dragOffset != 0) {
      setState(() => _dragOffset = 0);
    }
  }

  void _toggleSearch() {
    setState(() {
      _searchOpen = !_searchOpen;
      if (!_searchOpen) _searchController.clear();
    });
  }

  void _deleteEntry(HistoryEntry entry) {
    final index = widget.controller.entries.indexWhere((current) => current.id == entry.id);
    final removed = widget.controller.delete(entry.id);
    if (removed == null) return;
    _showUndoSnackBar(
      message: 'Geçmiş öğesi silindi.',
      onUndo: () => widget.controller.restoreDeleted(removed, index: index < 0 ? 0 : index),
    );
  }

  void _togglePinned(HistoryEntry entry) {
    widget.controller.togglePinned(entry.id);
    final updated = widget.controller.entryById(entry.id) ?? entry;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(updated.pinned ? 'Geçmiş öğesi sabitlendi.' : 'Sabitleme kaldırıldı.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: HistoryStyle.elevatedSurface,
        duration: const Duration(milliseconds: 1400),
      ),
    );
  }

  void _confirmClearHistory() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
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
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 46,
                  height: 5,
                  decoration: BoxDecoration(
                    color: HistoryStyle.secondaryText.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Geçmiş temizlensin mi?', style: TextStyle(color: HistoryStyle.primaryText, fontSize: 19, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              const Text(
                'Tüm geçmiş kayıtları kaldırılacak. Bu işlemden sonra kısa süre içinde geri alabilirsin.',
                style: TextStyle(color: HistoryStyle.secondaryText, fontSize: 14, height: 1.35, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: HistoryStyle.primaryText,
                        side: const BorderSide(color: HistoryStyle.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Vazgeç'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HistoryStyle.delete,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        final removed = widget.controller.clearAndReturn();
                        if (removed.isEmpty) return;
                        _showUndoSnackBar(
                          message: 'Geçmiş temizlendi.',
                          onUndo: () => widget.controller.restoreBatch(removed),
                        );
                      },
                      child: const Text('Temizle'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUndoSnackBar({required String message, required VoidCallback onUndo}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: HistoryStyle.elevatedSurface,
        action: SnackBarAction(label: 'Geri al', textColor: HistoryStyle.accent, onPressed: onUndo),
      ),
    );
  }
}

class _HistoryHeader extends StatelessWidget {
  const _HistoryHeader({
    required this.searchOpen,
    required this.searchController,
    required this.totalCount,
    required this.pinnedCount,
    required this.restored,
    required this.onToggleSearch,
    required this.onClose,
    required this.onClear,
  });

  final bool searchOpen;
  final TextEditingController searchController;
  final int totalCount;
  final int pinnedCount;
  final bool restored;
  final VoidCallback onToggleSearch;
  final VoidCallback onClose;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 12, 8),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const _HistoryIconBadge(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Geçmiş', style: TextStyle(color: HistoryStyle.primaryText, fontSize: 22, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 3),
                    _HistoryHeaderMeta(totalCount: totalCount, pinnedCount: pinnedCount, restored: restored),
                  ],
                ),
              ),
              _HeaderIconButton(
                tooltip: searchOpen ? 'Aramayı kapat' : 'Ara',
                onPressed: onToggleSearch,
                icon: searchOpen ? Icons.search_off_rounded : Icons.search_rounded,
              ),
              const SizedBox(width: 6),
              TextButton(
                onPressed: onClear,
                style: TextButton.styleFrom(
                  foregroundColor: onClear == null ? HistoryStyle.secondaryText.withValues(alpha: 0.38) : HistoryStyle.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Temizle', style: TextStyle(fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 4),
              _HeaderIconButton(tooltip: 'Kapat', onPressed: onClose, icon: Icons.close_rounded, emphasized: true),
            ],
          ),
          AnimatedSwitcher(
            duration: HistoryStyle.microAnimationDuration,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            transitionBuilder: (child, animation) {
              final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic, reverseCurve: Curves.easeInCubic);
              return SizeTransition(
                sizeFactor: curved,
                axisAlignment: -1,
                child: FadeTransition(opacity: curved, child: child),
              );
            },
            child: searchOpen
                ? Padding(
                    key: const ValueKey('mathpro-history-search-field'),
                    padding: const EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(color: HistoryStyle.primaryText, fontSize: 14, fontWeight: FontWeight.w700),
                      decoration: InputDecoration(
                        hintText: 'İfade, sonuç, grafik veya sekme ara',
                        hintStyle: const TextStyle(color: HistoryStyle.secondaryText, fontWeight: FontWeight.w600),
                        prefixIcon: const Icon(Icons.search_rounded, color: HistoryStyle.secondaryText),
                        suffixIcon: searchController.text.isEmpty
                            ? null
                            : IconButton(
                                tooltip: 'Aramayı temizle',
                                icon: const Icon(Icons.close_rounded, color: HistoryStyle.secondaryText),
                                onPressed: searchController.clear,
                              ),
                        filled: true,
                        fillColor: HistoryStyle.innerSurface,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: HistoryStyle.borderSoft)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: HistoryStyle.accent)),
                      ),
                    ),
                  )
                : const SizedBox.shrink(key: ValueKey('mathpro-history-search-closed')),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.tooltip, required this.onPressed, required this.icon, this.emphasized = false});

  final String tooltip;
  final VoidCallback onPressed;
  final IconData icon;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: emphasized ? HistoryStyle.elevatedSurface : HistoryStyle.innerSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: emphasized ? HistoryStyle.border : HistoryStyle.borderSoft),
          ),
          child: Icon(icon, color: emphasized ? HistoryStyle.primaryText : HistoryStyle.secondaryText, size: 20),
        ),
      ),
    );
  }
}

class _HistoryIconBadge extends StatelessWidget {
  const _HistoryIconBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            HistoryStyle.accent.withValues(alpha: 0.22),
            HistoryStyle.innerSurface,
          ],
        ),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: HistoryStyle.accent.withValues(alpha: 0.36)),
        boxShadow: <BoxShadow>[BoxShadow(color: HistoryStyle.accent.withValues(alpha: 0.10), blurRadius: 18, offset: const Offset(0, 8))],
      ),
      child: const Icon(Icons.history_rounded, color: HistoryStyle.accent, size: 22),
    );
  }
}

class _HistoryHeaderMeta extends StatelessWidget {
  const _HistoryHeaderMeta({required this.totalCount, required this.pinnedCount, required this.restored});

  final int totalCount;
  final int pinnedCount;
  final bool restored;

  @override
  Widget build(BuildContext context) {
    final pieces = <String>[
      '$totalCount kayıt',
      if (pinnedCount > 0) '$pinnedCount sabit',
      restored ? 'cihazda korunuyor' : 'yükleniyor',
    ];
    return Text(
      pieces.join(' • '),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: HistoryStyle.secondaryText, fontSize: 12, fontWeight: FontWeight.w700),
    );
  }
}

class _HistorySectionView extends StatelessWidget {
  const _HistorySectionView({
    required this.section,
    required this.onEntrySelected,
    required this.onGraphSelected,
    required this.onResultSelected,
    required this.onDeleteEntry,
    required this.onTogglePinned,
  });

  final HistorySection section;
  final ValueChanged<HistoryEntry> onEntrySelected;
  final ValueChanged<HistoryEntry> onGraphSelected;
  final ValueChanged<HistoryEntry> onResultSelected;
  final ValueChanged<HistoryEntry> onDeleteEntry;
  final ValueChanged<HistoryEntry> onTogglePinned;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 14, 2, 8),
          child: Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: HistoryStyle.accent.withValues(alpha: 0.72), borderRadius: BorderRadius.circular(99)),
              ),
              const SizedBox(width: 8),
              Text(section.title, style: const TextStyle(color: HistoryStyle.secondaryText, fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 0.9)),
            ],
          ),
        ),
        ...section.entries.map(
          (entry) => HistoryItemCard(
            entry: entry,
            onPrimaryTap: entry.graphExpression == null ? () => onEntrySelected(entry) : () => onGraphSelected(entry),
            onEdit: () => onEntrySelected(entry),
            onDelete: () => onDeleteEntry(entry),
            onTogglePinned: () => onTogglePinned(entry),
            onGraphTap: entry.graphExpression == null ? null : () => onGraphSelected(entry),
            onUseResult: entry.canUseResult ? () => onResultSelected(entry) : null,
          ),
        ),
      ],
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.searching});

  final bool searching;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[HistoryStyle.cardTop, HistoryStyle.cardBottom],
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: HistoryStyle.border),
                boxShadow: const <BoxShadow>[BoxShadow(color: HistoryStyle.shadow, blurRadius: 18, offset: Offset(0, 10))],
              ),
              child: Icon(searching ? Icons.search_off_rounded : Icons.history_toggle_off_rounded, color: HistoryStyle.secondaryText, size: 25),
            ),
            const SizedBox(height: 14),
            Text(
              searching ? 'Bu aramayla eşleşen geçmiş kaydı yok.' : 'Henüz geçmiş yok. Hesap yaptıkça burada premium kartlar halinde görünecek.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: HistoryStyle.secondaryText, fontSize: 14, fontWeight: FontWeight.w700, height: 1.35),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCloseGrip extends StatelessWidget {
  const _HistoryCloseGrip();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Container(
        width: 54,
        height: 5,
        decoration: BoxDecoration(
          color: HistoryStyle.secondaryText.withValues(alpha: 0.30),
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}
