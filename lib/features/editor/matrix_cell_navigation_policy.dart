import 'math_node.dart';
import 'slot_registry.dart';

/// Source-of-truth for matrix/vector cell addressing and navigation.
///
/// The editor must treat matrix/vector cells as real editable fields, not as
/// pieces of a bracket string.  This policy is intentionally small and pure so
/// tests can lock row-major behavior without depending on Flutter widgets.
class MatrixCellNavigationPolicy {
  const MatrixCellNavigationPolicy._();

  static const String version = 'mathpro-v172h-matrix-system-cursor-address-policy';



  static bool isMatrixCellEntry(SlotEntry entry) => entry.role == 'matrixCell';

  static bool isSystemEntry(SlotEntry entry) => entry.role == 'systemLeft' || entry.role == 'systemRight';

  static bool isStructuralGridEntry(SlotEntry entry) => isMatrixCellEntry(entry) || isSystemEntry(entry);

  static List<SlotEntry> orderedStructuralEntries(Iterable<SlotEntry> entries) {
    final cells = entries.where(isStructuralGridEntry).toList(growable: false);
    return cells..sort(compareStructuralEntries);
  }

  static int compareStructuralEntries(SlotEntry a, SlotEntry b) {
    final node = a.nodeId.compareTo(b.nodeId);
    if (node != 0) return node;
    final aAddress = StructuralGridAddress.fromSlotEntry(a);
    final bAddress = StructuralGridAddress.fromSlotEntry(b);
    final row = aAddress.row.compareTo(bAddress.row);
    if (row != 0) return row;
    final column = aAddress.column.compareTo(bAddress.column);
    if (column != 0) return column;
    return a.id.compareTo(b.id);
  }

  static List<String> orderedCellKeys(MathNode node) {
    if (node.kind == MathNodeKind.matrix) {
      final rows = (node.meta['rows'] as int?) ?? 0;
      final columns = (node.meta['columns'] as int?) ?? 0;
      return <String>[
        for (var row = 0; row < rows; row += 1)
          for (var column = 0; column < columns; column += 1) 'cell_${row}_$column',
      ].where(node.slots.containsKey).toList(growable: false);
    }
    if (node.kind == MathNodeKind.vector) {
      final dimension = (node.meta['dimension'] as int?) ?? 0;
      return <String>[
        for (var index = 0; index < dimension; index += 1) 'cell_$index',
      ].where(node.slots.containsKey).toList(growable: false);
    }
    return const <String>[];
  }

  static List<SlotEntry> orderedCellEntries(Iterable<SlotEntry> entries) {
    final cells = entries.where(isMatrixCellEntry).toList(growable: false);
    return cells..sort(compareCellEntries);
  }

  static int compareCellEntries(SlotEntry a, SlotEntry b) => compareStructuralEntries(a, b);

  static int cellLinearIndex(SlotEntry entry) {
    final matrix = RegExp(r'^cell_(\d+)_(\d+)$').firstMatch(entry.slotKey);
    if (matrix != null) {
      final row = int.parse(matrix.group(1)!);
      final column = int.parse(matrix.group(2)!);
      return row * 100 + column;
    }
    final vector = RegExp(r'^cell_(\d+)$').firstMatch(entry.slotKey);
    if (vector != null) return int.parse(vector.group(1)!);
    return 100000;
  }

  static SlotEntry? nextCell(List<SlotEntry> orderedCells, SlotEntry current) {
    if (orderedCells.isEmpty) return null;
    final index = orderedCells.indexWhere((entry) => entry.id == current.id);
    if (index < 0) return orderedCells.first;
    return orderedCells[(index + 1) % orderedCells.length];
  }

  static SlotEntry? previousCell(List<SlotEntry> orderedCells, SlotEntry current) {
    if (orderedCells.isEmpty) return null;
    final index = orderedCells.indexWhere((entry) => entry.id == current.id);
    if (index < 0) return orderedCells.last;
    return orderedCells[(index - 1 + orderedCells.length) % orderedCells.length];
  }
}

/// Canonical row/column address for matrix, vector and system-equation fields.
///
/// V172-H keeps advanced linear-algebra and system-equation editing anchored to
/// mathematical cell addresses instead of lexicographic ids or generic body
/// roles. This is intentionally pure and small so regression tests can lock the
/// cursor contract before the later renderer-synchronization phase.
class StructuralGridAddress {
  const StructuralGridAddress({
    required this.row,
    required this.column,
    required this.role,
    required this.slotKey,
  });

  final int row;
  final int column;
  final String role;
  final String slotKey;

  factory StructuralGridAddress.fromSlotEntry(SlotEntry entry) {
    final matrix = RegExp(r'^cell_(\d+)_(\d+)$').firstMatch(entry.slotKey);
    if (matrix != null) {
      return StructuralGridAddress(
        row: int.parse(matrix.group(1)!),
        column: int.parse(matrix.group(2)!),
        role: entry.role,
        slotKey: entry.slotKey,
      );
    }

    final vector = RegExp(r'^cell_(\d+)$').firstMatch(entry.slotKey);
    if (vector != null) {
      return StructuralGridAddress(
        row: int.parse(vector.group(1)!),
        column: 0,
        role: entry.role,
        slotKey: entry.slotKey,
      );
    }

    final left = RegExp(r'^left_(\d+)$').firstMatch(entry.slotKey);
    if (left != null) {
      return StructuralGridAddress(
        row: int.parse(left.group(1)!),
        column: 0,
        role: entry.role,
        slotKey: entry.slotKey,
      );
    }

    final right = RegExp(r'^right_(\d+)$').firstMatch(entry.slotKey);
    if (right != null) {
      return StructuralGridAddress(
        row: int.parse(right.group(1)!),
        column: 1,
        role: entry.role,
        slotKey: entry.slotKey,
      );
    }

    return StructuralGridAddress(row: 9999, column: 9999, role: entry.role, slotKey: entry.slotKey);
  }

  String get auditLabel => '$role[$row,$column]';
}

