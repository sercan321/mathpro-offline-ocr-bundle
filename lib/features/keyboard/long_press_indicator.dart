import 'package:flutter/material.dart';

import '../../theme/mathpro_tokens.dart';

class LongPressIndicator extends StatelessWidget {
  const LongPressIndicator({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final width = compact ? 13.2 : 14.8;
    final height = compact ? 6.6 : 7.2;
    final dot = compact ? 2.0 : 2.25;
    return Positioned(
      top: compact ? 4 : 5,
      right: compact ? 4 : 5,
      child: IgnorePointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: MathProColors.accent.withValues(alpha: 0.125),
            borderRadius: BorderRadius.circular(height),
            border: Border.all(
              color: MathProColors.accent.withValues(alpha: 0.255),
              width: 0.55,
            ),
          ),
          child: SizedBox(
            width: width,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Dot(size: dot, opacity: 0.78),
                SizedBox(width: compact ? 1.45 : 1.65),
                _Dot(size: dot, opacity: 0.78),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: MathProColors.textSoft.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }
}
