import 'package:flutter/material.dart';

import '../../logic/action_utils.dart';
import '../../services/haptics_service.dart';
import '../formula_engine/premium_editor_performance_policy.dart';
import '../formula_engine/unified_math_preview_policy.dart';
import '../keyboard/premium_popup_fit_policy.dart';
import '../mathlive/mathlive_full_keyboard_warmup_q382r33_policy.dart';
import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import 'math_label.dart';

class TemplateTray extends StatefulWidget {
  const TemplateTray({
    super.key,
    required this.activeTab,
    required this.onTemplateSelected,
  });

  final String activeTab;
  final ValueChanged<String> onTemplateSelected;

  @override
  State<TemplateTray> createState() => _TemplateTrayState();
}

@immutable
class _Q382R33MoreChipWarmup {
  const _Q382R33MoreChipWarmup({
    required this.displayLabel,
    required this.mathLabel,
    required this.minWidthRegular,
    required this.minWidthCompact,
  });

  final String displayLabel;
  final bool mathLabel;
  final double minWidthRegular;
  final double minWidthCompact;
}

final Map<String, _Q382R33MoreChipWarmup> _q382r33MoreChipWarmupCache = <String, _Q382R33MoreChipWarmup>{
  for (final label in MathLiveFullKeyboardWarmupQ382R33Policy.moreTemplateLabels())
    label: _Q382R33MoreChipWarmup(
      displayLabel: UnifiedMathPreviewPolicy.visibleDisplayLabel(label),
      mathLabel: UnifiedMathPreviewPolicy.shouldRenderMathGlyph(label) &&
          !UnifiedMathPreviewPolicy.isHumanReadableTextLabel(label),
      minWidthRegular: PremiumPopupFitPolicy.moreChipMinWidth(
        UnifiedMathPreviewPolicy.moreChipMinWidth(
          UnifiedMathPreviewPolicy.visibleDisplayLabel(label),
          compact: false,
        ),
        compact: false,
      ),
      minWidthCompact: PremiumPopupFitPolicy.moreChipMinWidth(
        UnifiedMathPreviewPolicy.moreChipMinWidth(
          UnifiedMathPreviewPolicy.visibleDisplayLabel(label),
          compact: true,
        ),
        compact: true,
      ),
    ),
};

class _TemplateTrayState extends State<TemplateTray> with AutomaticKeepAliveClientMixin<TemplateTray> {
  late String _activeCategoryTitle;

  @override
  void initState() {
    super.initState();
    _activeCategoryTitle = ActionUtils.defaultMoreCategoryForTab(widget.activeTab);
  }

  @override
  void didUpdateWidget(covariant TemplateTray oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeTab != widget.activeTab) {
      _activeCategoryTitle = ActionUtils.defaultMoreCategoryForTab(widget.activeTab);
    }
  }

  @override
  bool get wantKeepAlive => MathLiveFullKeyboardWarmupQ382R33Policy.moreTrayKeepAliveEnabled;

  MorePanelCategory get _activeCategory {
    return ActionUtils.morePanelCategories.firstWhere(
      (category) => category.title == _activeCategoryTitle,
      orElse: () => ActionUtils.morePanelCategories.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight.isFinite && constraints.maxHeight < 112;
        final verticalPadding = compact
            ? PremiumPopupFitPolicy.moreTrayVerticalPaddingCompact
            : PremiumPopupFitPolicy.moreTrayVerticalPaddingRegular;
        final headerHeight = compact
            ? PremiumPopupFitPolicy.moreTrayHeaderHeightCompact
            : PremiumPopupFitPolicy.moreTrayHeaderHeightRegular;
        final categoryHeight = compact
            ? PremiumPopupFitPolicy.moreTrayCategoryHeightCompact
            : PremiumPopupFitPolicy.moreTrayCategoryHeightRegular;
        final chipHeight = compact
            ? PremiumPopupFitPolicy.moreTrayChipHeightCompact
            : PremiumPopupFitPolicy.moreTrayChipHeightRegular;
        final gap = compact ? PremiumPopupFitPolicy.moreTrayGapCompact : PremiumPopupFitPolicy.moreTrayGapRegular;
        final activeCategory = _activeCategory;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: PremiumPopupFitPolicy.moreTrayHorizontalMargin),
          padding: EdgeInsets.symmetric(
            horizontal: PremiumPopupFitPolicy.moreTrayHorizontalPadding,
            vertical: verticalPadding,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(19, 21, 24, 0.985),
            borderRadius: BorderRadius.circular(MathProRadius.lg),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.095)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.32),
                blurRadius: 15,
                offset: Offset(0, 7),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: headerHeight,
                child: Row(
                  children: [
                    Text(
                      'MORE',
                      style: MathProTypography.workspaceHint.copyWith(
                        color: MathProColors.text,
                        fontSize: compact ? 10.3 : 11.3,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.72,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      '·',
                      style: MathProTypography.workspaceHint.copyWith(
                        color: MathProColors.textFaint,
                        fontSize: compact ? 11.0 : 12.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        activeCategory.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: MathProTypography.workspaceHint.copyWith(
                          color: MathProColors.textMuted,
                          fontSize: compact ? 10.3 : 11.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: gap),
              SizedBox(
                height: categoryHeight,
                child: SingleChildScrollView(
                  key: ValueKey('mathpro-more-categories-scroll-${activeCategory.title}'),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: PremiumPopupFitPolicy.moreScrollHorizontalPadding),
                  child: Row(
                    children: [
                      for (var index = 0; index < ActionUtils.morePanelCategories.length; index++) ...[
                        _CategoryChip(
                          label: ActionUtils.morePanelCategories[index].title,
                          compact: compact,
                          selected: ActionUtils.morePanelCategories[index].title == activeCategory.title,
                          onPressed: () {
                            HapticsService.selectionClick();
                            setState(() => _activeCategoryTitle = ActionUtils.morePanelCategories[index].title);
                          },
                        ),
                        if (index != ActionUtils.morePanelCategories.length - 1) SizedBox(width: compact ? 4 : 6),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: gap),
              SizedBox(
                height: chipHeight,
                child: SingleChildScrollView(
                  key: ValueKey('mathpro-more-chip-scroll-${activeCategory.title}'),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: PremiumPopupFitPolicy.moreScrollHorizontalPadding),
                  child: Row(
                    children: [
                      for (var index = 0; index < activeCategory.labels.length; index++) ...[
                        _TemplateChip(
                          label: activeCategory.labels[index],
                          compact: compact,
                          onPressed: () => widget.onTemplateSelected(activeCategory.labels[index]),
                        ),
                        if (index != activeCategory.labels.length - 1) SizedBox(width: compact ? 4 : 6),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.label, required this.compact, required this.selected, required this.onPressed});

  final String label;
  final bool compact;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'MORE kategorisi $label',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: AnimatedContainer(
          key: ValueKey('mathpro-more-category-$label'),
          duration: const Duration(milliseconds: PremiumEditorPerformancePolicy.categorySelectionAnimationMs),
          curve: Curves.easeOutCubic,
          height: compact ? 21 : 24,
          padding: EdgeInsets.symmetric(
            horizontal: compact
                ? PremiumPopupFitPolicy.moreCategoryHorizontalPaddingCompact
                : PremiumPopupFitPolicy.moreCategoryHorizontalPaddingRegular,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? MathProColors.accentSoft : const Color.fromRGBO(255, 255, 255, 0.045),
            borderRadius: BorderRadius.circular(MathProRadius.md),
            border: Border.all(
              color: selected ? const Color.fromRGBO(116, 170, 156, 0.34) : const Color.fromRGBO(255, 255, 255, 0.07),
            ),
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: MathProTypography.keyTextExpanded.copyWith(
              color: selected ? MathProColors.text : MathProColors.textMuted,
              fontSize: compact ? 9.0 : 10.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _TemplateChip extends StatefulWidget {
  const _TemplateChip({required this.label, required this.compact, required this.onPressed});

  final String label;
  final bool compact;
  final VoidCallback onPressed;

  @override
  State<_TemplateChip> createState() => _TemplateChipState();
}

class _TemplateChipState extends State<_TemplateChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final warmup = _q382r33MoreChipWarmupCache[widget.label];
    final displayLabel = warmup?.displayLabel ?? UnifiedMathPreviewPolicy.visibleDisplayLabel(widget.label);
    final mathLabel = warmup?.mathLabel ??
        (UnifiedMathPreviewPolicy.shouldRenderMathGlyph(widget.label) &&
            !UnifiedMathPreviewPolicy.isHumanReadableTextLabel(widget.label));
    return Semantics(
      button: true,
      label: 'MORE şablonu ${widget.label}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          setState(() => _pressed = true);
          HapticsService.selectionClick();
        },
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          duration: const Duration(milliseconds: PremiumEditorPerformancePolicy.moreChipPressAnimationMs),
          curve: Curves.easeOutCubic,
          scale: _pressed ? 0.966 : 1,
          child: Container(
            key: ValueKey('mathpro-more-chip-${widget.label}'),
            constraints: BoxConstraints(
              minWidth: _minWidthFor(displayLabel, compact: widget.compact),
              maxWidth: PremiumPopupFitPolicy.moreChipMaxWidth(
                UnifiedMathPreviewPolicy.moreChipMaxWidth(displayLabel, compact: widget.compact),
                compact: widget.compact,
              ),
            ),
            height: widget.compact
                ? PremiumPopupFitPolicy.moreTrayChipHeightCompact
                : PremiumPopupFitPolicy.moreTrayChipHeightRegular,
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact
                  ? PremiumPopupFitPolicy.moreTemplateHorizontalPaddingCompact
                  : PremiumPopupFitPolicy.moreTemplateHorizontalPaddingRegular,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mathLabel ? const Color.fromRGBO(116, 170, 156, 0.145) : const Color.fromRGBO(28, 30, 34, 1),
              borderRadius: BorderRadius.circular(MathProRadius.md),
              border: Border.all(
                color: mathLabel ? const Color.fromRGBO(116, 170, 156, 0.25) : const Color.fromRGBO(255, 255, 255, 0.075),
              ),
            ),
            child: ClipRect(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      displayLabel,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: MathProTypography.keyTextExpanded.copyWith(
                        fontSize: widget.compact ? 9.3 : 10.3,
                        fontWeight: FontWeight.w800,
                        color: MathProColors.text,
                      ),
                    ),
                  ),
                  if (displayLabel != widget.label)
                    Opacity(
                      opacity: 0,
                      child: IgnorePointer(
                        child: Text(
                          widget.label,
                          maxLines: 1,
                          style: MathProTypography.keyTextExpanded.copyWith(fontSize: 1, color: MathProColors.text),
                        ),
                      ),
                    ),
                  if (UnifiedMathPreviewPolicy.shouldRenderMathGlyph(widget.label))
                    Opacity(
                      opacity: 0,
                      child: IgnorePointer(
                        child: MathLabel(label: widget.label, variant: MathLabelVariant.chip, color: MathProColors.text),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _minWidthFor(String label, {required bool compact}) {
    final warmup = _q382r33MoreChipWarmupCache[widget.label];
    if (warmup != null) return compact ? warmup.minWidthCompact : warmup.minWidthRegular;
    return PremiumPopupFitPolicy.moreChipMinWidth(
      UnifiedMathPreviewPolicy.moreChipMinWidth(label, compact: compact),
      compact: compact,
    );
  }
}
