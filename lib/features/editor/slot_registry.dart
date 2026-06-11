import 'package:flutter/foundation.dart';

import 'math_node.dart';

const double touchTargetMin = 44;

@immutable
class NormalizedSlotBounds {
  const NormalizedSlotBounds({required this.left, required this.top, required this.width, required this.height});

  final double left;
  final double top;
  final double width;
  final double height;
}

@immutable
class SlotEntry {
  const SlotEntry({
    required this.id,
    required this.nodeId,
    required this.nodeKind,
    required this.slotKey,
    required this.role,
    required this.priority,
    required this.minTouchSize,
    required this.normalizedBounds,
    this.depth = 0,
  });

  final String id;
  final String nodeId;
  final MathNodeKind nodeKind;
  final String slotKey;
  final String role;
  final int priority;
  final double minTouchSize;
  final NormalizedSlotBounds normalizedBounds;
  final int depth;

  String get kind => role;
}

@immutable
class SlotRegistry {
  const SlotRegistry({required this.version, required this.entries});

  final String version;
  final List<SlotEntry> entries;

  bool get hasSlots => entries.isNotEmpty;

  SlotEntry? byId(String? id) {
    if (id == null) return null;
    for (final entry in entries) {
      if (entry.id == id) return entry;
    }
    return null;
  }

  SlotEntry? get primary => entries.isEmpty ? null : entries.first;

  static SlotRegistry fromRoot(MathNode root) => build(root);

  /// Compatibility constructor used by the Q38+ cursor regression tests and
  /// multi-root editor snapshots. It preserves the same slot sorting contract
  /// as [build] while allowing tests to assemble a registry from one or more
  /// independent structural roots without touching keyboard or visual surfaces.
  static SlotRegistry fromRoots(List<MathNode> roots) {
    final entries = <SlotEntry>[];
    for (final root in roots) {
      _visit(root, entries, depth: 0);
    }
    _sortEntries(entries);
    return SlotRegistry(version: 'mathpro-core-editor-v172h-matrix-system-slot-registry-v1', entries: entries);
  }

  static SlotRegistry build(MathNode root) {
    final entries = <SlotEntry>[];
    _visit(root, entries, depth: 0);
    _sortEntries(entries);
    return SlotRegistry(version: 'mathpro-core-editor-v172h-matrix-system-slot-registry-v1', entries: entries);
  }

  static void _sortEntries(List<SlotEntry> entries) {
    entries.sort((a, b) {
      final priority = b.priority.compareTo(a.priority);
      if (priority != 0) return priority;
      final depth = b.depth.compareTo(a.depth);
      if (depth != 0) return depth;
      final roleOrder = _roleOrderForStableSort(a.role).compareTo(_roleOrderForStableSort(b.role));
      if (roleOrder != 0) return roleOrder;
      return a.id.compareTo(b.id);
    });
  }

  static int _roleOrderForStableSort(String role) {
    const order = <String, int>{
      'fractionNumerator': 10,
      'fractionDenominator': 11,
      'rootIndex': 20,
      'sqrtValue': 21,
      'powerExponent': 30,
      'powerBase': 31,
      'subscript': 32,
      'subscriptBase': 33,
      'logBase': 34,
      'integralUpperLimit': 40,
      'integralLowerLimit': 41,
      'integralBody': 42,
      'integralDifferential': 43,
      'sumUpperLimit': 50,
      'sumLowerLimit': 51,
      'sumBody': 52,
      'productUpperLimit': 53,
      'productLowerLimit': 54,
      'productBody': 55,
      'seriesVariable': 56,
      'seriesIndex': 57,
      'seriesOrder': 58,
      'seriesCenter': 59,
      'seriesParameter': 60,
      'seriesCoefficient': 61,
      'seriesRatio': 62,
      'seriesFactorial': 63,
      'limitVariable': 64,
      'limitTarget': 65,
      'limitBody': 66,
      'functionArgument': 70,
      'functionArgument2': 71,
      'functionArgument3': 72,
      'postfixTarget': 76,
      'derivativeBody': 77,
      'derivativeVariable': 78,
      'matrixCell': 80,
      'systemLeft': 82,
      'systemRight': 83,
      'piecewiseExpression': 84,
      'piecewiseCondition': 85,
      'placeholder': 90,
    };
    return order[role] ?? 1000;
  }

  static void _visit(MathNode node, List<SlotEntry> entries, {required int depth}) {
    entries.addAll(_nodeSlots(node, depth));
    for (final child in node.children) {
      _visit(child, entries, depth: depth + 1);
    }

    // Structural nodes already expose their slot hit targets from the parent
    // node. Walking placeholder slot children again creates duplicate overlay
    // boxes for the same visible target. Non-placeholder slot children are still
    // visited so future nested structural slots remain addressable.
    for (final slotNode in node.slots.values) {
      if (slotNode.kind == MathNodeKind.placeholder) continue;
      _visit(slotNode, entries, depth: depth + 1);
    }
  }

  static List<SlotEntry> _nodeSlots(MathNode node, int depth) {
    switch (node.kind) {
      case MathNodeKind.fraction:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'numerator')) _entry(node, 'numerator', 'fractionNumerator', 112, 88, const NormalizedSlotBounds(left: 0.00, top: 0.00, width: 1.00, height: 0.46), depth),
          if (_isAddressableSlot(node, 'denominator')) _entry(node, 'denominator', 'fractionDenominator', 112, 88, const NormalizedSlotBounds(left: 0.00, top: 0.54, width: 1.00, height: 0.46), depth),
        ];
      case MathNodeKind.sqrt:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'value')) _entry(node, 'value', 'sqrtValue', 112, 88, const NormalizedSlotBounds(left: 0.20, top: 0.04, width: 0.80, height: 0.90), depth),
        ];
      case MathNodeKind.indexedRoot:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'index')) _entry(node, 'index', 'rootIndex', 136, 84, const NormalizedSlotBounds(left: 0.00, top: 0.00, width: 0.30, height: 0.40), depth),
          if (_isAddressableSlot(node, 'value')) _entry(node, 'value', 'sqrtValue', 112, 88, const NormalizedSlotBounds(left: 0.22, top: 0.08, width: 0.78, height: 0.84), depth),
        ];
      case MathNodeKind.power:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'base')) _entry(node, 'base', 'powerBase', 78, 68, const NormalizedSlotBounds(left: 0.00, top: 0.30, width: 0.62, height: 0.70), depth),
          if (_isAddressableSlot(node, 'exponent')) _entry(node, 'exponent', 'powerExponent', 116, 76, const NormalizedSlotBounds(left: 0.58, top: 0.00, width: 0.42, height: 0.52), depth),
        ];
      case MathNodeKind.subscript:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'base')) _entry(node, 'base', 'subscriptBase', 74, 64, const NormalizedSlotBounds(left: 0.00, top: 0.08, width: 0.58, height: 0.72), depth),
          if (_isAddressableSlot(node, 'subscript')) _entry(node, 'subscript', 'subscript', 128, 76, const NormalizedSlotBounds(left: 0.52, top: 0.52, width: 0.48, height: 0.44), depth),
        ];
      case MathNodeKind.logBase:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'base')) _entry(node, 'base', 'logBase', 138, 84, const NormalizedSlotBounds(left: 0.22, top: 0.48, width: 0.30, height: 0.48), depth),
          if (_isAddressableSlot(node, 'arg')) _entry(node, 'arg', 'functionArgument', 126, 96, const NormalizedSlotBounds(left: 0.46, top: 0.02, width: 0.54, height: 0.96), depth),
        ];
      case MathNodeKind.integral:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'upper')) _entry(node, 'upper', 'integralUpperLimit', 120, 88, const NormalizedSlotBounds(left: 0.00, top: 0.00, width: 0.42, height: 0.36), depth),
          if (_isAddressableSlot(node, 'lower')) _entry(node, 'lower', 'integralLowerLimit', 120, 88, const NormalizedSlotBounds(left: 0.00, top: 0.64, width: 0.42, height: 0.36), depth),
          if (_isAddressableSlot(node, 'body')) _entry(node, 'body', 'integralBody', 84, 82, const NormalizedSlotBounds(left: 0.34, top: 0.20, width: 0.48, height: 0.62), depth),
          if (_isAddressableSlot(node, 'differential')) _entry(node, 'differential', 'integralDifferential', 58, 72, const NormalizedSlotBounds(left: 0.78, top: 0.28, width: 0.22, height: 0.44), depth),
        ];
      case MathNodeKind.derivative:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'body')) _entry(node, 'body', 'derivativeBody', 124, 96, const NormalizedSlotBounds(left: 0.38, top: 0.12, width: 0.62, height: 0.76), depth),
          if (_isAddressableSlot(node, 'variable')) _entry(node, 'variable', 'derivativeVariable', 90, 72, const NormalizedSlotBounds(left: 0.12, top: 0.58, width: 0.34, height: 0.36), depth),
        ];
      case MathNodeKind.bigOperator:
        return <SlotEntry>[
          _entry(node, 'upper', node.operator == 'Π' ? 'productUpperLimit' : 'sumUpperLimit', 118, 82, const NormalizedSlotBounds(left: 0.00, top: 0.00, width: 0.54, height: 0.36), depth),
          _entry(node, 'lower', node.operator == 'Π' ? 'productLowerLimit' : 'sumLowerLimit', 118, 82, const NormalizedSlotBounds(left: 0.00, top: 0.64, width: 0.56, height: 0.36), depth),
          _entry(node, 'body', node.operator == 'Π' ? 'productBody' : 'sumBody', 86, 78, const NormalizedSlotBounds(left: 0.38, top: 0.22, width: 0.62, height: 0.58), depth),
        ];
      case MathNodeKind.limit:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'variable')) _entry(node, 'variable', 'limitVariable', 70, 44, const NormalizedSlotBounds(left: 0.00, top: 0.50, width: 0.36, height: 0.42), depth),
          if (_isAddressableSlot(node, 'target')) _entry(node, 'target', 'limitTarget', 70, 44, const NormalizedSlotBounds(left: 0.34, top: 0.50, width: 0.30, height: 0.42), depth),
          if (_isAddressableSlot(node, 'body')) _entry(node, 'body', 'limitBody', 80, 48, const NormalizedSlotBounds(left: 0.54, top: 0.18, width: 0.46, height: 0.64), depth),
        ];
      case MathNodeKind.functionCall:
        final output = <SlotEntry>[];
        if (_isAddressableSlot(node, 'arg')) {
          output.add(_entry(node, 'arg', 'functionArgument', 145, 96, const NormalizedSlotBounds(left: 0.16, top: 0.00, width: 0.84, height: 1.00), depth));
        }
        final argKeys = node.slots.keys.where((key) => RegExp(r'^arg_\d+$').hasMatch(key)).toList()..sort();
        for (var index = 0; index < argKeys.length; index += 1) {
          final key = argKeys[index];
          if (!_isAddressableSlot(node, key)) continue;
          output.add(_entry(
            node,
            key,
            index == 0 ? 'functionArgument' : 'functionArgument${index + 1}',
            145 - index,
            92,
            NormalizedSlotBounds(left: 0.16 + index * 0.20, top: 0.00, width: 0.40, height: 1.00),
            depth,
          ));
        }
        return output;
      case MathNodeKind.postfix:
        return <SlotEntry>[
          if (_isAddressableSlot(node, 'target')) _entry(node, 'target', 'postfixTarget', 132, 84, const NormalizedSlotBounds(left: 0.00, top: 0.08, width: 0.76, height: 0.84), depth),
        ];
      case MathNodeKind.matrix:
        final output = <SlotEntry>[];
        final rows = (node.meta['rows'] as int?) ?? 2;
        final columns = (node.meta['columns'] as int?) ?? 2;
        for (var row = 0; row < rows; row += 1) {
          for (var column = 0; column < columns; column += 1) {
            if (!_isAddressableSlot(node, 'cell_${row}_$column')) continue;
            output.add(_entry(
              node,
              'cell_${row}_$column',
              'matrixCell',
              72,
              64,
              NormalizedSlotBounds(
                left: column / columns,
                top: row / rows,
                width: 1 / columns,
                height: 1 / rows,
              ),
              depth,
            ));
          }
        }
        return output;
      case MathNodeKind.vector:
        final output = <SlotEntry>[];
        final dimension = (node.meta['dimension'] as int?) ?? 2;
        final column = (node.meta['column'] as bool?) ?? true;
        for (var index = 0; index < dimension; index += 1) {
          if (!_isAddressableSlot(node, 'cell_$index')) continue;
          output.add(_entry(
            node,
            'cell_$index',
            'matrixCell',
            72,
            64,
            column
                ? NormalizedSlotBounds(left: 0, top: index / dimension, width: 1, height: 1 / dimension)
                : NormalizedSlotBounds(left: index / dimension, top: 0, width: 1 / dimension, height: 1),
            depth,
          ));
        }
        return output;
      case MathNodeKind.piecewise:
        return _piecewiseSlotEntries(node, depth);
      case MathNodeKind.series:
        return _seriesSlotEntries(node, depth);
      case MathNodeKind.placeholder:
        return <SlotEntry>[
          SlotEntry(
            id: node.id,
            nodeId: node.id,
            nodeKind: node.kind,
            slotKey: 'value',
            role: (node.meta['role'] as String?) ?? 'placeholder',
            priority: 66,
            minTouchSize: 56,
            normalizedBounds: const NormalizedSlotBounds(left: 0, top: 0, width: 1, height: 1),
            depth: depth,
          ),
        ];
      default:
        return const <SlotEntry>[];
    }
  }


  static List<SlotEntry> _piecewiseSlotEntries(MathNode node, int depth) {
    final output = <SlotEntry>[];
    final rows = (node.meta['rows'] as int?) ?? 2;
    final safeRows = rows.clamp(1, 6).toInt();
    for (var row = 0; row < safeRows; row += 1) {
      final top = row / safeRows;
      final height = 1 / safeRows;
      final leftKey = 'left_$row';
      final rightKey = 'right_$row';
      if (_isAddressableSlot(node, leftKey)) {
        output.add(_entry(
          node,
          leftKey,
          'systemLeft',
          124 - row * 2,
          72,
          NormalizedSlotBounds(left: 0.04, top: top, width: 0.42, height: height),
          depth,
        ));
      }
      if (_isAddressableSlot(node, rightKey)) {
        output.add(_entry(
          node,
          rightKey,
          'systemRight',
          123 - row * 2,
          72,
          NormalizedSlotBounds(left: 0.56, top: top, width: 0.40, height: height),
          depth,
        ));
      }
    }
    return output;
  }

  static List<SlotEntry> _seriesSlotEntries(MathNode node, int depth) {
    final ordered = <String>[
      'variable',
      'index',
      'order',
      'center',
      'parameter',
      'coefficient',
      'ratio',
      'factorial',
      'base',
      'shift',
      'exponent',
      'chooseTop',
      'chooseBottom',
      'signIndex',
      'denominator',
      'numerator',
      'denominatorRatio',
    ];
    final output = <SlotEntry>[];
    var visibleIndex = 0;
    final total = ordered.where((key) => _isAddressableSlot(node, key)).length.clamp(1, ordered.length).toInt();
    for (final key in ordered) {
      if (!_isAddressableSlot(node, key)) continue;
      final role = (node.slots[key]!.meta['role'] as String?) ?? _seriesRoleForKey(key);
      output.add(_entry(
        node,
        key,
        role,
        _seriesPriority(role) * 100 - visibleIndex,
        68,
        NormalizedSlotBounds(
          left: (visibleIndex / total).clamp(0.0, 0.92).toDouble(),
          top: 0.18,
          width: (1 / total).clamp(0.08, 0.22).toDouble(),
          height: 0.64,
        ),
        depth,
      ));
      visibleIndex += 1;
    }
    return output;
  }

  static String _seriesRoleForKey(String key) {
    switch (key) {
      case 'index':
      case 'signIndex':
        return 'seriesIndex';
      case 'order':
      case 'exponent':
        return 'seriesOrder';
      case 'center':
      case 'shift':
        return 'seriesCenter';
      case 'parameter':
      case 'chooseTop':
        return 'seriesParameter';
      case 'coefficient':
      case 'numerator':
        return 'seriesCoefficient';
      case 'ratio':
      case 'denominatorRatio':
        return 'seriesRatio';
      case 'factorial':
      case 'denominator':
        return 'seriesFactorial';
      default:
        return 'seriesVariable';
    }
  }

  static int _seriesPriority(String role) {
    switch (role) {
      case 'seriesVariable':
        return 122;
      case 'seriesIndex':
        return 121;
      case 'seriesOrder':
        return 120;
      case 'seriesCenter':
        return 119;
      default:
        return 112;
    }
  }

  static bool _isAddressableSlot(MathNode node, String slotKey) {
    final slot = node.slots[slotKey];
    if (slot == null) return false;
    if (_containsOpenPlaceholder(slot)) return true;
    return _isFilledEditableSlot(node, slotKey, slot);
  }

  /// Real-device Phase 18: filled structural regions must remain editable.
  /// Earlier phases only exposed open □ placeholders; as soon as a user filled
  /// `3⁄4`, `log(2)(5)` or `lim_y → 8(8)`, the numerator/denominator/base/body
  /// stopped being addressable. This keeps the *visual* slot selectable without
  /// turning ordinary text into a giant selection target.
  static bool _isFilledEditableSlot(MathNode owner, String slotKey, MathNode slot) {
    // Fixed notation atoms such as x₁, y₂, Aᵀ and i² are display atoms, not
    // editable templates. Editable lower-index input remains available through
    // explicit templates such as x_□; fixed atoms must not expose false slots.
    if (owner.meta['fixedAtom'] == true) return false;
    if (_plainText(slot).trim().isEmpty) return false;
    switch (owner.kind) {
      case MathNodeKind.fraction:
        // Keep partially-filled templates source-aligned for the legacy tests:
        // `x⁄□` exposes only the denominator. Fully filled real-device
        // fractions such as `3⁄4` remain editable on both sides.
        return _allSlotsFilled(owner, const <String>['numerator', 'denominator']) &&
            (slotKey == 'numerator' || slotKey == 'denominator');
      case MathNodeKind.sqrt:
        return slotKey == 'value';
      case MathNodeKind.indexedRoot:
        // V172-P4 real-log repair: keep legacy source-alignment for the compact
        // fixed symbolic form `ⁿ√(□)`. The superscript n is a display index in
        // that template, while the visible radicand placeholder remains the only
        // editable target. Once the radicand is filled (`ⁿ√(x)`) or the index
        // itself is an editable placeholder (`□√(x)`), both regions are valid
        // cursor anchors again.
        if (slotKey == 'index') {
          final value = owner.slots['value'];
          if (value != null && _containsOpenPlaceholder(value) && !_containsOpenPlaceholder(slot)) {
            return false;
          }
        }
        return slotKey == 'index' || slotKey == 'value';
      case MathNodeKind.logBase:
        // V172-E: keep base and argument addressable independently. The base
        // in `log₂(□)` and the argument in `log₍□₎(5)` must not go dead just
        // because its sibling is still open.
        return slotKey == 'base' || slotKey == 'arg';
      case MathNodeKind.limit:
        // Filled limit slots must remain selectable for role-aware clearing even
        // while sibling slots are still open. Example: after replacing the
        // target in `limₓ→□(□)` with `6`, the active target must still expose
        // `limitTarget` so clearSelectedSlot can restore the visible □.
        return slotKey == 'variable' || slotKey == 'target' || slotKey == 'body';
      case MathNodeKind.integral:
        // Keep a *filled body* selectable only for the still-editable template
        // variant where at least one visual limit remains open. This preserves
        // role-aware clearing for `∫_{□}^{□}(x)d□`, while avoiding duplicate
        // body+differential entries for `∫_{0}^{1}(x)d□` and avoiding false
        // hit targets for fully fixed integrals such as `∫₀¹(x)dx`.
        if (slotKey != 'body') return false;
        final lower = owner.slots['lower'];
        final upper = owner.slots['upper'];
        return (lower != null && _containsOpenPlaceholder(lower)) ||
            (upper != null && _containsOpenPlaceholder(upper));
      case MathNodeKind.power:
        // V116 real-log repair: the V103 structural migration contract expects
        // canonical filled powers such as `x^(2)` to remain addressable as a
        // true power family. This is different from indexed roots/integrals,
        // where fixed notational limits must not create false editable targets.
        return _allSlotsFilled(owner, const <String>['base', 'exponent']) &&
            (slotKey == 'base' || slotKey == 'exponent');
      case MathNodeKind.subscript:
        // V172-P4 real-log repair: explicit editable templates such as `x_□`
        // must expose both the base and lower-index lanes. Fixed display atoms
        // such as `x₈` remain blocked by the owner.fixedAtom guard above.
        final sub = owner.slots['subscript'];
        if (slotKey == 'base' && sub != null && _containsOpenPlaceholder(sub)) {
          return _plainText(slot).trim().isNotEmpty;
        }
        // V172-D: filled subscripts are real editable slots. This keeps x_8 and
        // x_(89) tappable without changing any keyboard/long-press mapping.
        return _allSlotsFilled(owner, const <String>['base', 'subscript']) &&
            (slotKey == 'base' || slotKey == 'subscript');
      case MathNodeKind.bigOperator:
        return _allSlotsFilled(owner, const <String>['upper', 'lower', 'body']) &&
            (slotKey == 'upper' || slotKey == 'lower' || slotKey == 'body');
      case MathNodeKind.functionCall:
        return slotKey == 'arg' || RegExp(r'^arg_\d+$').hasMatch(slotKey);
      case MathNodeKind.postfix:
        return slotKey == 'target';
      case MathNodeKind.series:
        return owner.slots.containsKey(slotKey);
      case MathNodeKind.matrix:
      case MathNodeKind.vector:
        return slotKey.startsWith('cell_');
      case MathNodeKind.piecewise:
        return slotKey.startsWith('left_') || slotKey.startsWith('right_');
      default:
        // Integrals keep the older open-slot registry contract unless a
        // visible □ or explicit editable body path exists. Indexed roots are
        // handled above by V172-E because root index/radicand taps are part
        // of the premium cursor contract.
        return false;
    }
  }

  static bool _allSlotsFilled(MathNode owner, List<String> keys) {
    for (final key in keys) {
      final slot = owner.slots[key];
      if (slot == null || _containsOpenPlaceholder(slot) || _plainText(slot).trim().isEmpty) return false;
    }
    return true;
  }

  static String _plainText(MathNode node) {
    switch (node.kind) {
      case MathNodeKind.text:
      case MathNodeKind.number:
      case MathNodeKind.symbol:
      case MathNodeKind.constant:
      case MathNodeKind.operatorToken:
      case MathNodeKind.delimiter:
        return node.text ?? '';
      case MathNodeKind.placeholder:
        return '';
      case MathNodeKind.box:
      case MathNodeKind.row:
        return node.children.map(_plainText).join();
      default:
        final childText = node.children.map(_plainText).join();
        final slotText = node.slots.values.map(_plainText).join();
        return '$childText$slotText';
    }
  }

  static bool _containsOpenPlaceholder(MathNode node) {
    if (node.kind == MathNodeKind.placeholder) return true;
    if (node.kind == MathNodeKind.box && node.children.isEmpty) return true;
    for (final child in node.children) {
      if (_containsOpenPlaceholder(child)) return true;
    }
    for (final slot in node.slots.values) {
      if (_containsOpenPlaceholder(slot)) return true;
    }
    return false;
  }

  static SlotEntry _entry(MathNode node, String slotKey, String role, int priority, double minTouchSize, NormalizedSlotBounds bounds, int depth) {
    return SlotEntry(
      id: '${node.id}.$slotKey',
      nodeId: node.id,
      nodeKind: node.kind,
      slotKey: slotKey,
      role: role,
      priority: priority,
      minTouchSize: minTouchSize,
      normalizedBounds: bounds,
      depth: depth,
    );
  }
}
