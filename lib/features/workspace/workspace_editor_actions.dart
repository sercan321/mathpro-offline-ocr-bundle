import 'package:flutter/services.dart';

/// Q382 immediate editor action identifiers for the workspace expression
/// context menu. They are deliberately separated from keyboard keys so the
/// keyboard layout/MORE/long-press inventories remain untouched.
enum WorkspaceEditorActionType { copy, paste, cut, selectAll, clear }

class WorkspaceEditorActionResult {
  const WorkspaceEditorActionResult({required this.success, required this.message, this.replacementExpression});

  final bool success;
  final String message;
  final String? replacementExpression;
}

class WorkspaceEditorActions {
  const WorkspaceEditorActions._();

  static bool canCopy(String expression) => expression.trim().isNotEmpty;
  static bool canCut(String expression) => expression.trim().isNotEmpty;
  static bool canSelectAll(String expression) => expression.trim().isNotEmpty;
  static bool canClear(String expression) => expression.trim().isNotEmpty;

  static Future<WorkspaceEditorActionResult> copyAll(String expression) async {
    final clean = expression.trim();
    if (clean.isEmpty) return const WorkspaceEditorActionResult(success: false, message: 'Kopyalanacak ifade yok.');
    await Clipboard.setData(ClipboardData(text: clean));
    return const WorkspaceEditorActionResult(success: true, message: 'İfade kopyalandı.');
  }

  static Future<WorkspaceEditorActionResult> cutAll(String expression) async {
    final clean = expression.trim();
    if (clean.isEmpty) return const WorkspaceEditorActionResult(success: false, message: 'Kesilecek ifade yok.');
    await Clipboard.setData(ClipboardData(text: clean));
    return const WorkspaceEditorActionResult(success: true, message: 'Tüm ifade kesildi.', replacementExpression: '');
  }

  static Future<WorkspaceEditorActionResult> pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = _sanitizeClipboardText(data?.text ?? '');
    if (text.isEmpty) return const WorkspaceEditorActionResult(success: false, message: 'Pano boş.');
    return WorkspaceEditorActionResult(success: true, message: 'Tüm ifade panodaki metinle değiştirildi.', replacementExpression: text);
  }

  static WorkspaceEditorActionResult selectAllContext(String expression) {
    if (expression.trim().isEmpty) {
      return const WorkspaceEditorActionResult(success: false, message: 'Seçilecek ifade yok.');
    }
    return const WorkspaceEditorActionResult(success: true, message: 'Tüm ifade hedeflendi.');
  }

  static WorkspaceEditorActionResult clearAll(String expression) {
    if (expression.trim().isEmpty) return const WorkspaceEditorActionResult(success: false, message: 'Temizlenecek ifade yok.');
    return const WorkspaceEditorActionResult(success: true, message: 'İfade temizlendi.', replacementExpression: '');
  }

  static String _sanitizeClipboardText(String value) {
    final compact = value
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAll(RegExp(r'[\u0000-\u0008\u000B\u000C\u000E-\u001F]'), '')
        .trim();
    if (compact.length <= 2048) return compact;
    return compact.substring(0, 2048).trim();
  }
}
