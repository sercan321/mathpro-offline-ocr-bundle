import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';
import '../../theme/mathpro_typography.dart';
import '../editor/render/math_render_surface.dart';
import 'result_status_compact_copy.dart';

class ResultView extends StatefulWidget {
  const ResultView({
    super.key,
    this.value = '0',
    this.resultStatusMessage,
    this.forceCompactStatus = false,
  });

  final String value;
  final String? resultStatusMessage;
  final bool forceCompactStatus;

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final rawValue = widget.value.trim();
        final resultStatusMessage = widget.resultStatusMessage?.trim() ?? '';
        final hasResultValue = rawValue.isNotEmpty && rawValue != '—';
        final statusPanelIsTight = constraints.maxHeight.isFinite && constraints.maxHeight < 48.0;
        final statusWidthIsTight = constraints.maxWidth.isFinite && constraints.maxWidth < 260.0;
        final useCompactStatusCopy = widget.forceCompactStatus || statusPanelIsTight || statusWidthIsTight;
        final displayExpression = hasResultValue
            ? rawValue.startsWith('=')
                ? rawValue
                : '= $rawValue'
            : '';

        if (!hasResultValue && resultStatusMessage.isNotEmpty) {
          final displayStatusMessage = ResultStatusCopyResolver.displayText(
            resultStatusMessage,
            compactMode: useCompactStatusCopy,
          );
          return Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                displayStatusMessage,
                key: const ValueKey('mathpro-result-status-message'),
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                textAlign: TextAlign.left,
                style: MathProTypography.workspaceHint.copyWith(
                  color: MathProColors.accent.withValues(alpha: 0.70),
                  fontSize: useCompactStatusCopy ? 11.0 : 12.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.03,
                  height: 1.0,
                ),
              ),
            ),
          );
        }

        if (!hasResultValue) {
          return const SizedBox.shrink(key: ValueKey('mathpro-result-empty-state'));
        }

        return Align(
          alignment: Alignment.centerRight,
          child: ClipRect(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              reverse: true,
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth.isFinite ? constraints.maxWidth : 120.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerRight,
                    child: MathRenderSurface(
                      key: const ValueKey('mathpro-result-math-render-surface'),
                      expression: displayExpression,
                      role: MathRenderSurfaceRole.result,
                      textAlign: TextAlign.right,
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
}
