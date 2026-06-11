import 'package:flutter/material.dart';

import 'graph_color_hierarchy.dart';
import 'graph_models.dart';
import 'graph_style.dart';

class GraphSettingsSheet extends StatefulWidget {
  const GraphSettingsSheet({
    super.key,
    required this.expression,
    this.renderMode = GraphRenderMode.twoD,
    this.onRenderModeChanged,
    this.onApply,
  });

  final GraphExpression expression;
  final GraphRenderMode renderMode;
  final ValueChanged<GraphRenderMode>? onRenderModeChanged;
  final ValueChanged<GraphExpression>? onApply;

  @override
  State<GraphSettingsSheet> createState() => _GraphSettingsSheetState();
}

class _GraphSettingsSheetState extends State<GraphSettingsSheet> {
  late final TextEditingController _xMin;
  late final TextEditingController _xMax;
  late final TextEditingController _yMin;
  late final TextEditingController _yMax;
  late bool _traceEnabled;
  late GraphRenderMode _renderMode;
  late String _curveColorKey;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    final expression = widget.expression;
    _xMin = TextEditingController(text: _format(expression.xMin));
    _xMax = TextEditingController(text: _format(expression.xMax));
    _yMin = TextEditingController(text: _format(expression.yMin));
    _yMax = TextEditingController(text: _format(expression.yMax));
    _traceEnabled = expression.traceEnabled;
    _renderMode = widget.renderMode;
    _curveColorKey = GraphFunctionColorPalette.byKey(expression.graphColorKey).key;

    _xMin.addListener(_clearErrorOnEdit);
    _xMax.addListener(_clearErrorOnEdit);
    _yMin.addListener(_clearErrorOnEdit);
    _yMax.addListener(_clearErrorOnEdit);
  }

  @override
  void dispose() {
    _xMin.removeListener(_clearErrorOnEdit);
    _xMax.removeListener(_clearErrorOnEdit);
    _yMin.removeListener(_clearErrorOnEdit);
    _yMax.removeListener(_clearErrorOnEdit);
    _xMin.dispose();
    _xMax.dispose();
    _yMin.dispose();
    _yMax.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return SafeArea(
      top: false,
      child: DecoratedBox(
        key: const ValueKey('mathpro-graph-settings-sheet-q222'),
        decoration: BoxDecoration(
          color: GraphStyle.cardAlt,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xF2222B2E),
              Color(0xF213181B),
              Color(0xF20A0F11),
            ],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border(top: BorderSide(color: GraphStyle.tealBorder.withValues(alpha: 0.34))),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.48),
              blurRadius: 36,
              offset: const Offset(0, -12),
            ),
            BoxShadow(
              color: GraphStyle.accent.withValues(alpha: 0.10),
              blurRadius: 28,
              spreadRadius: -12,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: GraphStyle.textSecondary.withValues(alpha: 0.32),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    _SettingsGlyph(active: _traceEnabled),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Graph Settings',
                            style: TextStyle(color: GraphStyle.text, fontSize: 19, fontWeight: FontWeight.w900, letterSpacing: -0.2),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Mode, window and trace controls',
                            style: TextStyle(color: GraphStyle.textSecondary, fontSize: 11.5, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    _SheetIconButton(
                      key: const ValueKey('mathpro-graph-settings-close'),
                      tooltip: 'Kapat',
                      icon: Icons.close_rounded,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const _SectionTitle(label: 'Mode'),
                const SizedBox(height: 8),
                _ModeSegmentedControl(
                  key: const ValueKey('mathpro-graph-settings-mode-segment'),
                  mode: _renderMode,
                  onChanged: (mode) => setState(() => _renderMode = mode),
                ),
                const SizedBox(height: 14),
                const _SectionTitle(label: 'Window'),
                const SizedBox(height: 8),
                DecoratedBox(
                  key: const ValueKey('mathpro-graph-settings-window-fields'),
                  decoration: _glassBoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(child: _NumberField(label: 'x min', controller: _xMin)),
                            const SizedBox(width: 10),
                            Expanded(child: _NumberField(label: 'x max', controller: _xMax)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Expanded(child: _NumberField(label: 'y min', controller: _yMin)),
                            const SizedBox(width: 10),
                            Expanded(child: _NumberField(label: 'y max', controller: _yMax)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const _SectionTitle(label: 'Trace'),
                const SizedBox(height: 8),
                _TraceToggle(
                  key: const ValueKey('mathpro-graph-settings-trace-toggle'),
                  value: _traceEnabled,
                  onChanged: (value) => setState(() => _traceEnabled = value),
                ),
                const SizedBox(height: 14),
                const _SectionTitle(label: 'Fonksiyon Rengi'),
                const SizedBox(height: 8),
                _CurveColorPicker(
                  key: const ValueKey('mathpro-graph-settings-function-color-picker-q234'),
                  selectedKey: _curveColorKey,
                  onChanged: (key) => setState(() => _curveColorKey = key),
                ),
                if (_errorText != null) ...<Widget>[
                  const SizedBox(height: 12),
                  _ErrorBanner(text: _errorText!),
                ],
                const SizedBox(height: 14),
                const _SectionTitle(label: 'Actions'),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: _SecondaryActionButton(
                        key: const ValueKey('mathpro-graph-settings-reset-view'),
                        label: 'Reset View',
                        icon: Icons.restart_alt_rounded,
                        onPressed: _resetView,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _PrimaryActionButton(
                        key: const ValueKey('mathpro-graph-settings-apply'),
                        label: 'Apply',
                        icon: Icons.check_rounded,
                        onPressed: _apply,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _glassBoxDecoration() {
    return BoxDecoration(
      color: GraphStyle.cardAlt.withValues(alpha: 0.64),
      gradient: GraphStyle.controlGradient,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: GraphStyle.graphiteLine),
      boxShadow: GraphStyle.controlShadow(active: _traceEnabled),
    );
  }

  void _clearErrorOnEdit() {
    if (!mounted || _errorText == null) return;
    setState(() => _errorText = null);
  }

  _ViewportDraft? _readViewport({required bool showErrors}) {
    final xMin = _parse(_xMin.text);
    final xMax = _parse(_xMax.text);
    final yMin = _parse(_yMin.text);
    final yMax = _parse(_yMax.text);
    if (xMin == null || xMax == null || yMin == null || yMax == null) {
      if (showErrors) setState(() => _errorText = 'Window values must be finite numbers.');
      return null;
    }
    final validationError = GraphViewportPolicy.validateRange(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax);
    if (validationError != null) {
      if (showErrors) setState(() => _errorText = validationError);
      return null;
    }
    return _ViewportDraft(xMin: xMin, xMax: xMax, yMin: yMin, yMax: yMax);
  }

  GraphExpression? _draftExpression({required bool showErrors}) {
    final parsed = _readViewport(showErrors: showErrors);
    if (parsed == null) return null;
    final color = GraphFunctionColorPalette.byKey(_curveColorKey);
    return GraphViewportPolicy.sanitize(
      widget.expression.copyWith(
        xMin: parsed.xMin,
        xMax: parsed.xMax,
        yMin: parsed.yMin,
        yMax: parsed.yMax,
        traceEnabled: _traceEnabled,
        graphColor: color.color,
        graphColorKey: color.key,
      ),
    );
  }

  void _resetView() {
    final reset = widget.expression.resetViewport();
    _writeViewport(reset.xMin, reset.xMax, reset.yMin, reset.yMax);
    final color = GraphFunctionColorPalette.byKey(_curveColorKey);
    final updated = GraphViewportPolicy.sanitize(
      reset.copyWith(traceEnabled: _traceEnabled, graphColor: color.color, graphColorKey: color.key),
    );
    widget.onApply?.call(updated);
    setState(() => _errorText = null);
  }

  void _apply() {
    final updated = _draftExpression(showErrors: true);
    if (updated == null) return;
    widget.onRenderModeChanged?.call(_renderMode);
    widget.onApply?.call(updated);
    Navigator.of(context).pop(updated);
  }

  void _writeViewport(double xMin, double xMax, double yMin, double yMax) {
    _xMin.text = _format(xMin);
    _xMax.text = _format(xMax);
    _yMin.text = _format(yMin);
    _yMax.text = _format(yMax);
  }

  static double? _parse(String value) {
    final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
    if (parsed == null || parsed.isNaN || parsed.isInfinite) return null;
    return parsed;
  }

  static String _format(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-10) return value.round().toString();
    final abs = value.abs();
    if (abs >= 10000 || abs < 0.001 && abs > 0) return value.toStringAsPrecision(5);
    return value.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
}

class _SettingsGlyph extends StatelessWidget {
  const _SettingsGlyph({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.66),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: active ? GraphStyle.accent.withValues(alpha: 0.48) : GraphStyle.graphiteLine),
        boxShadow: GraphStyle.controlShadow(active: active),
      ),
      child: const Icon(Icons.tune_rounded, color: GraphStyle.accent, size: 20),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: GraphStyle.text.withValues(alpha: 0.92),
        fontSize: 13,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.12,
      ),
    );
  }
}

class _ModeSegmentedControl extends StatelessWidget {
  const _ModeSegmentedControl({super.key, required this.mode, required this.onChanged});

  final GraphRenderMode mode;
  final ValueChanged<GraphRenderMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.64),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: GraphStyle.accent.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _ModeOption(
                label: '2D',
                icon: Icons.show_chart_rounded,
                active: mode == GraphRenderMode.twoD,
                onTap: () => onChanged(GraphRenderMode.twoD),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _ModeOption(
                label: '3D',
                icon: Icons.view_in_ar_rounded,
                active: mode == GraphRenderMode.threeD,
                onTap: () => onChanged(GraphRenderMode.threeD),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({required this.label, required this.icon, required this.active, required this.onTap});

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 170),
        height: 38,
        decoration: BoxDecoration(
          color: active ? GraphStyle.accent.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: active ? GraphStyle.accent.withValues(alpha: 0.44) : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, color: active ? GraphStyle.accent : GraphStyle.textSecondary, size: 17),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: active ? GraphStyle.text : GraphStyle.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _CurveColorPicker extends StatelessWidget {
  const _CurveColorPicker({super.key, required this.selectedKey, required this.onChanged});

  final String selectedKey;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = GraphFunctionColorPalette.byKey(selectedKey);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.62),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: selected.color.withValues(alpha: 0.30)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(9, 8, 9, 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 7,
              runSpacing: 6,
              children: GraphFunctionColorPalette.options
                  .map((option) => _CurveColorSwatch(
                        option: option,
                        selected: option.key == selected.key,
                        onTap: () => onChanged(option.key),
                      ))
                  .toList(growable: false),
            ),
            const SizedBox(height: 6),
            Text(
              selected.label,
              style: TextStyle(color: selected.color.withValues(alpha: 0.94), fontSize: 11.5, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _CurveColorSwatch extends StatelessWidget {
  const _CurveColorSwatch({required this.option, required this.selected, required this.onTap});

  final GraphFunctionColorOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: 'Graph function color ${option.label}',
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: 30,
          height: 30,
          padding: EdgeInsets.all(selected ? 2.5 : 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: option.color.withValues(alpha: selected ? 0.18 : 0.08),
            border: Border.all(color: selected ? option.color : GraphStyle.graphiteLine, width: selected ? 1.45 : 1.0),
            boxShadow: selected
                ? <BoxShadow>[
                    BoxShadow(color: option.color.withValues(alpha: 0.20), blurRadius: 12, spreadRadius: -5),
                  ]
                : null,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: option.color,
              border: Border.all(color: Colors.white.withValues(alpha: option.key == 'pearl' ? 0.22 : 0.08)),
            ),
          ),
        ),
      ),
    );
  }
}

class _TraceToggle extends StatelessWidget {
  const _TraceToggle({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.cardAlt.withValues(alpha: 0.62),
        gradient: GraphStyle.controlGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: value ? GraphStyle.accent.withValues(alpha: 0.36) : GraphStyle.graphiteLine),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: <Widget>[
            Expanded(
              child: _TraceOption(label: 'Off', active: !value, onTap: () => onChanged(false)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: _TraceOption(label: 'On', active: value, onTap: () => onChanged(true)),
            ),
          ],
        ),
      ),
    );
  }
}

class _TraceOption extends StatelessWidget {
  const _TraceOption({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 170),
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? GraphStyle.accent.withValues(alpha: 0.17) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: active ? GraphStyle.accent.withValues(alpha: 0.38) : Colors.transparent),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? GraphStyle.text : GraphStyle.textSecondary,
            fontSize: 12.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
      textInputAction: TextInputAction.next,
      style: const TextStyle(color: GraphStyle.text, fontSize: 14, fontWeight: FontWeight.w900),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: GraphStyle.axisLabel, fontWeight: FontWeight.w800),
        filled: true,
        fillColor: GraphStyle.canvas.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: GraphStyle.graphiteLine)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: GraphStyle.accent)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: GraphStyle.danger)),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: GraphStyle.danger.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: GraphStyle.danger.withValues(alpha: 0.30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.error_outline_rounded, color: GraphStyle.danger, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(color: GraphStyle.danger, fontSize: 12.5, fontWeight: FontWeight.w800))),
          ],
        ),
      ),
    );
  }
}

class _SheetIconButton extends StatelessWidget {
  const _SheetIconButton({super.key, required this.tooltip, required this.icon, required this.onPressed});

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: GraphStyle.textSecondary),
        style: IconButton.styleFrom(
          backgroundColor: GraphStyle.cardAlt.withValues(alpha: 0.62),
          side: const BorderSide(color: GraphStyle.graphiteLine),
          fixedSize: const Size(40, 40),
        ),
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({super.key, required this.label, required this.icon, required this.onPressed});

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: GraphStyle.accent,
        foregroundColor: GraphStyle.appBackground,
        elevation: 0,
        minimumSize: const Size.fromHeight(46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
    );
  }
}

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({super.key, required this.label, required this.icon, required this.onPressed});

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: GraphStyle.text,
        side: BorderSide(color: GraphStyle.tealBorder.withValues(alpha: 0.48)),
        minimumSize: const Size.fromHeight(46),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      icon: Icon(icon, color: GraphStyle.accent, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
    );
  }
}

class _ViewportDraft {
  const _ViewportDraft({required this.xMin, required this.xMax, required this.yMin, required this.yMax});

  final double xMin;
  final double xMax;
  final double yMin;
  final double yMax;
}
