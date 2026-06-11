import 'math_node.dart';

class NodeFactory {
  const NodeFactory._();

  static MathNode rootFromExpression(String expression) {
    MathNodeIds.reset();
    final source = expression.trim();
    return box(children: source.isEmpty ? const <MathNode>[] : _parseLinearExpression(source));
  }

  static MathNode text(String text) {
    return MathNode(id: MathNodeIds.create('text'), kind: MathNodeKind.text, text: text);
  }

  static MathNode atom(String value) {
    final match = _matchPrimitiveAstToken(value);
    if (match != null && match.length == value.length) return match.node;
    return text(value);
  }

  /// Primitive keyboard input still arrives through frozen key text actions,
  /// but once parsed it must not remain a plain string-render fallback. V157
  /// promoted number literals, symbols and constants. V158 promotes operators
  /// and delimiters to explicit render nodes without changing keyboard layout.
  static MathNode token(String text, String tokenType, {Map<String, Object?> meta = const <String, Object?>{}}) {
    return _primitiveNode(text, tokenType, meta: meta);
  }

  static MathNode number(String value, {Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('number'),
      kind: MathNodeKind.number,
      text: value,
      meta: <String, Object?>{
        'tokenType': 'numberLiteral',
        'structuralToken': true,
        'renderNode': 'NumberNode',
        ...meta,
      },
    );
  }

  static MathNode symbol(String value, {Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('symbol'),
      kind: MathNodeKind.symbol,
      text: value,
      meta: <String, Object?>{
        'tokenType': 'symbol',
        'structuralToken': true,
        'renderNode': 'SymbolNode',
        ...meta,
      },
    );
  }

  static MathNode constant(String value, {String? constantName, Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('constant'),
      kind: MathNodeKind.constant,
      text: value,
      meta: <String, Object?>{
        'tokenType': 'constant',
        'structuralToken': true,
        'renderNode': 'ConstantNode',
        if (constantName != null) 'constantName': constantName,
        ...meta,
      },
    );
  }

  static MathNode operatorToken(String value, {Map<String, Object?> meta = const <String, Object?>{}}) {
    final delimiter = _delimiterTokens.contains(value);
    return MathNode(
      id: MathNodeIds.create(delimiter ? 'delimiter' : 'operator_token'),
      kind: delimiter ? MathNodeKind.delimiter : MathNodeKind.operatorToken,
      text: value,
      meta: <String, Object?>{
        'tokenType': delimiter ? 'delimiter' : 'operator',
        'structuralToken': true,
        'renderNode': delimiter ? 'DelimiterNode' : 'OperatorNode',
        ...meta,
      },
    );
  }

  static MathNode _primitiveNode(String text, String tokenType, {Map<String, Object?> meta = const <String, Object?>{}}) {
    if (tokenType == 'numberLiteral' || tokenType == 'number') {
      return number(text, meta: meta);
    }
    if (tokenType == 'symbol') {
      return _isConstantToken(text) ? constant(text, constantName: _constantNameFor(text), meta: meta) : symbol(text, meta: meta);
    }
    if (tokenType == 'signedInfinity') {
      return constant(text, constantName: 'signedInfinity', meta: <String, Object?>{'tokenType': tokenType, ...meta});
    }
    if (tokenType == 'signedComplex') {
      return constant(text, constantName: 'signedComplex', meta: <String, Object?>{'tokenType': tokenType, ...meta});
    }
    if (tokenType == 'differential') {
      return symbol(text, meta: <String, Object?>{'tokenType': tokenType, 'symbolRole': 'differential', ...meta});
    }
    if (tokenType == 'operator' || tokenType == 'delimiter') {
      return operatorToken(text, meta: meta);
    }
    return MathNode(
      id: MathNodeIds.create('token'),
      kind: MathNodeKind.text,
      text: text,
      meta: <String, Object?>{
        'tokenType': tokenType,
        'structuralToken': true,
        ...meta,
      },
    );
  }

  static bool _isConstantToken(String text) => const <String>{'π', 'e', 'i', 'θ', 'λ', 'μ', 'φ', 'ρ', '∞', 'rad', 'deg'}.contains(text);

  static String _constantNameFor(String text) {
    switch (text) {
      case 'π':
        return 'pi';
      case 'e':
        return 'e';
      case 'i':
        return 'imaginaryUnit';
      case '∞':
        return 'infinity';
      case 'rad':
      case 'deg':
        return 'angleUnit';
      default:
        return text;
    }
  }

  static MathNode box({List<MathNode> children = const <MathNode>[], String? id}) {
    return MathNode(id: id ?? MathNodeIds.create('box'), kind: MathNodeKind.box, children: children);
  }

  static MathNode placeholder({String role = 'body', String? linkGroup, Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('slot'),
      kind: MathNodeKind.placeholder,
      meta: <String, Object?>{
        'role': role,
        if (linkGroup != null) 'linkGroup': linkGroup,
        ...meta,
      },
    );
  }

  static MathNode matrixCellPlaceholder(int row, int column) {
    return placeholder(
      role: 'matrixCell',
      linkGroup: 'matrix_${row}_$column',
      meta: <String, Object?>{
        'row': row,
        'column': column,
        'cellKey': 'cell_${row}_$column',
      },
    );
  }

  static MathNode vectorCellPlaceholder(int index, {required bool column}) {
    return placeholder(
      role: 'matrixCell',
      linkGroup: 'vector_$index',
      meta: <String, Object?>{
        'index': index,
        'columnVector': column,
        'cellKey': 'cell_$index',
      },
    );
  }

  static MathNode fraction({MathNode? numerator, MathNode? denominator}) {
    return MathNode(
      id: MathNodeIds.create('fraction'),
      kind: MathNodeKind.fraction,
      slots: <String, MathNode>{
        'numerator': numerator ?? placeholder(role: 'fractionNumerator'),
        'denominator': denominator ?? placeholder(role: 'fractionDenominator'),
      },
    );
  }

  static MathNode sqrt({bool indexed = false, MathNode? index, MathNode? value}) {
    return MathNode(
      id: MathNodeIds.create(indexed ? 'indexed_root' : 'sqrt'),
      kind: indexed ? MathNodeKind.indexedRoot : MathNodeKind.sqrt,
      slots: indexed
          ? <String, MathNode>{
              'index': index ?? placeholder(role: 'rootIndex'),
              'value': value ?? placeholder(role: 'sqrtValue'),
            }
          : <String, MathNode>{'value': value ?? placeholder(role: 'sqrtValue')},
    );
  }

  static MathNode power({String baseText = '', MathNode? base, MathNode? exponent, Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('power'),
      kind: MathNodeKind.power,
      meta: meta,
      slots: <String, MathNode>{
        'base': base ?? (baseText.isEmpty ? placeholder(role: 'powerBase') : box(children: <MathNode>[atom(baseText)])),
        'exponent': exponent ?? placeholder(role: 'powerExponent'),
      },
    );
  }

  static MathNode subscript({String baseText = '', MathNode? base, MathNode? subscript, Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('subscript'),
      kind: MathNodeKind.subscript,
      meta: meta,
      slots: <String, MathNode>{
        'base': base ?? (baseText.isEmpty ? placeholder(role: 'subscriptBase') : box(children: <MathNode>[atom(baseText)])),
        'subscript': subscript ?? placeholder(role: 'subscript'),
      },
    );
  }

  static MathNode postfix({required String operator, MathNode? target, Map<String, Object?> meta = const <String, Object?>{}}) {
    return MathNode(
      id: MathNodeIds.create('postfix'),
      kind: MathNodeKind.postfix,
      operator: operator,
      meta: meta,
      slots: <String, MathNode>{
        'target': target ?? placeholder(role: 'postfixTarget'),
      },
    );
  }

  static MathNode logBase({MathNode? base, MathNode? argument}) {
    return MathNode(
      id: MathNodeIds.create('log_base'),
      kind: MathNodeKind.logBase,
      operator: 'log',
      slots: <String, MathNode>{
        'base': base ?? placeholder(role: 'logBase'),
        'arg': argument ?? placeholder(role: 'functionArgument'),
      },
    );
  }

  static MathNode integral({
    bool definite = false,
    MathNode? lower,
    MathNode? upper,
    MathNode? body,
    MathNode? differential,
  }) {
    return MathNode(
      id: MathNodeIds.create('integral'),
      kind: MathNodeKind.integral,
      slots: <String, MathNode>{
        if (definite) 'lower': lower ?? placeholder(role: 'integralLowerLimit'),
        if (definite) 'upper': upper ?? placeholder(role: 'integralUpperLimit'),
        'body': body ?? placeholder(role: 'integralBody'),
        'differential': differential ?? box(children: <MathNode>[atom('dx')]),
      },
    );
  }


  static MathNode derivative({
    required String notation,
    int order = 1,
    bool partial = false,
    MathNode? body,
    MathNode? variable,
    MathNode? dependent,
  }) {
    final slots = <String, MathNode>{
      'body': body ?? placeholder(role: 'derivativeBody'),
      'variable': variable ?? box(children: <MathNode>[atom('x')]),
    };
    if (dependent != null) slots['dependent'] = dependent;
    return MathNode(
      id: MathNodeIds.create('derivative'),
      kind: MathNodeKind.derivative,
      operator: notation,
      slots: slots,
      meta: <String, Object?>{
        'order': order,
        'partial': partial,
        'notation': notation,
      },
    );
  }

  static MathNode fixedLimitIntegral({
    required String lowerText,
    required String upperText,
  }) {
    return integral(
      definite: true,
      lower: box(children: <MathNode>[text(lowerText)]),
      upper: box(children: <MathNode>[text(upperText)]),
    );
  }

  static MathNode editableLimitIntegral() {
    return integral(
      definite: true,
      lower: placeholder(role: 'integralLowerLimit'),
      upper: placeholder(role: 'integralUpperLimit'),
      body: placeholder(role: 'integralBody'),
      differential: placeholder(role: 'integralDifferential'),
    );
  }

  static MathNode bigOperator(String operator, {MathNode? upper, MathNode? lower, MathNode? body}) {
    return MathNode(
      id: MathNodeIds.create('bigop'),
      kind: MathNodeKind.bigOperator,
      operator: operator,
      slots: <String, MathNode>{
        'upper': upper ?? placeholder(role: operator == 'Π' ? 'productUpperLimit' : 'sumUpperLimit'),
        'lower': lower ?? placeholder(role: operator == 'Π' ? 'productLowerLimit' : 'sumLowerLimit'),
        'body': body ?? placeholder(role: operator == 'Π' ? 'productBody' : 'sumBody'),
      },
    );
  }

  static MathNode limit({MathNode? variable, MathNode? target, MathNode? body}) {
    return MathNode(
      id: MathNodeIds.create('limit'),
      kind: MathNodeKind.limit,
      slots: <String, MathNode>{
        'variable': variable ?? box(children: <MathNode>[atom('x')]),
        'target': target ?? placeholder(role: 'limitTarget'),
        'body': body ?? placeholder(role: 'limitBody'),
      },
    );
  }

  static MathNode functionCall(String name, {MathNode? argument}) {
    return MathNode(
      id: MathNodeIds.create('func'),
      kind: MathNodeKind.functionCall,
      operator: name,
      slots: <String, MathNode>{'arg': argument ?? placeholder(role: 'functionArgument')},
    );
  }

  static MathNode multiArgumentFunctionCall(String name, List<MathNode> arguments) {
    final slots = <String, MathNode>{};
    for (var index = 0; index < arguments.length; index += 1) {
      slots['arg_$index'] = arguments[index];
    }
    return MathNode(
      id: MathNodeIds.create('func_multi'),
      kind: MathNodeKind.functionCall,
      operator: name,
      slots: slots,
      meta: <String, Object?>{'argumentCount': arguments.length},
    );
  }

  static MathNode matrix(int rows, int columns, {String shape = 'fixed', Map<String, MathNode> cells = const <String, MathNode>{}}) {
    final safeRows = rows.clamp(1, 6).toInt();
    final safeColumns = columns.clamp(1, 6).toInt();
    final slots = <String, MathNode>{};
    final sparsePreview = shape == 'mnPreview' || shape == 'nPreview';
    for (var row = 0; row < safeRows; row += 1) {
      for (var column = 0; column < safeColumns; column += 1) {
        final key = 'cell_${row}_$column';
        if (cells.containsKey(key)) {
          slots[key] = cells[key]!;
        } else if (!sparsePreview) {
          slots[key] = matrixCellPlaceholder(row, column);
        }
      }
    }
    return MathNode(
      id: MathNodeIds.create('matrix'),
      kind: MathNodeKind.matrix,
      slots: slots,
      meta: <String, Object?>{'rows': safeRows, 'columns': safeColumns, 'shape': shape, 'editableCells': true},
    );
  }

  static MathNode vector(int dimension, {bool column = true, String shape = 'fixed', Map<String, MathNode> cells = const <String, MathNode>{}}) {
    final safeDimension = dimension.clamp(2, 6).toInt();
    final slots = <String, MathNode>{};
    final sparsePreview = shape == 'nPreview' || shape == 'mnPreview';
    for (var index = 0; index < safeDimension; index += 1) {
      final key = 'cell_$index';
      if (cells.containsKey(key)) {
        slots[key] = cells[key]!;
      } else if (!sparsePreview) {
        slots[key] = vectorCellPlaceholder(index, column: column);
      }
    }
    return MathNode(
      id: MathNodeIds.create('vector'),
      kind: MathNodeKind.vector,
      slots: slots,
      meta: <String, Object?>{'dimension': safeDimension, 'column': column, 'shape': shape, 'editableCells': true},
    );
  }

  static MathNode piecewiseSystem({
    int rows = 2,
    String relation = '=',
    Map<String, MathNode> cells = const <String, MathNode>{},
    Map<int, String> relations = const <int, String>{},
    String shape = 'fixed',
  }) {
    final safeRows = rows.clamp(1, 6).toInt();
    final slots = <String, MathNode>{};
    final relationMap = <String, String>{};
    for (var row = 0; row < safeRows; row += 1) {
      if (shape == 'nPreview' && row == 1) {
        relationMap['row_$row'] = '…';
        continue;
      }
      final leftKey = 'left_$row';
      final rightKey = 'right_$row';
      slots[leftKey] = cells[leftKey] ?? placeholder(role: 'systemLeft', linkGroup: 'system_left_$row');
      slots[rightKey] = cells[rightKey] ?? placeholder(role: 'systemRight', linkGroup: 'system_right_$row');
      relationMap['row_$row'] = relations[row] ?? relation;
    }
    return MathNode(
      id: MathNodeIds.create('piecewise'),
      kind: MathNodeKind.piecewise,
      slots: slots,
      meta: <String, Object?>{
        'type': 'system',
        'rows': safeRows,
        'shape': shape,
        'defaultRelation': relation,
        'relations': relationMap,
        'editableCells': true,
      },
    );
  }

  static MathNode series(String type, Map<String, MathNode> slots) {
    return MathNode(
      id: MathNodeIds.create('series'),
      kind: MathNodeKind.series,
      slots: slots,
      meta: <String, Object?>{'type': type},
    );
  }

  static MathNode _seriesTaylor({bool maclaurin = false}) {
    return series(maclaurin ? 'maclaurin' : 'taylor', <String, MathNode>{
      'variable': placeholder(role: 'seriesVariable', linkGroup: 'x'),
      'index': placeholder(role: 'seriesIndex', linkGroup: 'n'),
      'order': placeholder(role: 'seriesOrder', linkGroup: 'n'),
      if (!maclaurin) 'center': placeholder(role: 'seriesCenter', linkGroup: 'a'),
      'factorial': placeholder(role: 'seriesFactorial', linkGroup: 'n'),
      'base': placeholder(role: 'seriesVariable', linkGroup: 'x'),
      if (!maclaurin) 'shift': placeholder(role: 'seriesCenter', linkGroup: 'a'),
      'exponent': placeholder(role: 'seriesOrder', linkGroup: 'n'),
    });
  }

  static MathNode _seriesGeometric() {
    return series('geometric', <String, MathNode>{
      'index': placeholder(role: 'seriesIndex', linkGroup: 'n'),
      'coefficient': placeholder(role: 'seriesCoefficient', linkGroup: 'a'),
      'ratio': placeholder(role: 'seriesRatio', linkGroup: 'r'),
      'exponent': placeholder(role: 'seriesOrder', linkGroup: 'n'),
      'numerator': placeholder(role: 'seriesCoefficient', linkGroup: 'a'),
      'denominatorRatio': placeholder(role: 'seriesRatio', linkGroup: 'r'),
    });
  }

  static MathNode _seriesBinomial() {
    return series('binomial', <String, MathNode>{
      'variable': placeholder(role: 'seriesVariable', linkGroup: 'x'),
      'parameter': placeholder(role: 'seriesParameter', linkGroup: 'alpha'),
      'index': placeholder(role: 'seriesIndex', linkGroup: 'n'),
      'chooseTop': placeholder(role: 'seriesParameter', linkGroup: 'alpha'),
      'chooseBottom': placeholder(role: 'seriesIndex', linkGroup: 'n'),
      'base': placeholder(role: 'seriesVariable', linkGroup: 'x'),
      'exponent': placeholder(role: 'seriesOrder', linkGroup: 'n'),
    });
  }

  static MathNode _seriesPower(String type) {
    return series(type, <String, MathNode>{
      'variable': placeholder(role: 'seriesVariable', linkGroup: 'x'),
      'index': placeholder(role: 'seriesIndex', linkGroup: 'n'),
      'signIndex': placeholder(role: 'seriesIndex', linkGroup: 'n'),
      'base': placeholder(role: 'seriesVariable', linkGroup: 'x'),
      'exponent': placeholder(role: 'seriesOrder', linkGroup: 'n'),
      'denominator': placeholder(role: 'seriesFactorial', linkGroup: 'n'),
    });
  }

  static MathNode _slotNodeFromToken(String token, String role) {
    var clean = token.trim();
    if (clean.isEmpty || clean == '□') return placeholder(role: role);
    if (clean.startsWith('(') && clean.endsWith(')') && clean.length > 1) {
      clean = clean.substring(1, clean.length - 1);
    }
    return box(children: _parseLinearExpression(clean, placeholderRole: role));
  }

  static List<String> _splitTopLevelArguments(String source) {
    final output = <String>[];
    final buffer = StringBuffer();
    var parenDepth = 0;
    var bracketDepth = 0;
    var braceDepth = 0;
    for (var index = 0; index < source.length; index += 1) {
      final char = source[index];
      if (char == '(') parenDepth += 1;
      if (char == ')') parenDepth -= 1;
      if (char == '[') bracketDepth += 1;
      if (char == ']') bracketDepth -= 1;
      if (char == '{') braceDepth += 1;
      if (char == '}') braceDepth -= 1;
      if (char == ',' && parenDepth == 0 && bracketDepth == 0 && braceDepth == 0) {
        output.add(buffer.toString().trim());
        buffer.clear();
        continue;
      }
      buffer.write(char);
    }
    output.add(buffer.toString().trim());
    return output;
  }

  static RegExpMatch? _matchBinaryTokenTemplate(String source, String separator) {
    final escaped = RegExp.escape(separator);
    return RegExp('^(\\([^)]*\\)|[A-Za-z0-9πθλ]+|□)$escaped(\\([^)]*\\)|[A-Za-z0-9πθλ]+|□)').firstMatch(source);
  }

  static ({String index, String content, int length})? _matchEditableIndexedRootTemplate(String source) {
    final tokenMatch = RegExp(r'^(\([^)]*\)|[A-Za-z0-9πθλ]+|□)√').firstMatch(source);
    if (tokenMatch == null) return null;
    final indexToken = tokenMatch.group(1)!;
    final rootStart = indexToken.length;
    final valueMatch = _matchParenthesizedTemplate(source.substring(rootStart), '√');
    if (valueMatch == null) return null;
    return (index: indexToken, content: valueMatch.content, length: rootStart + valueMatch.length);
  }

  static ({String target, String operator, int length})? _matchPostfixTemplate(String source) {
    const operators = <String>['⁻¹', 'ᵀ', 'ᴴ', '‴', '″', '′', '̄', '!'];
    for (final operator in operators) {
      final match = RegExp(r'^(\([^)]*\)|[A-Za-z0-9πθλ]+|□)' + RegExp.escape(operator)).firstMatch(source);
      if (match != null) {
        return (target: match.group(1)!, operator: operator, length: match.group(0)!.length);
      }
    }
    return null;
  }

  static ({String base, String subscript, int length})? _matchSubscriptTemplate(String source) {
    final underscoreMatch = RegExp(r'^([A-Za-zπθλ])_((?:□)|(?:\([^)]*\))|[A-Za-z0-9πθλ]+)').firstMatch(source);
    if (underscoreMatch != null) {
      final token = underscoreMatch.group(2)!;
      final clean = token.startsWith('(') && token.endsWith(')') ? token.substring(1, token.length - 1) : token;
      return (base: underscoreMatch.group(1)!, subscript: clean, length: underscoreMatch.group(0)!.length);
    }
    const subscriptDigits = <String, String>{'₀': '0', '₁': '1', '₂': '2', '₃': '3', '₄': '4', '₅': '5', '₆': '6', '₇': '7', '₈': '8', '₉': '9', 'ₙ': '□'};
    if (source.length >= 2 && RegExp(r'[A-Za-zπθλ]').hasMatch(source[0]) && subscriptDigits.containsKey(source[1])) {
      return (base: source[0], subscript: subscriptDigits[source[1]]!, length: 2);
    }
    return null;
  }

  static ({String content, int length})? _matchEnclosedTemplate(String source, String open, String close) {
    if (!source.startsWith(open)) return null;
    final end = source.indexOf(close, open.length);
    if (end < 0) return null;
    return (content: source.substring(open.length, end), length: end + close.length);
  }

  static ({String base, String argument, int length})? _matchLogTemplate(String source) {
    const fixedBases = <String, String>{
      'log₁₀': '10',
      'log₂': '2',
    };
    for (final entry in fixedBases.entries) {
      final match = _matchParenthesizedTemplate(source, entry.key);
      if (match != null) return (base: entry.value, argument: match.content, length: match.length);
    }

    // Real-device repair: legacy slot filling used to produce log(2)(5).
    // Treat the first group as the logarithm base and the second as the
    // argument so the editor renders log₂(5), not a programmer-like call chain.
    final filledCall = RegExp(r'^log\(([^)]*)\)\(([^)]*)\)').firstMatch(source);
    if (filledCall != null) {
      return (
        base: filledCall.group(1)!,
        argument: filledCall.group(2)!,
        length: filledCall.group(0)!.length,
      );
    }

    final compactFilled = RegExp(r'^log₍([^₎]*)₎\(([^)]*)\)').firstMatch(source);
    if (compactFilled != null) {
      return (
        base: compactFilled.group(1)!,
        argument: compactFilled.group(2)!,
        length: compactFilled.group(0)!.length,
      );
    }

    final custom = RegExp(r'^log_(□|\([^)]*\)|[A-Za-z0-9πθλ]+)').firstMatch(source);
    if (custom != null) {
      final baseToken = custom.group(1)!;
      final base = baseToken.startsWith('(') && baseToken.endsWith(')') ? baseToken.substring(1, baseToken.length - 1) : baseToken;
      final body = _matchParenthesizedTemplate(source.substring(custom.group(0)!.length), '');
      if (body != null) return (base: base, argument: body.content, length: custom.group(0)!.length + body.length);
    }
    final customCompact = _matchParenthesizedTemplate(source, 'log₍□₎');
    if (customCompact != null) return (base: '□', argument: customCompact.content, length: customCompact.length);
    return null;
  }


  static ({String outer, String inner, String content, int length})? _matchCompositionCallTemplate(String source) {
    final match = RegExp(r'^\(([A-Za-z])∘([A-Za-z])\)\(([^)]*)\)').firstMatch(source);
    if (match == null) return null;
    return (
      outer: match.group(1)!,
      inner: match.group(2)!,
      content: match.group(3)!,
      length: match.group(0)!.length,
    );
  }

  static ({String name, String content, int length})? _matchFunctionTemplate(String source) {
    const names = <String>[
      'sinh⁻¹', 'cosh⁻¹', 'tanh⁻¹', 'sin⁻¹', 'cos⁻¹', 'tan⁻¹', 'cot⁻¹',
      'asinh', 'acosh', 'atanh', 'asin', 'acos', 'atan', 'acot',
      'sinh', 'cosh', 'tanh', 'sin', 'cos', 'tan', 'cot', 'coth', 'sec', 'csc',
      'ln', 'log', 'f', 'g', 'h', 'Re', 'Im', 'real', 'imag', 'arg', 'Arg', 'conj', 'cis',
      'det', 'rank', 'rref', 'eig', 'solve', 'round', 'sign', 'minor', 'cofactor',
      'pinv', 'proj', 'triple', 'unit', 'distance', 'EBOB', 'EKOK', 'asal?', 'Γ',
      '∬', '∭', '∮',
    ];
    for (final name in names) {
      final match = _matchParenthesizedTemplate(source, name);
      if (match != null) return (name: _canonicalFunctionName(name), content: match.content, length: match.length);
    }
    return null;
  }

  static String _canonicalFunctionName(String name) {
    switch (name) {
      case 'asin':
        return 'sin⁻¹';
      case 'acos':
        return 'cos⁻¹';
      case 'atan':
        return 'tan⁻¹';
      case 'asinh':
        return 'sinh⁻¹';
      case 'acosh':
        return 'cosh⁻¹';
      case 'atanh':
        return 'tanh⁻¹';
      case 'acot':
        return 'cot⁻¹';
      case 'Arg':
        return 'arg';
      case 'real':
        return 'Re';
      case 'imag':
        return 'Im';
      default:
        return name;
    }
  }

  static RegExpMatch? _matchPowerTemplate(String source) {
    return RegExp(r'^(\([^)]*\)|[A-Za-z0-9πθλ]+|□)\^\(([^)]*)\)').firstMatch(source);
  }


  static ({String operator, String lower, String upper, String body, int length})? _matchSerializedBigOperatorTemplate(String source) {
    final serialized = RegExp(r'^(Σ|Π)_\{([^}]*)\}\^\{([^}]*)\}\(([^)]*)\)').firstMatch(source);
    if (serialized != null) {
      return (
        operator: serialized.group(1)!,
        lower: serialized.group(2)!,
        upper: serialized.group(3)!,
        body: serialized.group(4)!,
        length: serialized.group(0)!.length,
      );
    }

    final infiniteIndex = RegExp(r'^(Σ|Π)([A-Za-zπθλ□]+)₌([^∞()]+)∞\(([^)]*)\)').firstMatch(source);
    if (infiniteIndex != null) {
      return (
        operator: infiniteIndex.group(1)!,
        lower: '${infiniteIndex.group(2)!}=${infiniteIndex.group(3)!.trim()}',
        upper: '∞',
        body: infiniteIndex.group(4)!,
        length: infiniteIndex.group(0)!.length,
      );
    }

    final compactIN = RegExp(r'^(Σ|Π)ᵢ₌₁ⁿ\(([^)]*)\)').firstMatch(source);
    if (compactIN != null) {
      return (
        operator: compactIN.group(1)!,
        lower: 'i=1',
        upper: 'n',
        body: compactIN.group(2)!,
        length: compactIN.group(0)!.length,
      );
    }

    return null;
  }

  static ({String variable, String target, String body, int length})? _matchCompactLimitTemplate(String source) {
    final match = RegExp(r'^lim₍([^→₎]+)→([^₎]*)₎\(([^)]*)\)').firstMatch(source);
    if (match == null) return null;
    return (
      variable: match.group(1)!.trim(),
      target: match.group(2)!.trim(),
      body: match.group(3)!,
      length: match.group(0)!.length,
    );
  }

  static ({String variable, String target, String body, int length})? _matchLimitTemplate(String source) {
    final compact = _matchCompactLimitTemplate(source);
    if (compact != null) return compact;
    const prefixes = <String, ({String variable, String target})>{
      'limₓ→□': (variable: 'x', target: '□'),
      'limₓ→∞': (variable: 'x', target: '∞'),
      'limₓ→0⁺': (variable: 'x', target: '0⁺'),
      'limₓ→0⁻': (variable: 'x', target: '0⁻'),
      'limₓ→0': (variable: 'x', target: '0'),
      'limₓ→ₐ⁻': (variable: 'x', target: 'a⁻'),
      'limₓ→ₐ⁺': (variable: 'x', target: 'a⁺'),
      'limₓ→ₐ': (variable: 'x', target: 'a'),
    };
    for (final entry in prefixes.entries) {
      final match = _matchParenthesizedTemplate(source, entry.key);
      if (match != null) {
        return (variable: entry.value.variable, target: entry.value.target, body: match.content, length: match.length);
      }
    }

    // Real-device repair: filled templates can become `lim_y → 8(8)`.
    // Parse this as a structural limit with variable, target and body slots.
    final filled = RegExp(r'^lim_?([A-Za-zπθλ])\s*→\s*([^()]+)\(([^)]*)\)').firstMatch(source);
    if (filled != null) {
      return (
        variable: filled.group(1)!,
        target: filled.group(2)!.trim(),
        body: filled.group(3)!,
        length: filled.group(0)!.length,
      );
    }

    final plain = _matchParenthesizedTemplate(source, 'lim');
    if (plain != null) return (variable: 'x', target: '□', body: plain.content, length: plain.length);
    return null;
  }

  static ({String operator, String content, int length})? _matchDerivativeLikeTemplate(String source) {
    const operators = <String>['d³/dx³', 'd²/dx²', '∂²/∂x²', '∂/∂x', 'd/dx'];
    for (final operator in operators) {
      final match = _matchParenthesizedTemplate(source, operator);
      if (match != null) {
        return (operator: operator, content: match.content, length: match.length);
      }
    }
    return null;
  }

  static int _derivativeOrderFor(String operator) {
    if (operator.contains('³')) return 3;
    if (operator.contains('²')) return 2;
    return 1;
  }

  static bool _isPartialDerivative(String operator) => operator.contains('∂');

  static ({String operator, int length})? _matchLeibnizDerivativeToken(String source) {
    for (final operator in <String>['d²y/dx²', 'dy/dx']) {
      if (source.startsWith(operator)) return (operator: operator, length: operator.length);
    }
    return null;
  }


  static const Set<String> _numberTokens = <String>{
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.',
  };

  static const Set<String> _symbolTokens = <String>{
    'x', 'y', 'z', 'a', 'b', 'c', 'n', 'm', 'k', 'r',
    'A', 'B', 'I', 'π', 'e', 'i', 'θ', 'λ', 'μ', 'φ', 'ρ', '∞',
    'rad', 'deg',
  };

  static const Set<String> _operatorTokens = <String>{
    '+', '−', '×', '÷', '%', '=', '<', '>', '≤', '≥', '≠', '≈', '≡',
    '±', '·',
  };

  static const Set<String> _delimiterTokens = <String>{
    ',', ';', '(', ')', '[', ']',
  };

  static ({MathNode node, int length})? _matchNumberLiteralToken(String source) {
    final match = RegExp(r'^(?:\d+(?:\.\d*)?|\.\d+)').firstMatch(source);
    if (match == null) return null;
    final literal = match.group(0)!;
    final hasDecimal = literal.contains('.');
    return (
      node: token(
        literal,
        'numberLiteral',
        meta: <String, Object?>{
          'numberBuilder': true,
          'hasDecimal': hasDecimal,
          'digitCount': literal.replaceAll('.', '').length,
        },
      ),
      length: literal.length,
    );
  }

  static ({MathNode node, int length})? _matchPrimitiveAstToken(String source) {
    final numberLiteral = _matchNumberLiteralToken(source);
    if (numberLiteral != null) return numberLiteral;

    const multiCharacterTokens = <String>[
      'rad', 'deg', '+∞', '−∞', '−i', 'dx', 'dy', 'dt', 'dθ',
      '≤', '≥', '≠', '≈', '≡', '±',
    ];
    for (final tokenText in multiCharacterTokens) {
      if (source.startsWith(tokenText)) {
        if (tokenText.startsWith('d') && tokenText != 'deg') {
          return (node: token(tokenText, 'differential'), length: tokenText.length);
        }
        if (tokenText == '+∞' || tokenText == '−∞') {
          return (node: token(tokenText, 'signedInfinity'), length: tokenText.length);
        }
        if (tokenText == '−i') {
          return (node: token(tokenText, 'signedComplex'), length: tokenText.length);
        }
        if (_symbolTokens.contains(tokenText)) {
          return (node: token(tokenText, 'symbol'), length: tokenText.length);
        }
        return (node: token(tokenText, 'operator'), length: tokenText.length);
      }
    }

    final char = source[0];
    if (_numberTokens.contains(char)) return (node: token(char, 'number'), length: char.length);
    if (_symbolTokens.contains(char)) return (node: token(char, 'symbol'), length: char.length);
    if (_operatorTokens.contains(char) || _delimiterTokens.contains(char)) return (node: token(char, _delimiterTokens.contains(char) ? 'delimiter' : 'operator'), length: char.length);
    return null;
  }

  static ({String lower, String upper, String body, String differential, int length})? _matchExplicitIntegralTemplate(String source) {
    if (!source.startsWith('∫_{')) return null;
    const lowerStart = 3; // '∫_{'.length
    final lowerEnd = source.indexOf('}', lowerStart);
    if (lowerEnd < 0) return null;
    final upperMarkerStart = lowerEnd + 1;
    if (!source.startsWith('^{', upperMarkerStart)) return null;
    final upperStart = upperMarkerStart + 2;
    final upperEnd = source.indexOf('}', upperStart);
    if (upperEnd < 0) return null;
    final bodyOpen = upperEnd + 1;
    if (bodyOpen >= source.length || source[bodyOpen] != '(') return null;

    var depth = 0;
    var bodyClose = -1;
    for (var index = bodyOpen; index < source.length; index += 1) {
      final char = source[index];
      if (char == '(') depth += 1;
      if (char == ')') {
        depth -= 1;
        if (depth == 0) {
          bodyClose = index;
          break;
        }
      }
    }
    if (bodyClose < 0) return null;
    final differentialStart = bodyClose + 1;
    if (differentialStart >= source.length || source[differentialStart] != 'd') return null;
    final tokenStart = differentialStart + 1;
    if (tokenStart >= source.length) return null;
    final tokenBuffer = StringBuffer();
    var cursor = tokenStart;
    if (source[cursor] == '□') {
      tokenBuffer.write('□');
      cursor += 1;
    } else {
      while (cursor < source.length && RegExp(r'[A-Za-z0-9πθλ]').hasMatch(source[cursor])) {
        tokenBuffer.write(source[cursor]);
        cursor += 1;
      }
    }
    if (tokenBuffer.isEmpty) return null;

    return (
      lower: source.substring(lowerStart, lowerEnd),
      upper: source.substring(upperStart, upperEnd),
      body: source.substring(bodyOpen + 1, bodyClose),
      differential: tokenBuffer.toString(),
      length: cursor,
    );
  }

  static ({String lower, String upper, String body, String differential, int length})? _matchCompactDefiniteIntegralTemplate(String source) {
    final limits = _compactIntegralLimits(source);
    if (limits == null) return null;
    final bodyOpen = limits.prefixLength;
    final body = _matchBodyAndDifferential(source, bodyOpen);
    if (body == null) return null;
    return (
      lower: limits.lower,
      upper: limits.upper,
      body: body.body,
      differential: body.differential,
      length: body.length,
    );
  }

  static ({String body, String differential, int length})? _matchIndefiniteIntegralTemplate(String source) {
    if (!source.startsWith('∫(')) return null;
    return _matchBodyAndDifferential(source, 1);
  }

  static ({String lower, String upper, int prefixLength})? _compactIntegralLimits(String source) {
    if (source.startsWith('∫₀¹')) return (lower: '0', upper: '1', prefixLength: '∫₀¹'.length);
    if (source.startsWith('∫ₐᵇ')) return (lower: 'a', upper: 'b', prefixLength: '∫ₐᵇ'.length);
    return null;
  }

  static ({String body, String differential, int length})? _matchBodyAndDifferential(String source, int bodyOpen) {
    if (bodyOpen >= source.length || source[bodyOpen] != '(') return null;

    var depth = 0;
    var bodyClose = -1;
    for (var index = bodyOpen; index < source.length; index += 1) {
      final char = source[index];
      if (char == '(') depth += 1;
      if (char == ')') {
        depth -= 1;
        if (depth == 0) {
          bodyClose = index;
          break;
        }
      }
    }
    if (bodyClose < 0) return null;

    final differentialStart = bodyClose + 1;
    if (differentialStart >= source.length || source[differentialStart] != 'd') return null;
    final tokenStart = differentialStart + 1;
    if (tokenStart >= source.length) return null;

    final tokenBuffer = StringBuffer();
    var cursor = tokenStart;
    if (source[cursor] == '□') {
      tokenBuffer.write('□');
      cursor += 1;
    } else {
      while (cursor < source.length && RegExp(r'[A-Za-z0-9πθλ]').hasMatch(source[cursor])) {
        tokenBuffer.write(source[cursor]);
        cursor += 1;
      }
    }
    if (tokenBuffer.isEmpty) return null;

    return (
      body: source.substring(bodyOpen + 1, bodyClose),
      differential: tokenBuffer.toString(),
      length: cursor,
    );
  }


  static ({MathNode node, int length})? _matchSystemOrPiecewiseTemplate(String source) {
    if (!source.startsWith('{')) return null;
    final end = source.indexOf('}');
    if (end <= 0) return null;
    final content = source.substring(1, end).trim();
    if (content.isEmpty) return null;

    final rawRows = content.split(';').map((row) => row.trim()).where((row) => row.isNotEmpty).toList(growable: false);
    if (rawRows.isEmpty) return null;

    final shape = rawRows.any((row) => row == '…' || row == '...') ? 'nPreview' : 'fixed';
    final cells = <String, MathNode>{};
    final relations = <int, String>{};
    var rowIndex = 0;
    for (final row in rawRows) {
      if (row == '…' || row == '...') {
        rowIndex += 1;
        continue;
      }
      final relationMatch = RegExp(r'^(.*?)(=|≤|≥|<|>)(.*)$').firstMatch(row);
      if (relationMatch == null) return null;
      final left = relationMatch.group(1)!.trim();
      final relation = relationMatch.group(2)!;
      final right = relationMatch.group(3)!.trim();
      cells['left_$rowIndex'] = _slotNodeFromToken(left.isEmpty ? '□' : left, 'systemLeft');
      cells['right_$rowIndex'] = _slotNodeFromToken(right.isEmpty ? '□' : right, 'systemRight');
      relations[rowIndex] = relation;
      rowIndex += 1;
    }

    return (
      node: piecewiseSystem(
        rows: rawRows.length,
        relation: relations.values.isEmpty ? '=' : relations.values.first,
        cells: cells,
        relations: relations,
        shape: shape,
      ),
      length: end + 1,
    );
  }

  static ({MathNode node, int length})? _matchBracketMatrixOrVectorTemplate(String source) {
    if (!source.startsWith('[')) return null;
    final end = source.indexOf(']');
    if (end <= 0) return null;
    final content = source.substring(1, end).trim();
    if (content.isEmpty) return null;
    final rowTokens = content.split(';').map((row) => row.trim()).where((row) => row.isNotEmpty).toList(growable: false);
    if (rowTokens.isEmpty) return null;
    final parsedRows = <List<String>>[];
    for (final row in rowTokens) {
      final cells = row.split(RegExp(r'\s+')).where((cell) => cell.isNotEmpty).toList(growable: false);
      if (cells.isEmpty) return null;
      parsedRows.add(cells);
    }

    final hasEllipsis = parsedRows.any((row) => row.any((cell) => cell == '…' || cell == '...'));
    final rowCount = parsedRows.length;
    final columnCount = parsedRows.map((row) => row.length).reduce((a, b) => a > b ? a : b);
    if (rowCount == 1 && !content.contains(';')) {
      final cells = <String, MathNode>{};
      for (var index = 0; index < parsedRows.first.length; index += 1) {
        final token = parsedRows.first[index];
        if (token == '…' || token == '...') continue;
        cells['cell_$index'] = _slotNodeFromToken(token, 'matrixCell');
      }
      return (node: vector(parsedRows.first.length, column: false, shape: hasEllipsis ? 'nPreview' : 'fixed', cells: cells), length: end + 1);
    }
    if (columnCount == 1) {
      final cells = <String, MathNode>{};
      for (var index = 0; index < parsedRows.length; index += 1) {
        final token = parsedRows[index].first;
        if (token == '…' || token == '...') continue;
        cells['cell_$index'] = _slotNodeFromToken(token, 'matrixCell');
      }
      return (node: vector(parsedRows.length, column: true, shape: hasEllipsis ? 'nPreview' : 'fixed', cells: cells), length: end + 1);
    }

    final cells = <String, MathNode>{};
    for (var row = 0; row < rowCount; row += 1) {
      final sourceRow = parsedRows[row];
      for (var column = 0; column < columnCount; column += 1) {
        if (column >= sourceRow.length) continue;
        final token = sourceRow[column];
        if (token == '…' || token == '...') continue;
        cells['cell_${row}_$column'] = _slotNodeFromToken(token, 'matrixCell');
      }
    }
    return (node: matrix(rowCount, columnCount, shape: hasEllipsis ? 'mnPreview' : 'fixed', cells: cells), length: end + 1);
  }

  static ({String content, int length})? _matchParenthesizedTemplate(String source, String prefix) {
    final marker = '$prefix(';
    if (!source.startsWith(marker)) return null;
    var depth = 0;
    final contentStart = marker.length;
    for (var index = prefix.length; index < source.length; index += 1) {
      final char = source[index];
      if (char == '(') depth += 1;
      if (char == ')') {
        depth -= 1;
        if (depth == 0) {
          return (content: source.substring(contentStart, index), length: index + 1);
        }
      }
    }
    return null;
  }


  static List<MathNode>? _seriesTemplateNodes(String source) {
    // V139: series templates must remain semantic after slot edits.  The
    // exact placeholder templates below cover initial insertion, while the
    // filled-form parsers cover strings produced by EditorCommands after the
    // user writes into Taylor/Maclaurin/geometric/binomial slots.  Without this
    // round-trip path a mathematically rendered series degraded back into raw
    // text as soon as any slot was filled.
    switch (source) {
      case 'f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□':
        return <MathNode>[_seriesTaylor()];
      case 'f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□':
        return <MathNode>[_seriesTaylor(maclaurin: true)];
      case 'Σ□₌₀∞□·□^□=□⁄(1-□)':
        return <MathNode>[_seriesGeometric()];
      case '(1+□)^□=Σ□₌₀∞(□C□)□^□':
        return <MathNode>[_seriesBinomial()];
      case 'e^□=Σ□₌₀∞□^□⁄□!':
        return <MathNode>[_seriesPower('exp')];
      case 'sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!':
        return <MathNode>[_seriesPower('sin')];
      case 'cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!':
        return <MathNode>[_seriesPower('cos')];
      case 'ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□':
        return <MathNode>[_seriesPower('ln')];
      case 'arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)':
        return <MathNode>[_seriesPower('arctan')];
    }

    final filled = _filledSeriesTemplateNode(source);
    return filled == null ? null : <MathNode>[filled];
  }

  static MathNode? _filledSeriesTemplateNode(String source) {
    final taylor = RegExp(r'^f\(([^)]*)\)=Σ(.+?)₌₀∞\(f⁽([^⁾]*)⁾\(([^)]*)\)⁄([^!]*)!\)\(([^)]*)-([^)]*)\)\^(.+)$').firstMatch(source);
    if (taylor != null) {
      return series('taylor', <String, MathNode>{
        'variable': _slotNodeFromToken(taylor.group(1)!, 'seriesVariable'),
        'index': _slotNodeFromToken(taylor.group(2)!, 'seriesIndex'),
        'order': _slotNodeFromToken(taylor.group(3)!, 'seriesOrder'),
        'center': _slotNodeFromToken(taylor.group(4)!, 'seriesCenter'),
        'factorial': _slotNodeFromToken(taylor.group(5)!, 'seriesFactorial'),
        'base': _slotNodeFromToken(taylor.group(6)!, 'seriesVariable'),
        'shift': _slotNodeFromToken(taylor.group(7)!, 'seriesCenter'),
        'exponent': _slotNodeFromToken(taylor.group(8)!, 'seriesOrder'),
      });
    }

    final maclaurin = RegExp(r'^f\(([^)]*)\)=Σ(.+?)₌₀∞\(f⁽([^⁾]*)⁾\(0\)⁄([^!]*)!\)(.+)\^(.+)$').firstMatch(source);
    if (maclaurin != null) {
      return series('maclaurin', <String, MathNode>{
        'variable': _slotNodeFromToken(maclaurin.group(1)!, 'seriesVariable'),
        'index': _slotNodeFromToken(maclaurin.group(2)!, 'seriesIndex'),
        'order': _slotNodeFromToken(maclaurin.group(3)!, 'seriesOrder'),
        'factorial': _slotNodeFromToken(maclaurin.group(4)!, 'seriesFactorial'),
        'base': _slotNodeFromToken(maclaurin.group(5)!, 'seriesVariable'),
        'exponent': _slotNodeFromToken(maclaurin.group(6)!, 'seriesOrder'),
      });
    }

    final geometric = RegExp(r'^Σ(.+?)₌₀∞(.+)·(.+)\^(.+)=(.+)⁄\(1-(.+)\)$').firstMatch(source);
    if (geometric != null) {
      return series('geometric', <String, MathNode>{
        'index': _slotNodeFromToken(geometric.group(1)!, 'seriesIndex'),
        'coefficient': _slotNodeFromToken(geometric.group(2)!, 'seriesCoefficient'),
        'ratio': _slotNodeFromToken(geometric.group(3)!, 'seriesRatio'),
        'exponent': _slotNodeFromToken(geometric.group(4)!, 'seriesOrder'),
        'numerator': _slotNodeFromToken(geometric.group(5)!, 'seriesCoefficient'),
        'denominatorRatio': _slotNodeFromToken(geometric.group(6)!, 'seriesRatio'),
      });
    }

    final binomial = RegExp(r'^\(1\+(.+)\)\^(.+)=Σ(.+?)₌₀∞\((.+)C(.+)\)(.+)\^(.+)$').firstMatch(source);
    if (binomial != null) {
      return series('binomial', <String, MathNode>{
        'variable': _slotNodeFromToken(binomial.group(1)!, 'seriesVariable'),
        'parameter': _slotNodeFromToken(binomial.group(2)!, 'seriesParameter'),
        'index': _slotNodeFromToken(binomial.group(3)!, 'seriesIndex'),
        'chooseTop': _slotNodeFromToken(binomial.group(4)!, 'seriesParameter'),
        'chooseBottom': _slotNodeFromToken(binomial.group(5)!, 'seriesIndex'),
        'base': _slotNodeFromToken(binomial.group(6)!, 'seriesVariable'),
        'exponent': _slotNodeFromToken(binomial.group(7)!, 'seriesOrder'),
      });
    }

    final exp = RegExp(r'^e\^(.+)=Σ(.+?)₌₀∞(.+)\^(.+)⁄([^!]*)!$').firstMatch(source);
    if (exp != null) {
      return series('exp', <String, MathNode>{
        'variable': _slotNodeFromToken(exp.group(1)!, 'seriesVariable'),
        'index': _slotNodeFromToken(exp.group(2)!, 'seriesIndex'),
        'base': _slotNodeFromToken(exp.group(3)!, 'seriesVariable'),
        'exponent': _slotNodeFromToken(exp.group(4)!, 'seriesOrder'),
        'denominator': _slotNodeFromToken(exp.group(5)!, 'seriesFactorial'),
      });
    }

    return null;
  }

  static List<MathNode> _parseLinearExpression(String source, {String placeholderRole = 'body'}) {
    final seriesNodes = _seriesTemplateNodes(source);
    if (seriesNodes != null) return seriesNodes;

    final nodes = <MathNode>[];
    var i = 0;
    while (i < source.length) {
      final rest = source.substring(i);

      final absMatch = _matchEnclosedTemplate(rest, '|', '|');
      if (absMatch != null) {
        nodes.add(functionCall('abs', argument: _slotNodeFromToken(absMatch.content, 'functionArgument')));
        i += absMatch.length;
        continue;
      }
      final normMatch = _matchEnclosedTemplate(rest, '‖', '‖');
      if (normMatch != null) {
        nodes.add(functionCall('norm', argument: _slotNodeFromToken(normMatch.content, 'functionArgument')));
        i += normMatch.length;
        continue;
      }
      final floorMatch = _matchEnclosedTemplate(rest, '⌊', '⌋');
      if (floorMatch != null) {
        nodes.add(functionCall('floor', argument: _slotNodeFromToken(floorMatch.content, 'functionArgument')));
        i += floorMatch.length;
        continue;
      }
      final ceilMatch = _matchEnclosedTemplate(rest, '⌈', '⌉');
      if (ceilMatch != null) {
        nodes.add(functionCall('ceil', argument: _slotNodeFromToken(ceilMatch.content, 'functionArgument')));
        i += ceilMatch.length;
        continue;
      }

      final fractionMatch = _matchBinaryTokenTemplate(rest, '⁄');
      if (fractionMatch != null) {
        nodes.add(fraction(
          numerator: _slotNodeFromToken(fractionMatch.group(1)!, 'fractionNumerator'),
          denominator: _slotNodeFromToken(fractionMatch.group(2)!, 'fractionDenominator'),
        ));
        i += fractionMatch.group(0)!.length;
        continue;
      }
      final sqrtMatch = _matchParenthesizedTemplate(rest, '√');
      if (sqrtMatch != null) {
        nodes.add(sqrt(value: _slotNodeFromToken(sqrtMatch.content, 'sqrtValue')));
        i += sqrtMatch.length;
        continue;
      }
      if (rest.startsWith('√□')) {
        nodes.add(sqrt());
        i += '√□'.length;
        continue;
      }
      final editableIndexedRootMatch = _matchEditableIndexedRootTemplate(rest);
      if (editableIndexedRootMatch != null) {
        nodes.add(sqrt(
          indexed: true,
          index: _slotNodeFromToken(editableIndexedRootMatch.index, 'rootIndex'),
          value: _slotNodeFromToken(editableIndexedRootMatch.content, 'sqrtValue'),
        ));
        i += editableIndexedRootMatch.length;
        continue;
      }
      final cubeRootMatch = _matchParenthesizedTemplate(rest, '³√');
      final nRootMatch = _matchParenthesizedTemplate(rest, 'ⁿ√');
      final indexedRootMatch = cubeRootMatch ?? nRootMatch;
      if (indexedRootMatch != null) {
        nodes.add(sqrt(
          indexed: true,
          index: cubeRootMatch != null ? box(children: <MathNode>[atom('3')]) : box(children: <MathNode>[atom('n')]),
          value: _slotNodeFromToken(indexedRootMatch.content, 'sqrtValue'),
        ));
        i += indexedRootMatch.length;
        continue;
      }
      final derivativeLikeMatch = _matchDerivativeLikeTemplate(rest);
      if (derivativeLikeMatch != null) {
        final derivativeBodyRole = derivativeLikeMatch.content.trim() == '□'
            ? 'derivativeBody'
            : 'functionArgument';
        nodes.add(derivative(
          notation: derivativeLikeMatch.operator,
          order: _derivativeOrderFor(derivativeLikeMatch.operator),
          partial: _isPartialDerivative(derivativeLikeMatch.operator),
          body: _slotNodeFromToken(derivativeLikeMatch.content, derivativeBodyRole),
        ));
        i += derivativeLikeMatch.length;
        continue;
      }
      if (rest.startsWith('i²')) {
        nodes.add(power(
          base: box(children: <MathNode>[atom('i')]),
          exponent: box(children: <MathNode>[atom('2')]),
          meta: const <String, Object?>{'fixedAtom': true},
        ));
        i += 'i²'.length;
        continue;
      }
      final powerMatch = _matchPowerTemplate(rest);
      if (powerMatch != null) {
        nodes.add(power(
          base: _slotNodeFromToken(powerMatch.group(1)!, 'powerBase'),
          exponent: _slotNodeFromToken(powerMatch.group(2)!, 'powerExponent'),
        ));
        i += powerMatch.group(0)!.length;
        continue;
      }
      final subscriptMatch = _matchSubscriptTemplate(rest);
      if (subscriptMatch != null) {
        nodes.add(subscript(
          base: _slotNodeFromToken(subscriptMatch.base, 'subscriptBase'),
          subscript: _slotNodeFromToken(subscriptMatch.subscript, 'subscript'),
          meta: subscriptMatch.subscript == '□' ? const <String, Object?>{} : const <String, Object?>{'fixedAtom': true},
        ));
        i += subscriptMatch.length;
        continue;
      }
      final logMatch = _matchLogTemplate(rest);
      if (logMatch != null) {
        nodes.add(logBase(
          base: _slotNodeFromToken(logMatch.base, 'logBase'),
          argument: _slotNodeFromToken(logMatch.argument, 'functionArgument'),
        ));
        i += logMatch.length;
        continue;
      }
      final combinationMatch = _matchBinaryTokenTemplate(rest, 'C');
      if (combinationMatch != null) {
        nodes.add(multiArgumentFunctionCall(
          'combination',
          <MathNode>[
            _slotNodeFromToken(combinationMatch.group(1)!, 'functionArgument'),
            _slotNodeFromToken(combinationMatch.group(2)!, 'functionArgument2'),
          ],
        ));
        i += combinationMatch.group(0)!.length;
        continue;
      }
      final permutationMatch = _matchBinaryTokenTemplate(rest, 'P');
      if (permutationMatch != null) {
        nodes.add(multiArgumentFunctionCall(
          'permutation',
          <MathNode>[
            _slotNodeFromToken(permutationMatch.group(1)!, 'functionArgument'),
            _slotNodeFromToken(permutationMatch.group(2)!, 'functionArgument2'),
          ],
        ));
        i += permutationMatch.group(0)!.length;
        continue;
      }
      final compositionCallMatch = _matchCompositionCallTemplate(rest);
      if (compositionCallMatch != null) {
        nodes.add(functionCall(
          '${compositionCallMatch.outer}∘${compositionCallMatch.inner}',
          argument: _slotNodeFromToken(compositionCallMatch.content, 'functionArgument'),
        ));
        i += compositionCallMatch.length;
        continue;
      }
      final functionBeforePostfixMatch = _matchFunctionTemplate(rest);
      if (functionBeforePostfixMatch != null) {
        final args = _splitTopLevelArguments(functionBeforePostfixMatch.content);
        nodes.add(args.length > 1
            ? multiArgumentFunctionCall(
                functionBeforePostfixMatch.name,
                <MathNode>[
                  for (var argIndex = 0; argIndex < args.length; argIndex += 1)
                    _slotNodeFromToken(args[argIndex], argIndex == 0 ? 'functionArgument' : 'functionArgument${argIndex + 1}'),
                ],
              )
            : functionCall(
                functionBeforePostfixMatch.name,
                argument: _slotNodeFromToken(functionBeforePostfixMatch.content, 'functionArgument'),
              ));
        i += functionBeforePostfixMatch.length;
        continue;
      }
      final postfixTemplateMatch = _matchPostfixTemplate(rest);
      if (postfixTemplateMatch != null) {
        final fixedPostfixAtom = postfixTemplateMatch.target != '□' &&
            const <String>{'′', '″', '‴', '̄'}.contains(postfixTemplateMatch.operator);
        nodes.add(postfix(
          operator: postfixTemplateMatch.operator,
          target: _slotNodeFromToken(postfixTemplateMatch.target, 'postfixTarget'),
          meta: fixedPostfixAtom ? const <String, Object?>{'fixedAtom': true} : const <String, Object?>{},
        ));
        i += postfixTemplateMatch.length;
        continue;
      }
      final serializedBigOperatorMatch = _matchSerializedBigOperatorTemplate(rest);
      if (serializedBigOperatorMatch != null) {
        nodes.add(bigOperator(
          serializedBigOperatorMatch.operator,
          lower: _slotNodeFromToken(serializedBigOperatorMatch.lower, serializedBigOperatorMatch.operator == 'Π' ? 'productLowerLimit' : 'sumLowerLimit'),
          upper: _slotNodeFromToken(serializedBigOperatorMatch.upper, serializedBigOperatorMatch.operator == 'Π' ? 'productUpperLimit' : 'sumUpperLimit'),
          body: _slotNodeFromToken(serializedBigOperatorMatch.body, serializedBigOperatorMatch.operator == 'Π' ? 'productBody' : 'sumBody'),
        ));
        i += serializedBigOperatorMatch.length;
        continue;
      }
      if (rest.startsWith('^(□)')) {
        // Legacy Phase 17 shorthand. Keep it readable, but normalize the AST
        // to a full base/exponent template so the slot registry remains true.
        nodes.add(power());
        i += '^(□)'.length;
        continue;
      }
      final leibnizDerivativeMatch = _matchLeibnizDerivativeToken(rest);
      if (leibnizDerivativeMatch != null) {
        nodes.add(derivative(
          notation: leibnizDerivativeMatch.operator,
          order: _derivativeOrderFor(leibnizDerivativeMatch.operator),
          body: box(children: <MathNode>[atom('y')]),
          dependent: box(children: <MathNode>[atom('y')]),
        ));
        i += leibnizDerivativeMatch.length;
        continue;
      }
      final explicitIntegralMatch = _matchExplicitIntegralTemplate(rest);
      if (explicitIntegralMatch != null) {
        nodes.add(integral(
          definite: true,
          lower: _slotNodeFromToken(explicitIntegralMatch.lower, 'integralLowerLimit'),
          upper: _slotNodeFromToken(explicitIntegralMatch.upper, 'integralUpperLimit'),
          body: _slotNodeFromToken(explicitIntegralMatch.body, 'integralBody'),
          differential: _slotNodeFromToken(explicitIntegralMatch.differential, 'integralDifferential'),
        ));
        i += explicitIntegralMatch.length;
        continue;
      }
      final compactIntegralMatch = _matchCompactDefiniteIntegralTemplate(rest);
      if (compactIntegralMatch != null) {
        nodes.add(integral(
          definite: true,
          lower: _slotNodeFromToken(compactIntegralMatch.lower, 'integralLowerLimit'),
          upper: _slotNodeFromToken(compactIntegralMatch.upper, 'integralUpperLimit'),
          body: _slotNodeFromToken(compactIntegralMatch.body, 'integralBody'),
          differential: _slotNodeFromToken(compactIntegralMatch.differential, 'integralDifferential'),
        ));
        i += compactIntegralMatch.length;
        continue;
      }
      final plainIntegralMatch = _matchIndefiniteIntegralTemplate(rest);
      if (plainIntegralMatch != null) {
        nodes.add(integral(
          body: _slotNodeFromToken(plainIntegralMatch.body, 'integralBody'),
          differential: _slotNodeFromToken(plainIntegralMatch.differential, 'integralDifferential'),
        ));
        i += plainIntegralMatch.length;
        continue;
      }
      final limitMatch = _matchLimitTemplate(rest);
      if (limitMatch != null) {
        nodes.add(limit(
          variable: _slotNodeFromToken(limitMatch.variable, 'limitVariable'),
          target: _slotNodeFromToken(limitMatch.target, 'limitTarget'),
          body: _slotNodeFromToken(limitMatch.body, 'limitBody'),
        ));
        i += limitMatch.length;
        continue;
      }
      final sumBodyMatch = _matchParenthesizedTemplate(rest, 'Σ');
      if (sumBodyMatch != null) {
        nodes.add(bigOperator('Σ', body: _slotNodeFromToken(sumBodyMatch.content, 'sumBody')));
        i += sumBodyMatch.length;
        continue;
      }
      final productBodyMatch = _matchParenthesizedTemplate(rest, 'Π');
      if (productBodyMatch != null) {
        nodes.add(bigOperator('Π', body: _slotNodeFromToken(productBodyMatch.content, 'productBody')));
        i += productBodyMatch.length;
        continue;
      }
      if (rest.startsWith('f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□')) {
        nodes.add(_seriesTaylor());
        i += 'f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□'.length;
        continue;
      }
      if (rest.startsWith('f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□')) {
        nodes.add(_seriesTaylor(maclaurin: true));
        i += 'f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□'.length;
        continue;
      }
      if (rest.startsWith('Σ□₌₀∞□·□^□=□⁄(1-□)')) {
        nodes.add(_seriesGeometric());
        i += 'Σ□₌₀∞□·□^□=□⁄(1-□)'.length;
        continue;
      }
      if (rest.startsWith('(1+□)^□=Σ□₌₀∞(□C□)□^□')) {
        nodes.add(_seriesBinomial());
        i += '(1+□)^□=Σ□₌₀∞(□C□)□^□'.length;
        continue;
      }
      if (rest.startsWith('e^□=Σ□₌₀∞□^□⁄□!')) {
        nodes.add(_seriesPower('exp'));
        i += 'e^□=Σ□₌₀∞□^□⁄□!'.length;
        continue;
      }
      if (rest.startsWith('sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!')) {
        nodes.add(_seriesPower('sin'));
        i += 'sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!'.length;
        continue;
      }
      if (rest.startsWith('cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!')) {
        nodes.add(_seriesPower('cos'));
        i += 'cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!'.length;
        continue;
      }
      if (rest.startsWith('ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□')) {
        nodes.add(_seriesPower('ln'));
        i += 'ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□'.length;
        continue;
      }
      if (rest.startsWith('arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)')) {
        nodes.add(_seriesPower('arctan'));
        i += 'arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)'.length;
        continue;
      }
      final systemMatch = _matchSystemOrPiecewiseTemplate(rest);
      if (systemMatch != null) {
        nodes.add(systemMatch.node);
        i += systemMatch.length;
        continue;
      }
      if (rest.startsWith('[□ □ □]·[□ □ □]')) {
        nodes.add(matrix(1, 3));
        nodes.add(token('·', 'operator'));
        nodes.add(matrix(1, 3));
        i += '[□ □ □]·[□ □ □]'.length;
        continue;
      }
      final bracketMatrixOrVectorMatch = _matchBracketMatrixOrVectorTemplate(rest);
      if (bracketMatrixOrVectorMatch != null) {
        nodes.add(bracketMatrixOrVectorMatch.node);
        i += bracketMatrixOrVectorMatch.length;
        continue;
      }
      if (rest.startsWith('[□ □ □ □; □ □ □ □; □ □ □ □; □ □ □ □]')) {
        nodes.add(matrix(4, 4));
        i += '[□ □ □ □; □ □ □ □; □ □ □ □; □ □ □ □]'.length;
        continue;
      }
      if (rest.startsWith('[□ □ □; □ □ □; □ □ □]')) {
        nodes.add(matrix(3, 3));
        i += '[□ □ □; □ □ □; □ □ □]'.length;
        continue;
      }
      if (rest.startsWith('[□ □; □ □]')) {
        nodes.add(matrix(2, 2));
        i += '[□ □; □ □]'.length;
        continue;
      }
      if (rest.startsWith('[□ … □; … ; □ … □]')) {
        nodes.add(matrix(3, 3, shape: 'mnPreview'));
        i += '[□ … □; … ; □ … □]'.length;
        continue;
      }
      if (rest.startsWith('[□; … ; □]')) {
        nodes.add(vector(3, column: true, shape: 'nPreview'));
        i += '[□; … ; □]'.length;
        continue;
      }
      if (rest.startsWith('[□; □; □]')) {
        nodes.add(vector(3, column: true));
        i += '[□; □; □]'.length;
        continue;
      }
      if (rest.startsWith('[□; □]')) {
        nodes.add(vector(2, column: true));
        i += '[□; □]'.length;
        continue;
      }
      if (rest.startsWith('[□ □ □]')) {
        nodes.add(vector(3, column: false));
        i += '[□ □ □]'.length;
        continue;
      }
      if (rest.startsWith('[□ □]')) {
        nodes.add(vector(2, column: false));
        i += '[□ □]'.length;
        continue;
      }
      if (rest.startsWith('‖□‖')) {
        nodes.add(functionCall('norm'));
        i += '‖□‖'.length;
        continue;
      }
      if (rest.startsWith('e^(□)')) {
        nodes.add(power(baseText: 'e'));
        i += 'e^(□)'.length;
        continue;
      }
      if (rest.startsWith('y⁽□⁾')) {
        nodes.add(box(children: <MathNode>[
          text('y⁽'),
          placeholder(role: 'derivativeOrder'),
          text('⁾'),
        ]));
        i += 'y⁽□⁾'.length;
        continue;
      }
      if (rest.startsWith('□')) {
        nodes.add(placeholder(role: placeholderRole));
        i += '□'.length;
        continue;
      }
      final primitiveAstToken = _matchPrimitiveAstToken(rest);
      if (primitiveAstToken != null) {
        nodes.add(primitiveAstToken.node);
        i += primitiveAstToken.length;
        continue;
      }

      nodes.add(text(source[i]));
      i += 1;
    }
    return _coalesceText(nodes);
  }

  static List<MathNode> _coalesceText(List<MathNode> nodes) {
    final output = <MathNode>[];
    final buffer = StringBuffer();
    void flush() {
      if (buffer.isEmpty) return;
      output.add(text(buffer.toString()));
      buffer.clear();
    }

    for (final node in nodes) {
      if (node.kind == MathNodeKind.text && node.meta.isEmpty) {
        buffer.write(node.text ?? '');
      } else {
        flush();
        output.add(node);
      }
    }
    flush();
    return output;
  }
}
