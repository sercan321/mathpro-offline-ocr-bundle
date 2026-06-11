class MathTexSerializer {
  const MathTexSerializer._();

  static String toTex(String source) {
    final value = source.trim();
    if (value.isEmpty) return '';

    var tex = value;
    tex = _replaceKnownTemplates(tex);
    tex = _replaceMatrices(tex);
    tex = _replaceUnicodeAtoms(tex);
    tex = _replaceOperators(tex);
    tex = _replaceFunctions(tex);
    tex = _replacePlaceholders(tex);
    tex = _cleanup(tex);
    return tex;
  }

  static String _atom(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty || normalized == '□') return r'\Box';
    return normalized
        .replaceAll('□', r'\Box')
        .replaceAll('π', r'\pi')
        .replaceAll('θ', r'\theta')
        .replaceAll('λ', r'\lambda')
        .replaceAll('∞', r'\infty');
  }


  static String _stripOuterParens(String value) {
    final trimmed = value.trim();
    if (trimmed.length > 1 && trimmed.startsWith('(') && trimmed.endsWith(')')) {
      return trimmed.substring(1, trimmed.length - 1);
    }
    return trimmed;
  }

  static String _replaceKnownTemplates(String value) {
    var text = value;
    final linkedSeriesTex = _linkedSeriesToTex(text);
    if (linkedSeriesTex != null) return linkedSeriesTex;
    final systemTex = _systemTemplateToTex(text);
    if (systemTex != null) return systemTex;

    text = text.replaceAll('(-b±√(b²-4ac))⁄(2a)', r'\frac{-b\pm\sqrt{b^{2}-4ac}}{2a}');
    // Real-device V129: protect discrete/postfix templates before the
    // generic placeholder and Unicode replacements. Otherwise expressions such
    // as □C□ can drift into invalid MathJax commands like \BoxC\Box.
    text = text.replaceAll('□!', r'{\Box}!');
    text = text.replaceAll('□C□', r'\binom{\Box}{\Box}');
    text = text.replaceAll('□P□', r'{}_{\Box}P_{\Box}');
    text = text.replaceAll('□⁻¹', r'{\Box}^{-1}');
    text = text.replaceAll('□ᵀ', r'{\Box}^{T}');
    text = text.replaceAll('□ᴴ', r'{\Box}^{H}');
    text = text.replaceAll('Γ(□)', r'\Gamma\left(\Box\right)');
    text = text.replaceAllMapped(RegExp(r'\(([A-Za-z])∘([A-Za-z])\)\(([^)]*)\)'), (match) {
      final outer = _atom(match.group(1)!);
      final inner = _atom(match.group(2)!);
      final arg = _atom(match.group(3)!);
      return '\\left($outer\\circ $inner\\right)\\left($arg\\right)';
    });
    text = text.replaceAllMapped(RegExp(r'lim([ₓₙₜ])→([^()]+)\(([^)]*)\)'), (match) {
      const variables = <String, String>{'ₓ': 'x', 'ₙ': 'n', 'ₜ': 't'};
      final variable = variables[match.group(1)!] ?? 'x';
      final target = _atom(match.group(2)!.trim());
      final body = _atom(match.group(3)!);
      return '\\lim_{$variable\\to $target}\\left($body\\right)';
    });

    text = text.replaceAllMapped(RegExp(r'log\(([^)]*)\)\(([^)]*)\)'), (match) {
      final base = _atom(match.group(1)!);
      final arg = _atom(match.group(2)!);
      return '\\log_{$base}\\left($arg\\right)';
    });
    text = text.replaceAllMapped(RegExp(r'log₍([^₎]*)₎\(([^)]*)\)'), (match) {
      final base = _atom(match.group(1)!);
      final arg = _atom(match.group(2)!);
      return '\\log_{$base}\\left($arg\\right)';
    });
    text = text.replaceAllMapped(RegExp(r'log₁₀\(([^)]*)\)'), (match) {
      final arg = _atom(match.group(1)!);
      return '\\log_{10}\\left($arg\\right)';
    });
    text = text.replaceAllMapped(RegExp(r'log₂\(([^)]*)\)'), (match) {
      final arg = _atom(match.group(1)!);
      return '\\log_{2}\\left($arg\\right)';
    });
    text = text.replaceAllMapped(RegExp(r'(\([^()]+\)|[A-Za-z0-9πθλ□]+)⁄(\([^()]+\)|[A-Za-z0-9πθλ□]+)'), (match) {
      final numerator = _atom(_stripOuterParens(match.group(1)!));
      final denominator = _atom(_stripOuterParens(match.group(2)!));
      return '\\frac{$numerator}{$denominator}';
    });
    text = text.replaceAllMapped(RegExp(r'√\(([^()]*)\)'), (match) {
      return '\\sqrt{${_atom(match.group(1)!)}}';
    });
    text = text.replaceAllMapped(RegExp(r'³√\(([^()]*)\)'), (match) {
      return '\\sqrt[3]{${_atom(match.group(1)!)}}';
    });
    text = text.replaceAllMapped(RegExp(r'ⁿ√\(([^()]*)\)'), (match) {
      return '\\sqrt[n]{${_atom(match.group(1)!)}}';
    });
    text = text.replaceAllMapped(RegExp(r'([A-Za-z0-9πθλ□]+)\^\(([^()]*)\)'), (match) {
      return '${_atom(match.group(1)!)}^{${_atom(match.group(2)!)}}';
    });
    text = text.replaceAllMapped(RegExp(r'([A-Za-zπθλ])_([A-Za-z0-9πθλ□]+)'), (match) {
      return '${_atom(match.group(1)!)}_{${_atom(match.group(2)!)}}';
    });
    text = text.replaceAllMapped(RegExp(r'(Σ|Π)_\{([^}]*)\}\^\{([^}]*)\}\(([^)]*)\)'), (match) {
      final op = match.group(1) == 'Π' ? r'\prod' : r'\sum';
      final lower = _atom(match.group(2)!);
      final upper = _atom(match.group(3)!);
      final body = _atom(match.group(4)!);
      return '${op}_{$lower}^{$upper}$body';
    });
    text = text.replaceAllMapped(RegExp(r'lim₍([^→₎]+)→([^₎]*)₎\(([^)]*)\)'), (match) {
      final variable = _atom(match.group(1)!);
      final target = _atom(match.group(2)!.trim());
      final body = _atom(match.group(3)!);
      return '\\lim_{$variable\\to $target}\\left($body\\right)';
    });
    text = text.replaceAllMapped(RegExp(r'∫_\{([^}]*)\}\^\{([^}]*)\}\(([^)]*)\)d([A-Za-z0-9πθλ□]+)'), (match) {
      final lower = _atom(match.group(1)!);
      final upper = _atom(match.group(2)!);
      final body = _atom(match.group(3)!);
      final differential = _atom(match.group(4)!);
      return '\\int_{$lower}^{$upper}{$body}\\,d$differential';
    });
    text = text.replaceAllMapped(RegExp(r'lim_?([A-Za-zπθλ])\s*→\s*([^()]+)\(([^)]*)\)'), (match) {
      final variable = _atom(match.group(1)!);
      final target = _atom(match.group(2)!.trim());
      final body = _atom(match.group(3)!);
      return '\\lim_{$variable\\to $target}\\left($body\\right)';
    });
    text = text.replaceAll('lim₍x→0₎(sin(x)⁄x)', r'\lim_{x\to 0}\frac{\sin\left(x\right)}{x}');
    text = text.replaceAll('(x+y)²', r'(x+y)^{2}');
    text = text.replaceAll('∫₀¹(f(x))dx', r'\int_{0}^{1} f(x)\,dx');
    text = text.replaceAllMapped(RegExp(r'∫₀¹\(([^()]*)\)d([A-Za-z0-9πθλ□]+)'), (match) {
      final body = match.group(1) == '□' ? r'\Box' : match.group(1)!;
      final differential = match.group(2) == '□' ? r'\Box' : match.group(2)!;
      return '\\int_{0}^{1} {$body}\\,d$differential';
    });
    text = text.replaceAllMapped(RegExp(r'∫ₐᵇ\(([^()]*)\)d([A-Za-z0-9πθλ□]+)'), (match) {
      final body = match.group(1) == '□' ? r'\Box' : match.group(1)!;
      final differential = match.group(2) == '□' ? r'\Box' : match.group(2)!;
      return '\\int_{a}^{b} {$body}\\,d$differential';
    });
    text = text.replaceAllMapped(RegExp(r'∫\(([^()]*)\)d([A-Za-z0-9πθλ□]+)'), (match) {
      final body = match.group(1) == '□' ? r'\Box' : match.group(1)!;
      final differential = match.group(2) == '□' ? r'\Box' : match.group(2)!;
      return '\\int {$body}\\,d$differential';
    });
    text = text.replaceAll('∫₀¹(□)dx', r'\int_{0}^{1} \Box\,dx');
    text = text.replaceAll('limₓ→0(sin(x)⁄x)', r'\lim_{x\to 0}\frac{\sin\left(x\right)}{x}');
    text = text.replaceAll('limₓ→0(□)', r'\lim_{x\to 0}\Box');
    text = text.replaceAll('r·e^(iθ)', r'r\cdot e^{i\theta}');
    text = text.replaceAll('Σₙ₌₁ᴺ(aₙ)', r'\sum_{n=1}^{N} a_n');
    text = text.replaceAll('f(□)=Σ□₌₀∞(f⁽□⁾(□)⁄□!)(□-□)^□', r'f(\Box)=\sum_{\Box=0}^{\infty}\frac{f^{(\Box)}(\Box)}{\Box!}(\Box-\Box)^{\Box}');
    text = text.replaceAll('f(□)=Σ□₌₀∞(f⁽□⁾(0)⁄□!)□^□', r'f(\Box)=\sum_{\Box=0}^{\infty}\frac{f^{(\Box)}(0)}{\Box!}\Box^{\Box}');
    text = text.replaceAll('Σ□₌₀∞□·□^□=□⁄(1-□)', r'\sum_{\Box=0}^{\infty}\Box\cdot\Box^{\Box}=\frac{\Box}{1-\Box}');
    text = text.replaceAll('(1+□)^□=Σ□₌₀∞(□C□)□^□', r'(1+\Box)^{\Box}=\sum_{\Box=0}^{\infty}{\Box\choose \Box}\Box^{\Box}');
    text = text.replaceAll('e^□=Σ□₌₀∞□^□⁄□!', r'e^{\Box}=\sum_{\Box=0}^{\infty}\frac{\Box^{\Box}}{\Box!}');
    text = text.replaceAll('sin(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)!', r'\sin(\Box)=\sum_{\Box=0}^{\infty}\frac{(-1)^{\Box}\cdot\Box^{2\Box+1}}{(2\Box+1)!}');
    text = text.replaceAll('cos(□)=Σ□₌₀∞((-1)^□·□^(2□))⁄(2□)!', r'\cos(\Box)=\sum_{\Box=0}^{\infty}\frac{(-1)^{\Box}\cdot\Box^{2\Box}}{(2\Box)!}');
    text = text.replaceAll('ln(1+□)=Σ□₌₁∞((-1)^(□+1)·□^□)⁄□', r'\ln(1+\Box)=\sum_{\Box=1}^{\infty}\frac{(-1)^{\Box+1}\cdot\Box^{\Box}}{\Box}');
    text = text.replaceAll('arctan(□)=Σ□₌₀∞((-1)^□·□^(2□+1))⁄(2□+1)', r'\arctan(\Box)=\sum_{\Box=0}^{\infty}\frac{(-1)^{\Box}\cdot\Box^{2\Box+1}}{2\Box+1}');
    text = text.replaceAll('f(x)=Σₙ₌₀∞(f⁽ⁿ⁾(a)⁄n!)(x-a)ⁿ', r'f(x)=\sum_{n=0}^{\infty}\frac{f^{(n)}(a)}{n!}(x-a)^{n}');
    text = text.replaceAll('f(x)=Σₙ₌₀∞(f⁽ⁿ⁾(0)⁄n!)xⁿ', r'f(x)=\sum_{n=0}^{\infty}\frac{f^{(n)}(0)}{n!}x^{n}');
    text = text.replaceAll('Σₙ₌₀∞arⁿ=a⁄(1-r)', r'\sum_{n=0}^{\infty} ar^{n}=\frac{a}{1-r}');
    text = text.replaceAll('(1+x)^α=Σₙ₌₀∞(αC n)xⁿ', r'(1+x)^{\alpha}=\sum_{n=0}^{\infty}{\alpha\choose n}x^{n}');
    text = text.replaceAll('e^x=Σₙ₌₀∞xⁿ⁄n!', r'e^{x}=\sum_{n=0}^{\infty}\frac{x^{n}}{n!}');
    text = text.replaceAll('sin(x)=Σₙ₌₀∞((-1)ⁿx^(2n+1))⁄(2n+1)!', r'\sin(x)=\sum_{n=0}^{\infty}\frac{(-1)^{n}x^{2n+1}}{(2n+1)!}');
    text = text.replaceAll('cos(x)=Σₙ₌₀∞((-1)ⁿx^(2n))⁄(2n)!', r'\cos(x)=\sum_{n=0}^{\infty}\frac{(-1)^{n}x^{2n}}{(2n)!}');
    text = text.replaceAll('ln(1+x)=Σₙ₌₁∞((-1)ⁿ⁺¹xⁿ)⁄n', r'\ln(1+x)=\sum_{n=1}^{\infty}\frac{(-1)^{n+1}x^{n}}{n}');
    text = text.replaceAll('arctan(x)=Σₙ₌₀∞((-1)ⁿx^(2n+1))⁄(2n+1)', r'\arctan(x)=\sum_{n=0}^{\infty}\frac{(-1)^{n}x^{2n+1}}{2n+1}');
    text = text.replaceAll('{□=□;□=□}', r'\begin{cases}\Box=\Box\\\Box=\Box\end{cases}');
    text = text.replaceAll('{□=□;□=□;□=□}', r'\begin{cases}\Box=\Box\\\Box=\Box\\\Box=\Box\end{cases}');
    text = text.replaceAll('{□≤□;□≤□}', r'\begin{cases}\Box\le\Box\\\Box\le\Box\end{cases}');


    text = text.replaceAll('□⁄□', r'\frac{\Box}{\Box}');
    // Indexed-root templates must be converted before the generic √□ rule;
    // otherwise the inner √□ substring becomes □\sqrt{\Box} and the
    // premium degree placeholder is lost.
    text = text.replaceAll('□√(□)', r'\sqrt[\Box]{\Box}');
    text = text.replaceAll('□√□', r'\sqrt[\Box]{\Box}');
    text = text.replaceAll('ⁿ√(□)', r'\sqrt[n]{\Box}');
    text = text.replaceAll('³√(□)', r'\sqrt[3]{\Box}');
    text = text.replaceAll('³√8', r'\sqrt[3]{8}');
    text = text.replaceAll('∛□', r'\sqrt[3]{\Box}');
    text = text.replaceAll('√(□)', r'\sqrt{\Box}');
    text = text.replaceAll('√□', r'\sqrt{\Box}');
    // Inverse-function display forms must be converted before the generic
    // superscript replacement below; otherwise sin⁻¹(□) becomes sin^{-1}(□)
    // and can no longer match the premium function route.
    text = text.replaceAll('asin(□)', r'\sin^{-1}\left(\Box\right)');
    text = text.replaceAll('acos(□)', r'\cos^{-1}\left(\Box\right)');
    text = text.replaceAll('atan(□)', r'\tan^{-1}\left(\Box\right)');
    text = text.replaceAll('acot(□)', r'\cot^{-1}\left(\Box\right)');
    text = text.replaceAll('asinh(□)', r'\sinh^{-1}\left(\Box\right)');
    text = text.replaceAll('acosh(□)', r'\cosh^{-1}\left(\Box\right)');
    text = text.replaceAll('atanh(□)', r'\tanh^{-1}\left(\Box\right)');
    text = text.replaceAll('sin⁻¹(□)', r'\sin^{-1}\left(\Box\right)');
    text = text.replaceAll('cos⁻¹(□)', r'\cos^{-1}\left(\Box\right)');
    text = text.replaceAll('tan⁻¹(□)', r'\tan^{-1}\left(\Box\right)');
    text = text.replaceAll('cot⁻¹(□)', r'\cot^{-1}\left(\Box\right)');
    text = text.replaceAll('sinh⁻¹(□)', r'\sinh^{-1}\left(\Box\right)');
    text = text.replaceAll('cosh⁻¹(□)', r'\cosh^{-1}\left(\Box\right)');
    text = text.replaceAll('tanh⁻¹(□)', r'\tanh^{-1}\left(\Box\right)');
    text = text.replaceAll('cot(□)', r'\cot\left(\Box\right)');
    text = text.replaceAll('sec(□)', r'\sec\left(\Box\right)');
    text = text.replaceAll('csc(□)', r'\csc\left(\Box\right)');
    text = text.replaceAll('coth(□)', r'\coth\left(\Box\right)');
    text = text.replaceAll('^(□)', r'^{\Box}');
    text = text.replaceAll('²', r'^{2}');
    text = text.replaceAll('³', r'^{3}');
    text = text.replaceAll('ⁿ', r'^{n}');
    text = text.replaceAll('⁻¹', r'^{-1}');
    text = text.replaceAll('′', r"'");
    text = text.replaceAll('″', r"''");
    text = text.replaceAll('‴', r"'''");
    text = text.replaceAll(r'e^(\Box)', r'e^{\Box}');
    text = text.replaceAll(r'10^(\Box)', r'10^{\Box}');
    text = text.replaceAll(r'ln(\Box)', r'\ln\left(\Box\right)');
    text = text.replaceAll(r'log(\Box)', r'\log\left(\Box\right)');
    text = text.replaceAll(r'log_□(\Box)', r'\log_{\Box}\left(\Box\right)');
    text = text.replaceAll(r'log₍□₎(\Box)', r'\log_{\Box}\left(\Box\right)');
    text = text.replaceAll('|□|', r'\left|\Box\right|');
    text = text.replaceAll('⌊□⌋', r'\left\lfloor \Box\right\rfloor');
    text = text.replaceAll('⌈□⌉', r'\left\lceil \Box\right\rceil');
    text = text.replaceAll('‖□‖', r'\left\|\Box\right\|');
    text = text.replaceAll('‖x‖', r'\left\|x\right\|');
    text = text.replaceAll('‖x‖₁', r'\left\|x\right\|_{1}');
    text = text.replaceAll('‖x‖₂', r'\left\|x\right\|_{2}');
    text = text.replaceAll('‖x‖∞', r'\left\|x\right\|_{\infty}');
    text = text.replaceAll('|z|', r'\left|z\right|');
    text = text.replaceAll('‖v‖', r'\left\|v\right\|');

    text = text.replaceAll('∫ₐᵇ(□)dx', r'\int_{a}^{b}\Box\,dx');
    text = text.replaceAll('∫(□)dx', r'\int \Box\,dx');
    text = text.replaceAll('∬(□)', r'\iint \Box');
    text = text.replaceAll('∮(□)', r'\oint \Box');
    text = text.replaceAll('d/dx(□)', r'\frac{d}{dx}\left(\Box\right)');
    text = text.replaceAll('d/dx', r'\frac{d}{dx}');
    text = text.replaceAll('d²/dx²(□)', r'\frac{d^{2}}{dx^{2}}\left(\Box\right)');
    text = text.replaceAll('d²/dx²', r'\frac{d^{2}}{dx^{2}}');
    text = text.replaceAll('d³/dx³(□)', r'\frac{d^{3}}{dx^{3}}\left(\Box\right)');
    text = text.replaceAll('d³/dx³', r'\frac{d^{3}}{dx^{3}}');
    text = text.replaceAll('∂/∂x(□)', r'\frac{\partial}{\partial x}\left(\Box\right)');
    text = text.replaceAll('∂²/∂x²(□)', r'\frac{\partial^{2}}{\partial x^{2}}\left(\Box\right)');
    text = text.replaceAll('∂/∂x', r'\frac{\partial}{\partial x}');
    text = text.replaceAll('dy/dx', r'\frac{dy}{dx}');
    text = text.replaceAll('d²y/dx²', r'\frac{d^{2}y}{dx^{2}}');
    text = text.replaceAll('limₓ→□(□)', r'\lim_{x\to \Box}\left(\Box\right)');
    text = text.replaceAll('limₓ→∞(□)', r'\lim_{x\to\infty}\left(\Box\right)');
    text = text.replaceAll('limₓ→0⁺(□)', r'\lim_{x\to 0^{+}}\left(\Box\right)');
    text = text.replaceAll('limₓ→0⁻(□)', r'\lim_{x\to 0^{-}}\left(\Box\right)');
    text = text.replaceAll('lim(□)', r'\lim \Box');
    text = text.replaceAll('lim x→□', r'\lim_{x\to \Box}');
    text = text.replaceAll('lim x→∞', r'\lim_{x\to\infty}');
    text = text.replaceAll('lim x→0⁺', r'\lim_{x\to 0^{+}}');
    text = text.replaceAll('lim x→0⁻', r'\lim_{x\to 0^{-}}');
    text = text.replaceAll('limₓ→ₐ⁻(□)', r'\lim_{x\to a^-}\Box');
    text = text.replaceAll('limₓ→ₐ⁺(□)', r'\lim_{x\to a^+}\Box');
    text = text.replaceAll('limₓ→ₐ⁻', r'\lim_{x\to a^-}');
    text = text.replaceAll('limₓ→ₐ⁺', r'\lim_{x\to a^+}');
    text = text.replaceAll('limₓ→ₐ', r'\lim_{x\to a}');
    text = text.replaceAll('limₓ→∞', r'\lim_{x\to\infty}');
    text = text.replaceAll('limₙ→∞', r'\lim_{n\to\infty}');
    text = text.replaceAll('Σ(□)', r'\sum \Box');
    text = text.replaceAll('Π(□)', r'\prod \Box');
    text = text.replaceAll('Σᵢ₌₁ⁿ', r'\sum_{i=1}^{n}');
    text = text.replaceAll('Πᵢ₌₁ⁿ', r'\prod_{i=1}^{n}');

    text = text.replaceAll('asin(□)', r'\sin^{-1}\left(\Box\right)');
    text = text.replaceAll('acos(□)', r'\cos^{-1}\left(\Box\right)');
    text = text.replaceAll('atan(□)', r'\tan^{-1}\left(\Box\right)');
    text = text.replaceAll('asinh(□)', r'\sinh^{-1}\left(\Box\right)');
    text = text.replaceAll('acosh(□)', r'\cosh^{-1}\left(\Box\right)');
    text = text.replaceAll('atanh(□)', r'\tanh^{-1}\left(\Box\right)');
    text = text.replaceAll('sin⁻¹(□)', r'\sin^{-1}\left(\Box\right)');
    text = text.replaceAll('cos⁻¹(□)', r'\cos^{-1}\left(\Box\right)');
    text = text.replaceAll('tan⁻¹(□)', r'\tan^{-1}\left(\Box\right)');
    text = text.replaceAll('sinh⁻¹(□)', r'\sinh^{-1}\left(\Box\right)');
    text = text.replaceAll('cosh⁻¹(□)', r'\cosh^{-1}\left(\Box\right)');
    text = text.replaceAll('tanh⁻¹(□)', r'\tanh^{-1}\left(\Box\right)');
    text = text.replaceAll('acot(□)', r'\cot^{-1}\left(\Box\right)');
    text = text.replaceAll('cot⁻¹(□)', r'\cot^{-1}\left(\Box\right)');
    text = text.replaceAll('cot(□)', r'\cot\left(\Box\right)');
    text = text.replaceAll('sec(□)', r'\sec\left(\Box\right)');
    text = text.replaceAll('csc(□)', r'\csc\left(\Box\right)');
    text = text.replaceAll('coth(□)', r'\coth\left(\Box\right)');
    text = text.replaceAll('sin(□)', r'\sin\left(\Box\right)');
    text = text.replaceAll('cos(□)', r'\cos\left(\Box\right)');
    text = text.replaceAll('tan(□)', r'\tan\left(\Box\right)');
    text = text.replaceAll('sinh(□)', r'\sinh\left(\Box\right)');
    text = text.replaceAll('cosh(□)', r'\cosh\left(\Box\right)');
    text = text.replaceAll('tanh(□)', r'\tanh\left(\Box\right)');
    text = text.replaceAll('ln(□)', r'\ln\left(\Box\right)');
    text = text.replaceAll('log(□)', r'\log\left(\Box\right)');
    text = text.replaceAll('log₁₀(□)', r'\log_{10}\left(\Box\right)');
    text = text.replaceAll('log₂(□)', r'\log_{2}\left(\Box\right)');
    text = text.replaceAll('log₍□₎(□)', r'\log_{\Box}\left(\Box\right)');
    text = text.replaceAll('log_□(□)', r'\log_{\Box}\left(\Box\right)');
    text = text.replaceAll('e^(□)', r'e^{\Box}');
    text = text.replaceAll('e^□', r'e^{\Box}');
    text = text.replaceAll('10^□', r'10^{\Box}');
    text = text.replaceAll('e^(i□)', r'e^{i\Box}');

    text = text.replaceAll('Re(□)', r'\operatorname{Re}\left(\Box\right)');
    text = text.replaceAll('Im(□)', r'\operatorname{Im}\left(\Box\right)');
    text = text.replaceAll('arg(□)', r'\arg\left(\Box\right)');
    text = text.replaceAll('conj(□)', r'\overline{\Box}');
    text = text.replaceAll('cis(□)', r'\operatorname{cis}\left(\Box\right)');
    text = text.replaceAll('Re(z)', r'\operatorname{Re}(z)');
    text = text.replaceAll('Im(z)', r'\operatorname{Im}(z)');
    text = text.replaceAll('arg(z)', r'\arg(z)');
    text = text.replaceAll('cis(θ)', r'\operatorname{cis}(\theta)');
    text = text.replaceAll('z̄', r'\overline{z}');
    text = text.replaceAll('z*', r'z^{*}');
    text = text.replaceAll('A⁻¹', r'A^{-1}');
    text = text.replaceAll('Aᵀ', r'A^{T}');
    text = text.replaceAll('B⁻¹', r'B^{-1}');
    text = text.replaceAll('Bᵀ', r'B^{T}');
    text = text.replaceAll('A−λI', r'A-\lambda I');
    text = text.replaceAll('det(A−λI)', r'\det(A-\lambda I)');
    text = text.replaceAll('det(A)', r'\det(A)');
    text = text.replaceAll('λI', r'\lambda I');
    text = text.replaceAll('v̂', r'\hat{v}');

    text = text.replaceAll('x₁', r'x_{1}');
    text = text.replaceAll('x₂', r'x_{2}');
    text = text.replaceAll('xₙ', r'x_{\Box}');
    text = text.replaceAll('x_□', r'x_{\Box}');
    text = text.replaceAll('y₁', r'y_{1}');
    text = text.replaceAll('y₂', r'y_{2}');
    text = text.replaceAll('yₙ', r'y_{\Box}');
    text = text.replaceAll('y_□', r'y_{\Box}');
    text = text.replaceAll('A₁', r'A_{1}');
    text = text.replaceAll('A₂', r'A_{2}');
    text = text.replaceAll('B₁', r'B_{1}');
    text = text.replaceAll('B₂', r'B_{2}');
    text = text.replaceAll('I₂', r'I_{2}');
    text = text.replaceAll('I₃', r'I_{3}');
    text = text.replaceAll('Iₙ', r'I_{\Box}');
    text = text.replaceAll('I_□', r'I_{\Box}');
    text = text.replaceAll('y′', r"y'");
    text = text.replaceAll('y″', r"y''");
    text = text.replaceAll('y‴', r"y'''");
    text = text.replaceAll('y⁽ⁿ⁾', r'y^{(\Box)}');
    text = text.replaceAll('y⁽□⁾', r'y^{(\Box)}');
    // Keep this generic placeholder-parenthesis fallback after all specific
    // function/template replacements. If it runs earlier it converts asin(□)
    // to asin(\Box) and limₓ→□(□) to limₓ→□(\Box), preventing the
    // premium TeX routes from matching.
    text = text.replaceAll('(□)', r'(\Box)');

    return text;
  }


  static String? _systemTemplateToTex(String value) {
    final trimmed = value.trim();
    if (!trimmed.startsWith('{') || !trimmed.endsWith('}')) return null;
    final content = trimmed.substring(1, trimmed.length - 1).trim();
    if (content.isEmpty) return null;
    final rows = content.split(';').map((row) => row.trim()).where((row) => row.isNotEmpty).toList(growable: false);
    if (rows.isEmpty) return null;
    final texRows = <String>[];
    for (final row in rows) {
      if (row == '…' || row == '...') {
        texRows.add(r'\vdots');
        continue;
      }
      final match = RegExp(r'^(.*?)(=|≤|≥|<|>)(.*)$').firstMatch(row);
      if (match == null) return null;
      final left = _atom(match.group(1)!.trim().isEmpty ? '□' : match.group(1)!.trim());
      final right = _atom(match.group(3)!.trim().isEmpty ? '□' : match.group(3)!.trim());
      final relation = _relationToTex(match.group(2)!);
      texRows.add('$left $relation $right');
    }
    return '\\begin{cases}${texRows.join(r' \\ ')}\\end{cases}';
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

  static String? _linkedSeriesToTex(String text) {
    String atom(String value) {
      final normalized = value.trim();
      if (normalized.isEmpty || normalized == '□') return r'\Box';
      return normalized
          .replaceAll('□', r'\Box')
          .replaceAll('α', r'\alpha')
          .replaceAll('θ', r'\theta')
          .replaceAll('λ', r'\lambda')
          .replaceAll('π', r'\pi');
    }

    final taylor = RegExp(r'^f\(([^)]*)\)=Σ([^₌]*)₌₀∞\(f⁽([^⁾]*)⁾\(([^)]*)\)⁄([^!]*)!\)\(([^-)]*)-([^)]*)\)\^(.+)$').firstMatch(text);
    if (taylor != null) {
      final variable = atom(taylor.group(1)!);
      final index = atom(taylor.group(2)!);
      final order = atom(taylor.group(3)!);
      final center = atom(taylor.group(4)!);
      final factorial = atom(taylor.group(5)!);
      final base = atom(taylor.group(6)!);
      final shift = atom(taylor.group(7)!);
      final exponent = atom(taylor.group(8)!);
      return 'f($variable)=\\sum_{$index=0}^{\\infty}\\frac{f^{($order)}($center)}{$factorial!}($base-$shift)^{$exponent}';
    }

    final maclaurin = RegExp(r'^f\(([^)]*)\)=Σ([^₌]*)₌₀∞\(f⁽([^⁾]*)⁾\(0\)⁄([^!]*)!\)(.+)\^(.+)$').firstMatch(text);
    if (maclaurin != null) {
      final variable = atom(maclaurin.group(1)!);
      final index = atom(maclaurin.group(2)!);
      final order = atom(maclaurin.group(3)!);
      final factorial = atom(maclaurin.group(4)!);
      final base = atom(maclaurin.group(5)!);
      final exponent = atom(maclaurin.group(6)!);
      return 'f($variable)=\\sum_{$index=0}^{\\infty}\\frac{f^{($order)}(0)}{$factorial!}$base^{$exponent}';
    }

    final geometric = RegExp(r'^Σ([^₌]*)₌₀∞(.+)·(.+)\^(.+)=(.+)⁄\(1-(.+)\)$').firstMatch(text);
    if (geometric != null) {
      final index = atom(geometric.group(1)!);
      final coefficient = atom(geometric.group(2)!);
      final ratio = atom(geometric.group(3)!);
      final exponent = atom(geometric.group(4)!);
      final numerator = atom(geometric.group(5)!);
      final denominatorRatio = atom(geometric.group(6)!);
      return '\\sum_{$index=0}^{\\infty}$coefficient\\cdot$ratio^{$exponent}=\\frac{$numerator}{1-$denominatorRatio}';
    }

    final binomial = RegExp(r'^\(1\+(.+)\)\^(.+)=Σ([^₌]*)₌₀∞\((.+)C(.+)\)(.+)\^(.+)$').firstMatch(text);
    if (binomial != null) {
      final variable = atom(binomial.group(1)!);
      final parameter = atom(binomial.group(2)!);
      final index = atom(binomial.group(3)!);
      final chooseTop = atom(binomial.group(4)!);
      final chooseBottom = atom(binomial.group(5)!);
      final base = atom(binomial.group(6)!);
      final exponent = atom(binomial.group(7)!);
      return '(1+$variable)^{$parameter}=\\sum_{$index=0}^{\\infty}{$chooseTop\\choose $chooseBottom}$base^{$exponent}';
    }

    final expSeries = RegExp(r'^e\^(.+)=Σ([^₌]*)₌₀∞(.+)\^(.+)⁄(.+)!$').firstMatch(text);
    if (expSeries != null) {
      final variable = atom(expSeries.group(1)!);
      final index = atom(expSeries.group(2)!);
      final base = atom(expSeries.group(3)!);
      final exponent = atom(expSeries.group(4)!);
      final factorial = atom(expSeries.group(5)!);
      return 'e^{$variable}=\\sum_{$index=0}^{\\infty}\\frac{$base^{$exponent}}{$factorial!}';
    }

    final trigSeries = RegExp(r'^(sin|cos|arctan)\(([^)]*)\)=Σ([^₌]*)₌₀∞\(\(-1\)\^(.+)·(.+)\^\(2(.+)(?:\+1)?\)\)⁄\(2(.+)(?:\+1)?\)!?$').firstMatch(text);
    if (trigSeries != null) {
      final fn = trigSeries.group(1)!;
      final variable = atom(trigSeries.group(2)!);
      final index = atom(trigSeries.group(3)!);
      final signPower = atom(trigSeries.group(4)!);
      final base = atom(trigSeries.group(5)!);
      final numeratorIndex = atom(trigSeries.group(6)!);
      final denominatorIndex = atom(trigSeries.group(7)!);
      final odd = fn == 'sin' || fn == 'arctan';
      final exponent = odd ? '2$numeratorIndex+1' : '2$numeratorIndex';
      final denominator = odd ? '2$denominatorIndex+1' : '2$denominatorIndex';
      final denominatorTex = fn == 'arctan' ? denominator : '$denominator!';
      return '\\$fn($variable)=\\sum_{$index=0}^{\\infty}\\frac{(-1)^{$signPower}\\cdot$base^{$exponent}}{$denominatorTex}';
    }

    final lnSeries = RegExp(r'^ln\(1\+([^)]*)\)=Σ([^₌]*)₌₁∞\(\(-1\)\^\((.+)\+1\)·(.+)\^(.+)\)⁄(.+)$').firstMatch(text);
    if (lnSeries != null) {
      final variable = atom(lnSeries.group(1)!);
      final index = atom(lnSeries.group(2)!);
      final signIndex = atom(lnSeries.group(3)!);
      final base = atom(lnSeries.group(4)!);
      final exponent = atom(lnSeries.group(5)!);
      final denominator = atom(lnSeries.group(6)!);
      return '\\ln(1+$variable)=\\sum_{$index=1}^{\\infty}\\frac{(-1)^{$signIndex+1}\\cdot$base^{$exponent}}{$denominator}';
    }

    return null;
  }

  static String _replaceMatrices(String value) {
    var text = value;
    text = text.replaceAll('[□ □ □ □; □ □ □ □; □ □ □ □; □ □ □ □]', r'\begin{bmatrix}\Box & \Box & \Box & \Box \\ \Box & \Box & \Box & \Box \\ \Box & \Box & \Box & \Box \\ \Box & \Box & \Box & \Box\end{bmatrix}');
    text = text.replaceAll('[□ □ □; □ □ □; □ □ □]', r'\begin{bmatrix}\Box & \Box & \Box \\ \Box & \Box & \Box \\ \Box & \Box & \Box\end{bmatrix}');
    text = text.replaceAll('[□ □; □ □]', r'\begin{bmatrix}\Box & \Box \\ \Box & \Box\end{bmatrix}');
    text = text.replaceAll('[□ … □; … ; □ … □]', r'\begin{bmatrix}\Box & \cdots & \Box \\ \vdots & \ddots & \vdots \\ \Box & \cdots & \Box\end{bmatrix}');
    text = text.replaceAll('[□ □ □]·[□ □ □]', r'\begin{bmatrix}\Box & \Box & \Box\end{bmatrix}\cdot\begin{bmatrix}\Box & \Box & \Box\end{bmatrix}');
    text = text.replaceAll('[□; … ; □]', r'\begin{bmatrix}\Box \\ \vdots \\ \Box\end{bmatrix}');
    text = text.replaceAll('[□; □; □]', r'\begin{bmatrix}\Box \\ \Box \\ \Box\end{bmatrix}');
    text = text.replaceAll('[□; □]', r'\begin{bmatrix}\Box \\ \Box\end{bmatrix}');
    text = text.replaceAll('[□ □ □]', r'\begin{bmatrix}\Box & \Box & \Box\end{bmatrix}');
    text = text.replaceAll('[□ □]', r'\begin{bmatrix}\Box & \Box\end{bmatrix}');
    text = text.replaceAll('[x y]', r'\begin{bmatrix}x & y\end{bmatrix}');
    text = text.replaceAll('[x;y]', r'\begin{bmatrix}x \\ y\end{bmatrix}');
    text = text.replaceAll('matrix(□)', r'\begin{bmatrix}\Box & \Box \\ \Box & \Box\end{bmatrix}');
    text = text.replaceAll('vector(□)', r'\begin{bmatrix}\Box \\ \Box\end{bmatrix}');
    return text;
  }

  static String _replaceUnicodeAtoms(String value) {
    var text = value;
    text = text.replaceAll('π', r'\pi');
    text = text.replaceAll('θ', r'\theta');
    text = text.replaceAll('λ', r'\lambda');
    text = text.replaceAll('∞', r'\infty');
    text = text.replaceAll('∂', r'\partial');
    text = text.replaceAll('Σ', r'\sum');
    text = text.replaceAll('Π', r'\prod');
    text = text.replaceAll('∫', r'\int');
    text = text.replaceAll('∬', r'\iint');
    text = text.replaceAll('∮', r'\oint');
    text = text.replaceAll('√', r'\sqrt{}');
    text = text.replaceAll('ᵀ', r'^{T}');
    text = text.replaceAll('ᴴ', r'^{H}');
    text = text.replaceAll('ℜ', r'\Re');
    text = text.replaceAll('ℑ', r'\Im');
    text = text.replaceAll('∠', r'\angle ');
    return text;
  }

  static String _replaceOperators(String value) {
    return value
        .replaceAll('×', r'\times ')
        .replaceAll('÷', r'\div ')
        .replaceAll('−', '-')
        .replaceAll('≤', r'\le ')
        .replaceAll('≥', r'\ge ')
        .replaceAll('≠', r'\ne ')
        .replaceAll('·', r'\cdot ')
        .replaceAll('%', r'\%');
  }

  static String _replaceFunctions(String value) {
    var text = value;
    const functions = <String, String>{
      'sin': r'\sin',
      'cos': r'\cos',
      'tan': r'\tan',
      'cot': r'\cot',
      'sec': r'\sec',
      'csc': r'\csc',
      'sinh': r'\sinh',
      'cosh': r'\cosh',
      'tanh': r'\tanh',
      'coth': r'\coth',
      'ln': r'\ln',
      'log': r'\log',
      'arg': r'\arg',
      'det': r'\det',
    };
    functions.forEach((plain, tex) {
      text = text.replaceAllMapped(RegExp(r'\b' + plain + r'(?=\()'), (_) => tex);
    });
    return text;
  }

  static String _replacePlaceholders(String value) {
    return value.replaceAll('□', r'\Box');
  }

  static String _cleanup(String value) {
    var text = value;
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    text = text.replaceAll(r'\sqrt{}', r'\sqrt{}');
    return text.trim();
  }
}
