import 'package:flutter/foundation.dart';

import 'graph_models.dart';

class GraphController extends ChangeNotifier {
  GraphExpression? _activeExpression;
  bool _previewVisible = false;

  GraphExpression? get activeExpression => _activeExpression;
  bool get previewVisible => _previewVisible && _activeExpression != null;

  void openPreview(GraphExpression expression) {
    _activeExpression = expression;
    _previewVisible = true;
    notifyListeners();
  }

  void closePreview() {
    _previewVisible = false;
    notifyListeners();
  }
}
