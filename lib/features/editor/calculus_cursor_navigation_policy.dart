import 'slot_registry.dart';

/// Canonical cursor/navigation policy for calculus and differential-equation
/// editing surfaces.
///
/// V172-I keeps calculus cursor behavior explicit instead of letting integral,
/// limit, derivative, sum/product and ODE-adjacent slots fall back to generic
/// body/function ordering.  The policy is pure and small so regression tests can
/// lock the cursor contract before the later renderer-synchronized hit-test and
/// no-loupe premium tap precision phases.
class CalculusCursorNavigationPolicy {
  const CalculusCursorNavigationPolicy._();

  static const String version = 'mathpro-v172i-calculus-differential-cursor-policy-v1';

  static const Set<String> calculusRoles = <String>{
    'integralLowerLimit',
    'integralUpperLimit',
    'integralBody',
    'integralDifferential',
    'derivativeOrder',
    'derivativeVariable',
    'derivativeBody',
    'limitVariable',
    'limitTarget',
    'limitBody',
    'sumLowerLimit',
    'sumUpperLimit',
    'sumBody',
    'productLowerLimit',
    'productUpperLimit',
    'productBody',
    'seriesVariable',
    'seriesIndex',
    'seriesOrder',
    'seriesCenter',
    'seriesParameter',
    'seriesCoefficient',
    'seriesRatio',
    'seriesFactorial',
    'postfixTarget',
  };

  static const Set<String> differentialEquationRoles = <String>{
    'derivativeOrder',
    'derivativeVariable',
    'derivativeBody',
    'postfixTarget',
    'systemLeft',
    'systemRight',
  };

  static bool isCalculusEntry(SlotEntry entry) => calculusRoles.contains(entry.role);

  static bool isDifferentialEquationEntry(SlotEntry entry) => differentialEquationRoles.contains(entry.role);

  static bool isTinyCalculusSlot(String role) {
    return const <String>{
      'integralLowerLimit',
      'integralUpperLimit',
      'integralDifferential',
      'derivativeOrder',
      'derivativeVariable',
      'limitVariable',
      'limitTarget',
      'sumLowerLimit',
      'sumUpperLimit',
      'productLowerLimit',
      'productUpperLimit',
      'seriesIndex',
      'seriesOrder',
      'seriesCenter',
      'postfixTarget',
    }.contains(role);
  }

  static List<SlotEntry> orderedCalculusEntries(Iterable<SlotEntry> entries) {
    final slots = entries.where(isCalculusEntry).toList(growable: false);
    return slots..sort(compareCalculusEntries);
  }

  static int compareCalculusEntries(SlotEntry a, SlotEntry b) {
    final node = _numericSuffix(a.nodeId).compareTo(_numericSuffix(b.nodeId));
    if (node != 0) return node;
    final role = roleOrder(a.role).compareTo(roleOrder(b.role));
    if (role != 0) return role;
    final key = _slotKeyOrder(a.slotKey).compareTo(_slotKeyOrder(b.slotKey));
    if (key != 0) return key;
    return a.id.compareTo(b.id);
  }

  static int roleOrder(String role) {
    const order = <String, int>{
      'integralLowerLimit': 10,
      'integralUpperLimit': 11,
      'integralBody': 12,
      'integralDifferential': 13,
      'derivativeOrder': 20,
      'derivativeVariable': 21,
      'derivativeBody': 22,
      'limitVariable': 30,
      'limitTarget': 31,
      'limitBody': 32,
      'sumLowerLimit': 40,
      'sumUpperLimit': 41,
      'sumBody': 42,
      'productLowerLimit': 43,
      'productUpperLimit': 44,
      'productBody': 45,
      'seriesVariable': 50,
      'seriesIndex': 51,
      'seriesOrder': 52,
      'seriesCenter': 53,
      'seriesParameter': 54,
      'seriesCoefficient': 55,
      'seriesRatio': 56,
      'seriesFactorial': 57,
      'postfixTarget': 60,
      'systemLeft': 70,
      'systemRight': 71,
    };
    return order[role] ?? 1000;
  }

  static String auditLabelFor(SlotEntry entry) {
    return '${entry.role}:${entry.slotKey}@${entry.nodeId}';
  }

  static int _slotKeyOrder(String key) {
    const order = <String, int>{
      'lower': 10,
      'upper': 11,
      'body': 12,
      'differential': 13,
      'order': 20,
      'variable': 21,
      'target': 31,
    };
    if (order.containsKey(key)) return order[key]!;
    final indexed = RegExp(r'^(?:left|right|cell|arg)_(\d+)(?:_(\d+))?$').firstMatch(key);
    if (indexed != null) {
      final first = int.tryParse(indexed.group(1) ?? '') ?? 0;
      final second = int.tryParse(indexed.group(2) ?? '') ?? 0;
      return 100 + first * 10 + second;
    }
    return 1000;
  }

  static int _numericSuffix(String value) {
    final match = RegExp(r'(\d+)(?!.*\d)').firstMatch(value);
    return int.tryParse(match?.group(1) ?? '') ?? 0;
  }
}
