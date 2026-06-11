import 'math_node.dart';

class TexSerializer {
  const TexSerializer._();

  static String serialize(MathNode node) => EditorTexSerializer.serialize(node);
}

class EditorTexSerializer {
  const EditorTexSerializer._();

  static String serialize(MathNode node) {
    switch (node.kind) {
      case MathNodeKind.text:
        return _serializeText(node.text ?? '');
      case MathNodeKind.number:
        return _serializeNumber(node.text ?? '');
      case MathNodeKind.symbol:
        return _serializeSymbol(node.text ?? '');
      case MathNodeKind.constant:
        return _serializeConstant(node.text ?? '', node.meta);
      case MathNodeKind.operatorToken:
        return _serializeOperator(node.text ?? '');
      case MathNodeKind.delimiter:
        return _serializeDelimiter(node.text ?? '');
      case MathNodeKind.box:
      case MathNodeKind.row:
        return node.children.map(serialize).join();
      case MathNodeKind.placeholder:
        return r'\Box';
      case MathNodeKind.fraction:
        return '\\frac{${serialize(node.slots['numerator']!)}}{${serialize(node.slots['denominator']!)}}';
      case MathNodeKind.sqrt:
        return '\\sqrt{${serialize(node.slots['value']!)}}';
      case MathNodeKind.indexedRoot:
        return '\\sqrt[${serialize(node.slots['index']!)}]{${serialize(node.slots['value']!)}}';
      case MathNodeKind.power:
        return '{${serialize(node.slots['base']!)}}^{${serialize(node.slots['exponent']!)}}';
      case MathNodeKind.subscript:
        return '{${serialize(node.slots['base']!)}}_{${serialize(node.slots['subscript']!)}}';
      case MathNodeKind.integral:
        final upper = node.slots['upper'];
        final lower = node.slots['lower'];
        final body = serialize(node.slots['body']!);
        final differentialNode = node.slots['differential']!;
        final differentialBody = serialize(differentialNode);
        final differential = differentialNode.kind == MathNodeKind.placeholder
            ? 'd$differentialBody'
            : differentialBody.startsWith('d')
                ? differentialBody
                : 'd$differentialBody';
        if (upper != null && lower != null) {
          return '\\int_{${serialize(lower)}}^{${serialize(upper)}}{$body}\\,$differential';
        }
        return '\\int{$body}\\,$differential';
      case MathNodeKind.derivative:
        return _serializeDerivative(node);
      case MathNodeKind.bigOperator:
        final op = node.operator == 'Π' ? r'\prod' : r'\sum';
        return '${op}_{${serialize(node.slots['lower']!)}}^{${serialize(node.slots['upper']!)}}${serialize(node.slots['body']!)}';
      case MathNodeKind.limit:
        return '\\lim_{${serialize(node.slots['variable']!)}\\to ${serialize(node.slots['target']!)}}${serialize(node.slots['body']!)}';
      case MathNodeKind.functionCall:
        final operator = node.operator ?? 'f';
        final argumentKeys = node.slots.keys.where((key) => RegExp(r'^arg_\d+$').hasMatch(key)).toList()..sort();
        final argument = argumentKeys.isEmpty
            ? serialize(node.slots['arg']!)
            : argumentKeys.map((key) => serialize(node.slots[key]!)).join(',');
        if (operator == 'abs') return '\\left|$argument\\right|';
        if (operator == 'norm') return '\\left\\|$argument\\right\\|';
        if (operator == 'floor') return '\\left\\lfloor $argument\\right\\rfloor';
        if (operator == 'ceil') return '\\left\\lceil $argument\\right\\rceil';
        if (operator == '∬') return '\\iint\\left($argument\\right)';
        if (operator == '∭') return '\\iiint\\left($argument\\right)';
        if (operator == '∮') return '\\oint\\left($argument\\right)';
        if (operator == 'd/dx') return '\\frac{d}{dx}\\left($argument\\right)';
        if (operator == 'd²/dx²') return '\\frac{d^{2}}{dx^{2}}\\left($argument\\right)';
        if (operator == 'd³/dx³') return '\\frac{d^{3}}{dx^{3}}\\left($argument\\right)';
        if (operator == 'combination' && argumentKeys.length == 2) {
          return '\\binom{${serialize(node.slots[argumentKeys[0]]!)}}{${serialize(node.slots[argumentKeys[1]]!)}}';
        }
        if (operator == 'permutation' && argumentKeys.length == 2) {
          return '{}_{${serialize(node.slots[argumentKeys[0]]!)}}P_{${serialize(node.slots[argumentKeys[1]]!)}}';
        }
        if (operator == '∂/∂x') return '\\frac{\\partial}{\\partial x}\\left($argument\\right)';
        if (operator == '∂²/∂x²') return '\\frac{\\partial^{2}}{\\partial x^{2}}\\left($argument\\right)';
        final name = _functionTexName(operator);
        return '$name\\left($argument\\right)';
      case MathNodeKind.matrix:
        return _serializeMatrix(node);
      case MathNodeKind.vector:
        return _serializeVector(node);
      case MathNodeKind.piecewise:
        return _serializePiecewise(node);
      case MathNodeKind.series:
        return _serializeSeries(node);
      case MathNodeKind.logBase:
        return '\\log_{${serialize(node.slots['base']!)}}\\left(${serialize(node.slots['arg']!)}\\right)';
      case MathNodeKind.postfix:
        return _serializePostfix(node);
      case MathNodeKind.unknown:
        return _serializeText(node.text ?? '');
    }
  }


  static String _serializeOperator(String value) {
    switch (value) {
      case '−':
        return '-';
      case '×':
        return r'\times';
      case '÷':
        return r'\div';
      case '%':
        return r'\%';
      case '≤':
        return r'\le';
      case '≥':
        return r'\ge';
      case '≠':
        return r'\ne';
      case '≈':
        return r'\approx';
      case '≡':
        return r'\equiv';
      case '±':
        return r'\pm';
      case '·':
        return r'\cdot';
      default:
        return _serializeText(value);
    }
  }

  static String _serializeDelimiter(String value) {
    switch (value) {
      case '[':
        return r'\left[';
      case ']':
        return r'\right]';
      default:
        return _serializeText(value);
    }
  }


  static String _serializePostfix(MathNode node) {
    final target = serialize(node.slots['target'] ?? const MathNode(id: 'fallback-postfix-target', kind: MathNodeKind.placeholder));
    switch (node.operator) {
      case '!':
        return '{$target}!';
      case '⁻¹':
        return '{$target}^{-1}';
      case 'ᵀ':
        return '{$target}^{T}';
      case 'ᴴ':
        return '{$target}^{H}';
      case '′':
        return "{$target}'";
      case '″':
        return "{$target}''";
      case '‴':
        return "{$target}'''";
      case '̄':
        return '\\overline{$target}';
      default:
        return '$target${_serializeText(node.operator ?? node.text ?? '')}';
    }
  }

  static String _serializeDerivative(MathNode node) {
    final notation = node.operator ?? (node.meta['notation'] as String? ?? 'd/dx');
    final order = (node.meta['order'] as int?) ?? 1;
    final partial = (node.meta['partial'] as bool?) ?? notation.contains('∂');
    final variable = node.slots['variable'] == null ? 'x' : serialize(node.slots['variable']!);
    final bodyNode = node.slots['body'];
    final body = bodyNode == null ? null : serialize(bodyNode);
    if (notation == 'dy/dx') return r'\frac{dy}{dx}';
    if (notation == 'd²y/dx²') return r'\frac{d^{2}y}{dx^{2}}';
    final d = partial ? r'\partial' : 'd';
    final numerator = order <= 1 ? d : '$d^{$order}';
    final denominator = order <= 1
        ? (partial ? '$d $variable' : '$d$variable')
        : (partial ? '$d $variable^{$order}' : '$d$variable^{$order}');
    final fraction = '\\frac{$numerator}{$denominator}';
    if (body == null || body.isEmpty) return fraction;
    return '$fraction\\left($body\\right)';
  }

  static String _serializeMatrix(MathNode node) {
    final rows = (node.meta['rows'] as int?) ?? 2;
    final columns = (node.meta['columns'] as int?) ?? 2;
    final shape = node.meta['shape'] as String?;
    final rowTex = <String>[];
    for (var row = 0; row < rows; row += 1) {
      final cells = <String>[];
      for (var column = 0; column < columns; column += 1) {
        final slot = node.slots['cell_${row}_$column'];
        if (shape == 'mnPreview' && row == 1 && column == 1) {
          cells.add(r'\ddots');
        } else if (shape == 'mnPreview' && (row == 0 && column == 1 || row == 2 && column == 1)) {
          cells.add(r'\cdots');
        } else if (shape == 'mnPreview' && (row == 1 && column == 0 || row == 1 && column == 2)) {
          cells.add(r'\vdots');
        } else {
          cells.add(slot == null ? r'\Box' : serialize(slot));
        }
      }
      rowTex.add(cells.join(' & '));
    }
    return '\\begin{bmatrix}${rowTex.join(r' \\ ')}\\end{bmatrix}';
  }

  static String _serializeVector(MathNode node) {
    final dimension = (node.meta['dimension'] as int?) ?? 2;
    final column = (node.meta['column'] as bool?) ?? true;
    final shape = node.meta['shape'] as String?;
    final cells = <String>[];
    for (var index = 0; index < dimension; index += 1) {
      if (shape == 'nPreview' && index == 1) {
        cells.add(r'\vdots');
      } else {
        cells.add(serialize(node.slots['cell_$index']!));
      }
    }
    final separator = column ? r' \\ ' : ' & ';
    return '\\begin{bmatrix}${cells.join(separator)}\\end{bmatrix}';
  }


  static String _serializePiecewise(MathNode node) {
    final rows = (node.meta['rows'] as int?) ?? 2;
    final shape = node.meta['shape'] as String?;
    final relationMeta = node.meta['relations'];
    final relationMap = relationMeta is Map ? relationMeta : const <Object?, Object?>{};
    final rowTex = <String>[];
    for (var row = 0; row < rows; row += 1) {
      if (shape == 'nPreview' && row == 1) {
        rowTex.add(r'\vdots');
        continue;
      }
      final left = node.slots['left_$row'];
      final right = node.slots['right_$row'];
      if (left == null && right == null) continue;
      final relation = _relationToTex(relationMap['row_$row']?.toString() ?? (node.meta['defaultRelation'] as String? ?? '='));
      rowTex.add("${left == null ? r'\Box' : serialize(left)} $relation ${right == null ? r'\Box' : serialize(right)}");
    }
    return '\\begin{cases}${rowTex.join(r' \\ ')}\\end{cases}';
  }

  static String _relationToTex(String relation) {
    switch (relation) {
      case '≤':
        return r'\le';
      case '≥':
        return r'\ge';
      default:
        return relation;
    }
  }

  static String _slot(MathNode node, String key) => serialize(node.slots[key]!);

  static String _serializeSeries(MathNode node) {
    final type = node.meta['type'] as String? ?? 'series';
    switch (type) {
      case 'taylor':
        return 'f(${_slot(node, 'variable')})=\\sum_{${_slot(node, 'index')}=0}^{\\infty}\\frac{f^{(${_slot(node, 'order')})}(${_slot(node, 'center')})}{${_slot(node, 'factorial')}!}(${_slot(node, 'base')}-${_slot(node, 'shift')})^{${_slot(node, 'exponent')}}';
      case 'maclaurin':
        return 'f(${_slot(node, 'variable')})=\\sum_{${_slot(node, 'index')}=0}^{\\infty}\\frac{f^{(${_slot(node, 'order')})}(0)}{${_slot(node, 'factorial')}!}${_slot(node, 'base')}^{${_slot(node, 'exponent')}}';
      case 'geometric':
        return '\\sum_{${_slot(node, 'index')}=0}^{\\infty}${_slot(node, 'coefficient')}\\cdot${_slot(node, 'ratio')}^{${_slot(node, 'exponent')}}=\\frac{${_slot(node, 'numerator')}}{1-${_slot(node, 'denominatorRatio')}}';
      case 'binomial':
        return '(1+${_slot(node, 'variable')})^{${_slot(node, 'parameter')}}=\\sum_{${_slot(node, 'index')}=0}^{\\infty}{${_slot(node, 'chooseTop')}\\choose ${_slot(node, 'chooseBottom')}}${_slot(node, 'base')}^{${_slot(node, 'exponent')}}';
      case 'exp':
        return 'e^{${_slot(node, 'variable')}}=\\sum_{${_slot(node, 'index')}=0}^{\\infty}\\frac{${_slot(node, 'base')}^{${_slot(node, 'exponent')}}}{${_slot(node, 'denominator')}!}';
      case 'sin':
        return '\\sin(${_slot(node, 'variable')})=\\sum_{${_slot(node, 'index')}=0}^{\\infty}\\frac{(-1)^{${_slot(node, 'signIndex')}}\\cdot${_slot(node, 'base')}^{2${_slot(node, 'exponent')}+1}}{(2${_slot(node, 'denominator')}+1)!}';
      case 'cos':
        return '\\cos(${_slot(node, 'variable')})=\\sum_{${_slot(node, 'index')}=0}^{\\infty}\\frac{(-1)^{${_slot(node, 'signIndex')}}\\cdot${_slot(node, 'base')}^{2${_slot(node, 'exponent')}}}{(2${_slot(node, 'denominator')})!}';
      case 'ln':
        return '\\ln(1+${_slot(node, 'variable')})=\\sum_{${_slot(node, 'index')}=1}^{\\infty}\\frac{(-1)^{${_slot(node, 'signIndex')}+1}\\cdot${_slot(node, 'base')}^{${_slot(node, 'exponent')}}}{${_slot(node, 'denominator')}}';
      case 'arctan':
        return '\\arctan(${_slot(node, 'variable')})=\\sum_{${_slot(node, 'index')}=0}^{\\infty}\\frac{(-1)^{${_slot(node, 'signIndex')}}\\cdot${_slot(node, 'base')}^{2${_slot(node, 'exponent')}+1}}{2${_slot(node, 'denominator')}+1}';
      default:
        return r'\sum \Box';
    }
  }

  static String _functionTexName(String name) {
    if (name.contains('∘')) {
      final parts = name.split('∘');
      if (parts.length == 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
        return '\\left(${_serializeText(parts[0])}\\circ ${_serializeText(parts[1])}\\right)';
      }
    }
    switch (name) {
      case 'sin':
      case 'cos':
      case 'tan':
      case 'cot':
      case 'sec':
      case 'csc':
      case 'sinh':
      case 'cosh':
      case 'tanh':
      case 'coth':
      case 'ln':
      case 'log':
        return '\\$name';
      case 'asin':
      case 'sin⁻¹':
        return r'\sin^{-1}';
      case 'acos':
      case 'cos⁻¹':
        return r'\cos^{-1}';
      case 'atan':
      case 'tan⁻¹':
        return r'\tan^{-1}';
      case 'acot':
      case 'cot⁻¹':
        return r'\cot^{-1}';
      case 'asinh':
      case 'sinh⁻¹':
        return r'\sinh^{-1}';
      case 'acosh':
      case 'cosh⁻¹':
        return r'\cosh^{-1}';
      case 'atanh':
      case 'tanh⁻¹':
        return r'\tanh^{-1}';
      case 'log₁₀':
        return r'\log_{10}';
      case 'log₂':
        return r'\log_{2}';
      case 'f':
      case 'g':
      case 'h':
        return name;
      case 'Γ':
        return r'\Gamma';
      case 'EBOB':
      case 'EKOK':
      case 'asal?':
      case 'sign':
      case 'round':
      case 'det':
      case 'rank':
      case 'rref':
      case 'eig':
      case 'solve':
      case 'minor':
      case 'cofactor':
      case 'pinv':
      case 'proj':
      case 'triple':
      case 'unit':
      case 'distance':
      case 'Re':
      case 'Im':
      case 'arg':
      case 'conj':
      case 'cis':
        return '\\operatorname{$name}';
      default:
        return '\\operatorname{$name}';
    }
  }

  static String _serializeNumber(String value) => value;

  static String _serializeSymbol(String value) => _serializeText(value);

  static String _serializeConstant(String value, Map<String, Object?> meta) {
    switch (value) {
      case 'π':
        return r'\pi';
      case 'θ':
        return r'\theta';
      case 'λ':
        return r'\lambda';
      case 'μ':
        return r'\mu';
      case 'φ':
        return r'\varphi';
      case 'ρ':
        return r'\rho';
      case '∞':
        return r'\infty';
      case '+∞':
        return r'+\infty';
      case '−∞':
        return r'-\infty';
      case '−i':
        return '-i';
      case 'rad':
      case 'deg':
        return '\\operatorname{$value}';
      default:
        return _serializeText(value);
    }
  }

  static String _serializeText(String value) {
    var text = value;
    text = text.replaceAll('π', r'\pi');
    text = text.replaceAll('θ', r'\theta');
    text = text.replaceAll('λ', r'\lambda');
    text = text.replaceAll('∞', r'\infty');
    text = text.replaceAll('±', r'\pm');
    text = text.replaceAll('×', r'\times');
    text = text.replaceAll('÷', r'\div');
    text = text.replaceAll('−', '-');
    text = text.replaceAll('·', r'\cdot');
    text = text.replaceAll('%', r'\%');
    text = text.replaceAll('²', r'^{2}');
    text = text.replaceAll('³', r'^{3}');
    text = text.replaceAll('ⁿ', r'^{n}');
    text = text.replaceAll('⁻¹', r'^{-1}');
    text = text.replaceAll('ᵀ', r'^{T}');
    text = text.replaceAll('ᴴ', r'^{H}');
    text = text.replaceAll('√', r'\sqrt{}');
    text = text.replaceAll('⁄', '/');
    return text;
  }
}
