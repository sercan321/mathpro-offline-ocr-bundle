import 'dart:math' as math;

class EvaluationResult {
  const EvaluationResult.success(this.value, this.displayValue, {this.semanticType, this.semanticNote}) : unsupportedReason = null;
  const EvaluationResult.symbolic(this.displayValue, {this.semanticType, this.semanticNote})
      : value = null,
        unsupportedReason = null;
  const EvaluationResult.unsupported(this.unsupportedReason, {this.semanticType, this.semanticNote})
      : value = null,
        displayValue = null;

  final double? value;
  final String? displayValue;
  final String? unsupportedReason;
  final String? semanticType;
  final String? semanticNote;

  bool get isSuccess => displayValue != null && unsupportedReason == null;
}

class MathSemanticSummary {
  const MathSemanticSummary({
    required this.kind,
    required this.title,
    required this.description,
    this.normalizedExpression,
    this.resultPreview,
    this.steps = const <String>[],
    this.tags = const <String>[],
    this.isLimitation = false,
  });

  final String kind;
  final String title;
  final String description;
  final String? normalizedExpression;
  final String? resultPreview;
  final List<String> steps;
  final List<String> tags;
  final bool isLimitation;
}

class EvaluatorBridge {
  const EvaluatorBridge._();

  static EvaluationResult evaluateBasic(String expression) {
    final trimmed = expression.trim();
    if (trimmed.isEmpty) return const EvaluationResult.success(0, '0', semanticType: 'empty');

    if (trimmed.contains('□')) {
      return const EvaluationResult.unsupported(
        'Açık slotları doldurmadan değerlendirme yapılmadı.',
        semanticType: 'template',
      );
    }

    final semantic = analyzeSemantic(trimmed);

    final derivative = _trySymbolicDerivative(trimmed);
    if (derivative != null) {
      return EvaluationResult.symbolic(
        derivative,
        semanticType: 'derivative',
        semanticNote: 'Basit polinom türevi sembolik olarak üretildi.',
      );
    }

    final integral = _trySymbolicIntegral(trimmed);
    if (integral != null) {
      return EvaluationResult.symbolic(
        integral,
        semanticType: 'integral',
        semanticNote: 'Basit polinom integrali sembolik olarak üretildi.',
      );
    }

    final ode = _tryClassifyOde(trimmed);
    if (ode != null) {
      return EvaluationResult.symbolic(
        ode,
        semanticType: 'ode',
        semanticNote: 'Diferansiyel denklem sınıflandırıldı; sahte çözüm üretilmedi.',
      );
    }

    if (semantic.kind != 'numeric') {
      return EvaluationResult.unsupported(
        semantic.description,
        semanticType: semantic.kind,
        semanticNote: semantic.title,
      );
    }

    if (!_supportedExpression.hasMatch(trimmed)) {
      return EvaluationResult.unsupported(
        semantic.description,
        semanticType: semantic.kind,
        semanticNote: semantic.title,
      );
    }

    final normalized = _normalizeForNumericEvaluation(trimmed);
    if (normalized.contains('Infinity')) {
      return const EvaluationResult.unsupported(
        'Sonsuzluk sembolü bu temel değerlendiricide yalnızca görsel giriş olarak destekleniyor.',
        semanticType: 'infinite',
      );
    }

    try {
      final parser = _BasicExpressionParser(normalized);
      final value = parser.parse();
      if (value.isNaN || value.isInfinite) {
        return const EvaluationResult.unsupported('Sayısal sonuç sonlu değil.', semanticType: 'numeric');
      }
      return EvaluationResult.success(value, _formatNumber(value), semanticType: 'numeric');
    } on FormatException catch (error) {
      return EvaluationResult.unsupported(error.message, semanticType: 'numeric');
    } catch (_) {
      return const EvaluationResult.unsupported('Bu ifade henüz temel değerlendirici kapsamının dışında.', semanticType: 'unknown');
    }
  }

  static MathSemanticSummary analyzeSemantic(String expression) {
    final trimmed = expression.trim();
    if (trimmed.isEmpty) {
      return const MathSemanticSummary(
        kind: 'empty',
        title: 'İfade bekleniyor',
        description: 'Klavye ile ifade yazıldığında MathPro parser hattı devreye girer.',
      );
    }

    final normalized = _normalizeMathText(trimmed);
    final ode = _odeMetadata(normalized);
    if (ode != null) return ode;

    if (_isDerivativeExpression(normalized)) {
      return MathSemanticSummary(
        kind: 'derivative',
        title: 'Türev ifadesi algılandı',
        description: 'Basit polinom türevlerinde sembolik sonuç üretilir; ileri zincir/ürün/kısmi türevler solver bridge gerektirir.',
        normalizedExpression: normalized,
        tags: const <String>['Türev', 'Kalkülüs', 'Sembolik'],
        steps: const <String>[
          'Türev operatörü ayrıştırılır.',
          'Değişken x kabul edilir.',
          'Basit polinom terimleri için güç kuralı uygulanır.',
        ],
      );
    }

    if (_isIntegralExpression(normalized)) {
      return MathSemanticSummary(
        kind: 'integral',
        title: 'İntegral ifadesi algılandı',
        description: 'Basit polinom integrallerinde sembolik sonuç üretilir; belirli integral ve gelişmiş dönüşümler solver bridge gerektirir.',
        normalizedExpression: normalized,
        tags: const <String>['İntegral', 'Kalkülüs', 'Sembolik'],
        steps: const <String>[
          'İntegral gövdesi ve değişken ayrıştırılır.',
          'Basit polinom terimleri için ters güç kuralı uygulanır.',
          'Belirsiz integralde + C sabiti korunur.',
        ],
      );
    }

    if (_looksLikeMatrix(normalized)) {
      return MathSemanticSummary(
        kind: 'matrix',
        title: 'Matris / vektör yapısı algılandı',
        description: 'Matris ifadesi editör yapısı olarak korunur; determinant, rank, ters ve özdeğer işlemleri ileri lineer cebir motoru gerektirir.',
        normalizedExpression: normalized,
        tags: const <String>['Lineer Cebir', 'Matris', 'Node hazır'],
        isLimitation: true,
      );
    }

    if (_looksLikeEquation(normalized)) {
      final isImplicit = normalized.contains('x') && normalized.contains('y');
      return MathSemanticSummary(
        kind: isImplicit ? 'implicitEquation' : 'equation',
        title: isImplicit ? 'İmplicit denklem algılandı' : 'Denklem algılandı',
        description: isImplicit
            ? 'x ve y içeren denklemler graph/implicit curve bridge için işaretlenir; kapalı form çözüm ileri solver gerektirir.'
            : 'Denklem yapısı korunur; cebirsel çözüm adımları ileri solver bridge ile üretilecek.',
        normalizedExpression: normalized,
        tags: <String>[isImplicit ? 'Implicit' : 'Denklem', 'Cebir'],
        isLimitation: true,
      );
    }

    if (RegExp(r'[xyz]').hasMatch(normalized)) {
      return MathSemanticSummary(
        kind: 'algebraicExpression',
        title: 'Cebirsel ifade algılandı',
        description: 'Değişken içeren ifade parser hattında korunur; grafik uygunluğu ve ileri cebir işlemleri için hazır hale getirilir.',
        normalizedExpression: normalized,
        tags: const <String>['Cebir', 'Değişken', 'Graph-ready'],
        isLimitation: true,
      );
    }

    if (_supportedExpression.hasMatch(trimmed)) {
      return MathSemanticSummary(
        kind: 'numeric',
        title: 'Sayısal aritmetik',
        description: 'Temel sayısal ifade güvenli değerlendirici tarafından hesaplanabilir.',
        normalizedExpression: _normalizeForNumericEvaluation(trimmed),
        tags: const <String>['Temel', 'Sayısal'],
      );
    }

    return MathSemanticSummary(
      kind: 'unsupported',
      title: 'İleri ifade algılandı',
      description: 'Bu ifade MathPro editöründe korunur; gerçek çözüm için ilgili sembolik/nümerik solver bridge gerekir. Sahte çözüm üretilmiyor.',
      normalizedExpression: normalized,
      tags: const <String>['İleri', 'Solver gerekli'],
      isLimitation: true,
    );
  }

  static final RegExp _supportedExpression = RegExp(r'^[0-9+\-*/().%^×÷−πe∞√a-zA-Z\s]+$');

  static String _normalizeForNumericEvaluation(String expression) {
    var normalized = _normalizeMathText(expression);
    normalized = normalized.replaceAll('∞', 'Infinity');
    normalized = _insertImplicitMultiplication(normalized);
    return normalized;
  }

  static String _normalizeMathText(String source) {
    return source
        .replaceAll('−', '-')
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('⁄', '/')
        .replaceAll('²', '^2')
        .replaceAll('³', '^3')
        .replaceAll('⁴', '^4')
        .replaceAll('⁵', '^5')
        .replaceAll('⁶', '^6')
        .replaceAll('⁷', '^7')
        .replaceAll('⁸', '^8')
        .replaceAll('⁹', '^9')
        .replaceAll('⁰', '^0')
        .replaceAll('⁻', '-')
        .replaceAll('₀', '0')
        .replaceAll('₁', '1')
        .replaceAll('₂', '2')
        .replaceAll('₃', '3')
        .replaceAll('₄', '4')
        .replaceAll('₅', '5')
        .replaceAll('₆', '6')
        .replaceAll('₇', '7')
        .replaceAll('₈', '8')
        .replaceAll('₉', '9')
        .replaceAll('π', 'pi')
        .replaceAll('√', 'sqrt')
        .replaceAll('∂', 'partial')
        .replaceAll('∫', 'int')
        .replaceAll(RegExp(r'\s+'), '');
  }

  static String _insertImplicitMultiplication(String source) {
    var value = source;
    value = value.replaceAllMapped(RegExp(r'(\d)(pi|e|sqrt|sin|cos|tan|ln|log|\()'), (m) => '${m[1]}*${m[2]}');
    value = value.replaceAllMapped(RegExp(r'(\))(\d|pi|e|sqrt|sin|cos|tan|ln|log|\()'), (m) => '${m[1]}*${m[2]}');
    return value;
  }

  static String _formatNumber(double value) {
    if ((value - value.roundToDouble()).abs() < 1e-10) {
      return value.round().toString();
    }
    final fixed = value.toStringAsFixed(10);
    return fixed.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }

  static bool _isDerivativeExpression(String normalized) {
    return normalized.startsWith('d/dx') ||
        normalized.startsWith('d^2/dx^2') ||
        normalized.contains('dy/dx') ||
        normalized.contains('partial/') ||
        normalized.contains("y'");
  }

  static bool _isIntegralExpression(String normalized) => normalized.startsWith('int') || normalized.contains('int');
  static bool _looksLikeEquation(String normalized) => normalized.contains('=');
  static bool _looksLikeMatrix(String normalized) => normalized.contains('[') && normalized.contains(']');

  static String? _trySymbolicDerivative(String source) {
    final normalized = _normalizeMathText(source);
    String? body;
    var order = 1;
    final second = RegExp(r'^d\^2/dx\^2\(?(.+?)\)?$').firstMatch(normalized);
    final first = RegExp(r'^d/dx\(?(.+?)\)?$').firstMatch(normalized);
    if (second != null) {
      body = second.group(1);
      order = 2;
    } else if (first != null) {
      body = first.group(1);
    } else {
      return null;
    }
    if (body == null || body.isEmpty) return null;
    var poly = _Polynomial.tryParse(body);
    if (poly == null) return null;
    var resolved = poly;
    for (var i = 0; i < order; i++) {
      resolved = resolved.derivative();
    }
    return resolved.toPrettyString();
  }

  static String? _trySymbolicIntegral(String source) {
    final normalized = _normalizeMathText(source);
    final match = RegExp(r'^int\(?(.+?)\)?d?x$').firstMatch(normalized);
    if (match == null) return null;
    final body = match.group(1);
    if (body == null || body.isEmpty) return null;
    final poly = _Polynomial.tryParse(body);
    if (poly == null) return null;
    return '${poly.integral().toPrettyString()} + C';
  }

  static String? _tryClassifyOde(String source) {
    final summary = _odeMetadata(_normalizeMathText(source));
    if (summary == null) return null;
    final order = summary.tags.firstWhere((tag) => tag.contains('mertebe'), orElse: () => 'ODE');
    final linear = summary.tags.contains('Lineer') ? 'lineer' : 'ileri';
    final hom = summary.tags.contains('Homojen') ? 'homojen' : 'nonhomojen/unknown';
    return 'ODE • $order • $linear • $hom';
  }

  static MathSemanticSummary? _odeMetadata(String normalized) {
    final hasPrime = RegExp(r"y('{1,3})").hasMatch(normalized);
    final hasLeibniz = normalized.contains('dy/dx') || normalized.contains('d^2y/dx^2');
    final hasPde = normalized.contains('partial');
    if (!normalized.contains('=')) return null;
    if (!hasPrime && !hasLeibniz && !hasPde) return null;

    if (hasPde) {
      return MathSemanticSummary(
        kind: 'pde',
        title: 'Kısmi diferansiyel denklem algılandı',
        description: 'PDE yapısı sınıflandırıldı; ileri PDE solver bağlanmadan sahte çözüm üretilmez.',
        normalizedExpression: normalized,
        tags: const <String>['PDE', 'Kısmi türev', 'Solver gerekli'],
        isLimitation: true,
      );
    }

    var order = 1;
    if (normalized.contains("y'''") || normalized.contains('d^3y')) {
      order = 3;
    } else if (normalized.contains("y''") || normalized.contains('d^2y/dx^2')) {
      order = 2;
    }
    final rhs = normalized.contains('=') ? normalized.split('=').last : '';
    final homogeneous = rhs == '0';
    final linear = !RegExp(r'y\^|y\*y|sin\(y\)|cos\(y\)|tan\(y\)').hasMatch(normalized);
    return MathSemanticSummary(
      kind: 'ode',
      title: 'Diferansiyel denklem algılandı',
      description: '$order. mertebe ${linear ? 'lineer' : 'nonlineer/ileri'} ${homogeneous ? 'homojen' : 'nonhomojen'} ODE olarak sınıflandırıldı. Çözüm bridge hazır; sahte kapalı form çözüm üretilmez.',
      normalizedExpression: normalized,
      tags: <String>['ODE', '$order. mertebe', if (linear) 'Lineer', if (homogeneous) 'Homojen'],
      isLimitation: true,
      steps: <String>[
        'Türev notasyonu ayrıştırılır.',
        'Bağımlı değişken y kabul edilir.',
        'En yüksek türevden mertebe $order olarak belirlenir.',
        'Çözüm için ODE solver bridge gerekir.',
      ],
    );
  }
}

class _BasicExpressionParser {
  _BasicExpressionParser(String source) : _source = source.replaceAll(' ', '');

  final String _source;
  int _index = 0;

  double parse() {
    final value = _parseExpression();
    if (_index < _source.length) {
      throw FormatException('Beklenmeyen karakter konumu: $_index.');
    }
    return value;
  }

  double _parseExpression() {
    var value = _parseTerm();
    while (_match('+') || _match('-')) {
      final operator = _source[_index - 1];
      final right = _parseTerm();
      value = operator == '+' ? value + right : value - right;
    }
    return value;
  }

  double _parseTerm() {
    var value = _parsePower();
    while (_match('*') || _match('/')) {
      final operator = _source[_index - 1];
      final right = _parsePower();
      if (operator == '/') {
        if (right == 0) throw const FormatException('Sıfıra bölme yapılamaz.');
        value /= right;
      } else {
        value *= right;
      }
    }
    return value;
  }

  double _parsePower() {
    var value = _parseFactor();
    if (_match('^')) {
      final exponent = _parsePower();
      value = math.pow(value, exponent).toDouble();
    }
    return value;
  }

  double _parseFactor() {
    var value = _parseUnary();
    while (_match('%')) {
      value /= 100;
    }
    return value;
  }

  double _parseUnary() {
    if (_match('+')) return _parseUnary();
    if (_match('-')) return -_parseUnary();
    return _parsePrimary();
  }

  double _parsePrimary() {
    if (_match('(')) {
      final value = _parseExpression();
      if (!_match(')')) throw const FormatException('Kapanış parantezi eksik.');
      return value;
    }
    if (_matchWord('pi')) return math.pi;
    if (_matchWord('e')) return math.e;
    final function = _readFunctionName();
    if (function != null) {
      if (!_match('(')) throw FormatException('$function için açılış parantezi eksik.');
      final argument = _parseExpression();
      if (!_match(')')) throw FormatException('$function için kapanış parantezi eksik.');
      return _applyFunction(function, argument);
    }
    return _parseNumber();
  }

  String? _readFunctionName() {
    const names = <String>['sqrt', 'sin', 'cos', 'tan', 'ln', 'log'];
    for (final name in names) {
      if (_source.startsWith(name, _index)) {
        _index += name.length;
        return name;
      }
    }
    return null;
  }

  double _applyFunction(String name, double argument) {
    switch (name) {
      case 'sqrt':
        if (argument < 0) throw const FormatException('Negatif sayının reel karekökü alınamaz.');
        return math.sqrt(argument);
      case 'sin':
        return math.sin(argument);
      case 'cos':
        return math.cos(argument);
      case 'tan':
        return math.tan(argument);
      case 'ln':
        if (argument <= 0) throw const FormatException('ln için pozitif argüman gerekir.');
        return math.log(argument);
      case 'log':
        if (argument <= 0) throw const FormatException('log için pozitif argüman gerekir.');
        return math.log(argument) / math.ln10;
      default:
        throw FormatException('Desteklenmeyen fonksiyon: $name.');
    }
  }

  double _parseNumber() {
    final start = _index;
    var dotSeen = false;
    while (_index < _source.length) {
      final code = _source.codeUnitAt(_index);
      final isDigit = code >= 48 && code <= 57;
      final isDot = _source[_index] == '.';
      if (isDot) {
        if (dotSeen) break;
        dotSeen = true;
      }
      if (!isDigit && !isDot) break;
      _index++;
    }

    if (start == _index) {
      throw FormatException('Sayı beklenen konum: $start.');
    }

    final number = double.tryParse(_source.substring(start, _index));
    if (number == null) throw FormatException('Geçersiz sayı konumu: $start.');
    return number;
  }

  bool _match(String char) {
    if (_index >= _source.length || _source[_index] != char) return false;
    _index++;
    return true;
  }

  bool _matchWord(String word) {
    if (!_source.startsWith(word, _index)) return false;
    _index += word.length;
    return true;
  }
}

class _PolynomialTerm {
  const _PolynomialTerm(this.power, this.coefficient);
  final int power;
  final double coefficient;
}

class _Polynomial {
  const _Polynomial(this.terms);

  final Map<int, double> terms;

  static _Polynomial? tryParse(String source) {
    var normalized = source.replaceAll(' ', '').replaceAll('*', '');
    if (normalized.isEmpty) return null;
    if (!normalized.startsWith('-') && !normalized.startsWith('+')) normalized = '+$normalized';
    final matches = RegExp(r'([+-])([^+-]+)').allMatches(normalized).toList();
    if (matches.isEmpty) return null;
    final terms = <int, double>{};
    for (final match in matches) {
      final sign = match.group(1) == '-' ? -1.0 : 1.0;
      final raw = match.group(2)!;
      final term = _parseTerm(raw, sign);
      if (term == null) return null;
      terms.update(term.power, (value) => value + term.coefficient, ifAbsent: () => term.coefficient);
    }
    terms.removeWhere((_, value) => value.abs() < 1e-12);
    return _Polynomial(terms);
  }

  static _PolynomialTerm? _parseTerm(String raw, double sign) {
    if (raw.contains('x')) {
      final parts = raw.split('x');
      final coefficientPart = parts.first;
      var coefficient = coefficientPart.isEmpty ? 1.0 : double.tryParse(coefficientPart);
      if (coefficient == null) return null;
      coefficient *= sign;
      var power = 1;
      if (parts.length > 1 && parts[1].startsWith('^')) {
        power = int.tryParse(parts[1].substring(1)) ?? -1;
        if (power < 0) return null;
      }
      return _PolynomialTerm(power, coefficient);
    }
    final constant = double.tryParse(raw);
    if (constant == null) return null;
    return _PolynomialTerm(0, sign * constant);
  }

  _Polynomial derivative() {
    final next = <int, double>{};
    for (final entry in terms.entries) {
      if (entry.key == 0) continue;
      next[entry.key - 1] = (next[entry.key - 1] ?? 0) + entry.value * entry.key;
    }
    return _Polynomial(next);
  }

  _Polynomial integral() {
    final next = <int, double>{};
    for (final entry in terms.entries) {
      final power = entry.key + 1;
      next[power] = (next[power] ?? 0) + entry.value / power;
    }
    return _Polynomial(next);
  }

  String toPrettyString() {
    if (terms.isEmpty) return '0';
    final powers = terms.keys.toList()..sort((a, b) => b.compareTo(a));
    final buffer = StringBuffer();
    for (final power in powers) {
      final coefficient = terms[power]!;
      if (coefficient.abs() < 1e-12) continue;
      final negative = coefficient < 0;
      final abs = coefficient.abs();
      final coeffText = _formatCoefficient(abs, omitOne: power != 0);
      final termText = power == 0 ? _formatCoefficient(abs) : '$coeffText${_powerText(power)}';
      if (buffer.isEmpty) {
        if (negative) buffer.write('-');
        buffer.write(termText);
      } else {
        buffer.write(negative ? ' - ' : ' + ');
        buffer.write(termText);
      }
    }
    return buffer.isEmpty ? '0' : buffer.toString();
  }

  static String _powerText(int power) {
    if (power == 1) return 'x';
    return 'x${_superscript(power)}';
  }

  static String _superscript(int value) {
    const map = <String, String>{'0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴', '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹'};
    return value.toString().split('').map((char) => map[char] ?? char).join();
  }

  static String _formatCoefficient(double value, {bool omitOne = false}) {
    if (omitOne && (value - 1).abs() < 1e-12) return '';
    if ((value - value.roundToDouble()).abs() < 1e-10) return value.round().toString();
    final fixed = value.toStringAsFixed(6).replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
    return fixed;
  }
}
