import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../services/haptics_service.dart';
import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import 'key_config.dart';
import '../mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart';
import 'keyboard_long_press_anchor.dart';
import 'long_press_popup.dart';
import 'math_keyboard.dart';

class BottomDock extends StatefulWidget {
  const BottomDock({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
    required this.onKeyPressed,
  });

  final String activeTab;
  final ValueChanged<String> onTabChanged;
  final ValueChanged<String> onKeyPressed;

  @override
  State<BottomDock> createState() => _BottomDockState();
}

class _BottomDockState extends State<BottomDock> {
  final GlobalKey _longPressLayerKey = GlobalKey(debugLabel: 'mathpro-long-press-layer');

  String? _longPressKey;
  double? _longPressAnchorCenterX;

  @override
  void initState() {
    super.initState();
    if (MathLiveFullKeyboardWarmupQ382R33Policy.longPressPopupPrerenderEnabled) {
      warmupLongPressPopupLayoutCacheQ382R33(
        MathLiveFullKeyboardWarmupQ382R33Policy.longPressOptionGroups(),
      );
    }
  }

  List<String> get _longPressOptions {
    final key = _longPressKey;
    if (key == null) return const <String>[];
    return KeyConfig.getLongPressOptions(key, widget.activeTab).where((option) => option != key).toList(growable: false);
  }

  void _closeLongPress() {
    if (_longPressKey == null && _longPressAnchorCenterX == null) return;
    setState(() {
      _longPressKey = null;
      _longPressAnchorCenterX = null;
    });
  }

  double? _localAnchorCenterXFor(KeyboardLongPressAnchor anchor) {
    if (anchor.globalRect == Rect.zero) return null;
    final context = _longPressLayerKey.currentContext;
    final renderObject = context?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return null;
    return renderObject.globalToLocal(anchor.globalCenter).dx;
  }

  void _openLongPress(KeyboardLongPressAnchor anchor) {
    final options = KeyConfig.getLongPressOptions(anchor.label, widget.activeTab).where((option) => option != anchor.label).toList(growable: false);
    if (options.isEmpty) return;
    setState(() {
      _longPressKey = anchor.label;
      _longPressAnchorCenterX = _localAnchorCenterXFor(anchor);
    });
  }

  void _selectLongPressOption(String label) {
    _closeLongPress();
    widget.onKeyPressed(label);
    HapticsService.selectionClick();
  }

  void _handleKeyPressed(String label) {
    _closeLongPress();
    widget.onKeyPressed(label);
  }

  void _handleTabChanged(String tab) {
    _closeLongPress();
    widget.onTabChanged(tab);
  }

  @override
  void didUpdateWidget(covariant BottomDock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeTab != widget.activeTab && _longPressKey != null) {
      _longPressKey = null;
      _longPressAnchorCenterX = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final longPressOptions = _longPressOptions;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxOuterHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : KeyboardDockMetrics.targetTotalHeight(media);
        final bottomInset = KeyboardDockMetrics.bottomInset(media);
        final layout = _KeyboardLayout.fromMedia(
          media,
          maxOuterHeight: maxOuterHeight,
          bottomInset: bottomInset,
        );

        final keyboardShell = Container(
          key: const ValueKey('mathpro-keyboard-shell'),
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            layout.shellPadding,
            layout.shellPadding,
            layout.shellPadding,
            0,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF101315),
                Color(0xFF080A0B),
                Color(0xFF040506),
              ],
              stops: [0.0, 0.58, 1.0],
            ),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: MathProColors.border, width: 0.9),
            boxShadow: MathProShadows.dock,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: layout.tabHeaderHeight,
                child: _ShellTabs(
                  activeTab: widget.activeTab,
                  onTabChanged: _handleTabChanged,
                  gap: layout.tabGap,
                  chipHeight: layout.tabChipHeight,
                ),
              ),
              SizedBox(height: layout.tabMarginBottom),
              SizedBox(
                height: layout.contentHeight,
                child: MathKeyboard(
                  activeTab: widget.activeTab,
                  onKeyPressed: _handleKeyPressed,
                  onKeyLongPressed: _openLongPress,
                ),
              ),
            ],
          ),
        );

        return SizedBox(
          height: maxOuterHeight,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 2, 16, bottomInset),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [MathProColors.bg, Color(0xFF030404)],
              ),
            ),
            child: Stack(
              key: _longPressLayerKey,
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Align(alignment: Alignment.bottomCenter, child: keyboardShell),
                if (longPressOptions.isNotEmpty)
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: LongPressPopup(
                      options: longPressOptions,
                      activeTab: widget.activeTab,
                      anchorCenterX: _longPressAnchorCenterX,
                      onSelected: _selectLongPressOption,
                      onDismissed: _closeLongPress,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ShellTabs extends StatelessWidget {
  const _ShellTabs({
    required this.activeTab,
    required this.onTabChanged,
    required this.gap,
    required this.chipHeight,
  });

  final String activeTab;
  final ValueChanged<String> onTabChanged;
  final double gap;
  final double chipHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 1),
      itemCount: KeyConfig.tabs.length,
      separatorBuilder: (_, __) => SizedBox(width: gap),
      itemBuilder: (context, index) {
        final tab = KeyConfig.tabs[index];
        final active = tab == activeTab;
        return _TabChip(
          label: tab,
          active: active,
          height: chipHeight,
          onPressed: () => onTabChanged(tab),
        );
      },
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.active,
    required this.height,
    required this.onPressed,
  });

  final String label;
  final bool active;
  final double height;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => HapticsService.selectionClick(),
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        constraints: BoxConstraints(minWidth: label == 'Lineer Cebir' ? 66 : 53),
        height: height,
        padding: EdgeInsets.symmetric(horizontal: label == 'Lineer Cebir' ? 7 : 7.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: active
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(116, 190, 180, 0.30), Color.fromRGBO(38, 70, 66, 0.39), Color.fromRGBO(11, 22, 21, 0.94)],
                  stops: [0.0, 0.50, 1.0],
                )
              : const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromRGBO(255, 255, 255, 0.046), Color.fromRGBO(255, 255, 255, 0.014), Color.fromRGBO(0, 0, 0, 0.15)],
                  stops: [0.0, 0.58, 1.0],
                ),
          borderRadius: BorderRadius.circular(11.5),
          border: Border.all(
            color: active ? const Color.fromRGBO(116, 190, 180, 0.52) : const Color.fromRGBO(222, 232, 235, 0.080),
            width: active ? 1.05 : 0.85,
          ),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color.fromRGBO(116, 190, 180, 0.125),
                    blurRadius: 12,
                    spreadRadius: -7,
                    offset: Offset(0, 5),
                  ),
                ]
              : const <BoxShadow>[],
        ),
        child: Text(
          _displayLabelFor(label),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: MathProTypography.tabText.copyWith(
            color: active ? MathProColors.text : MathProColors.textFaint.withValues(alpha: 0.92),
            fontWeight: active ? FontWeight.w900 : FontWeight.w800,
            letterSpacing: active ? 0.06 : 0.02,
          ),
        ),
      ),
    );
  }
}

String _displayLabelFor(String label) => label == 'Lineer Cebir' ? 'Lineer' : label;

class KeyboardDockMetrics {
  const KeyboardDockMetrics._();

  static double bottomInset(MediaQueryData media) {
    final reportedInset = math.max(
      media.viewPadding.bottom,
      math.max(media.padding.bottom, media.systemGestureInsets.bottom),
    );
    final guardedInset = reportedInset <= 0 ? 38.0 : reportedInset;
    return guardedInset.clamp(30.0, 58.0).toDouble();
  }

  static double targetTotalHeight(MediaQueryData media, {double? availableHeight}) {
    final available = availableHeight ?? media.size.height;
    final width = media.size.width;
    final screenHeight = media.size.height;
    final isTablet = width >= 768 && screenHeight >= 700;
    final ratio = isTablet
        ? 0.40
        : screenHeight < 700
            ? 0.46
            : screenHeight >= 840
                ? 0.425
                : 0.435;
    final preferred = _KeyboardLayout.preferredOuterHeight(media, bottomInset: bottomInset(media));
    final ratioHeight = available * ratio;
    final maxHeight = available * (isTablet ? 0.44 : 0.465);
    final minHeight = math.min(maxHeight, isTablet ? 318.0 : 294.0);
    final ratioCeiling = math.min(maxHeight, math.max(minHeight, ratioHeight + 18.0));
    // V57: snap the dock height down to a physical logical pixel so
    // AppShell + BottomDock never exceed the viewport by fractional rounding.
    return preferred.clamp(minHeight, ratioCeiling).floorToDouble();
  }
}

class _KeyboardLayout {
  const _KeyboardLayout({
    required this.shellPadding,
    required this.contentHeight,
    required this.tabHeaderHeight,
    required this.tabMarginBottom,
    required this.tabGap,
  });

  final double shellPadding;
  final double contentHeight;
  final double tabHeaderHeight;
  final double tabMarginBottom;
  final double tabGap;

  // The visible tab chip must never be taller than the tab header slot.
  // V45's fixed 28dp chip caused a real-device RenderFlex overflow by 1.8px
  // on short Android screens where the compact header is 26dp high.
  double get tabChipHeight => math.min(28.0, tabHeaderHeight);

  double get shellHeight => shellPadding + tabHeaderHeight + tabMarginBottom + contentHeight;

  static double preferredOuterHeight(MediaQueryData media, {required double bottomInset}) {
    final preferred = _preferredFor(media);
    return 2 + bottomInset + preferred.shellHeight;
  }

  factory _KeyboardLayout.fromMedia(
    MediaQueryData media, {
    required double maxOuterHeight,
    required double bottomInset,
  }) {
    final preferred = _preferredFor(media);
    final availableContentHeight = maxOuterHeight -
        2 -
        bottomInset -
        preferred.shellPadding -
        preferred.tabHeaderHeight -
        preferred.tabMarginBottom;

    // Real V45.1 logs still reported a bottom RenderFlex overflow of 1.8px
    // inside the BottomDock shell on the locked 360x740 profile. The issue was
    // not the key topology; it was sub-pixel rounding between the outer dock
    // constraint, shell padding, tab header, margin, and the fixed keyboard grid
    // height. Reserve a tiny invisible gutter so the visual keyboard compresses
    // by less than half a pixel per expanded row instead of overflowing.
    const layoutRoundingGuard = 3.0;
    final safeAvailableContentHeight = math.max(
      0.0,
      availableContentHeight - layoutRoundingGuard,
    );
    final preferredMinContent = media.size.height < 700 ? 210.0 : 238.0;

    // Never force the keyboard grid to be taller than the space actually
    // granted by AppShell/test constraints. Earlier builds clamped to a hard
    // 210dp minimum; when the available grid area was 205dp, BottomDock
    // overflowed by exactly 5px in widget tests. The visual keyboard still
    // prefers the premium minimum on real devices, but under tight constraints
    // it compresses instead of producing a RenderFlex overflow.
    final lowerBound = math.min(preferredMinContent, safeAvailableContentHeight);
    final upperBound = math.max(lowerBound, safeAvailableContentHeight);
    final contentHeight = preferred.contentHeight.clamp(lowerBound, upperBound).toDouble();
    return _KeyboardLayout(
      shellPadding: preferred.shellPadding,
      contentHeight: contentHeight,
      tabHeaderHeight: preferred.tabHeaderHeight,
      tabMarginBottom: preferred.tabMarginBottom,
      tabGap: preferred.tabGap,
    );
  }

  static _KeyboardLayout _preferredFor(MediaQueryData media) {
    final width = media.size.width;
    final height = media.size.height;
    final isVeryShort = height < 700;
    final isTablet = width >= 768 && !isVeryShort;
    final isSmallPhone = !isTablet && (height < 700 || width < 360);
    final isLargePhone = !isTablet && height >= 840;

    if (isVeryShort) {
      return const _KeyboardLayout(
        shellPadding: 5,
        contentHeight: 224,
        tabHeaderHeight: 26,
        tabMarginBottom: 3,
        tabGap: 4,
      );
    }

    if (isTablet) {
      return const _KeyboardLayout(
        shellPadding: 8,
        contentHeight: 296,
        tabHeaderHeight: 32,
        tabMarginBottom: 5,
        tabGap: 6,
      );
    }

    if (isSmallPhone) {
      return const _KeyboardLayout(
        shellPadding: 5,
        contentHeight: 250,
        tabHeaderHeight: 28,
        tabMarginBottom: 3,
        tabGap: 4,
      );
    }

    if (isLargePhone) {
      return const _KeyboardLayout(
        shellPadding: 6,
        contentHeight: 276,
        tabHeaderHeight: 31,
        tabMarginBottom: 4,
        tabGap: 5,
      );
    }

    return const _KeyboardLayout(
      shellPadding: 6,
      contentHeight: 268,
      tabHeaderHeight: 31,
      tabMarginBottom: 4,
      tabGap: 5,
    );
  }
}
