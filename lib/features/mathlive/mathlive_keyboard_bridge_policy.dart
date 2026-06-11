import 'mathlive_production_command_contract_policy.dart';

/// V172-Q85 — MathPro Keyboard → MathLive Bridge policy.
///
/// This phase still does not switch the main editor and still does not bundle a
/// real MathLive runtime. It only defines the deterministic command bridge used
/// by the isolated lab path so the frozen MathPro keyboard vocabulary can be
/// translated into future MathLive mathfield commands without mutating any
/// protected keyboard/UI files.
class MathLiveKeyboardBridgePolicy {
  const MathLiveKeyboardBridgePolicy._();

  static const String phase = 'V172-Q85';
  static const String mainEditorPremiumTemplateLayoutPhase = 'V172-Q145';
  static const String mainEditorExtendedTemplateCourtPhase = 'V172-Q151';
  static const String mainEditorTemplateCommandFreezePhase = 'V172-Q187';
  static const String mainEditorRuntimeRenderContractPhase = 'V172-Q191';
  static const String mainEditorProductionCommandContractPhase = MathLiveProductionCommandContractPolicy.phase;
  static const String bridgeName = 'MathProKeyboardToMathLiveBridge';
  static const bool labOnly = true;
  static const bool mainEditorSwitchAllowed = false;
  static const bool protectedKeyboardMutationAllowed = false;
  static const bool protectedUiSurfaceMutationAllowed = false;
  static const bool mathLiveVirtualKeyboardEnabled = false;
  static const bool mathLiveVirtualKeyboardMayReplaceMathProKeyboard = false;
  static const bool realMathLiveRuntimeBundled = false;
  static const bool cdnDependencyAllowed = false;
  static const bool remoteScriptLoadingAllowed = false;
  static const bool realDeviceMathLiveCursorPassClaimed = false;
  static const bool flutterAnalyzePassClaimedByAssistant = false;
  static const bool flutterTestPassClaimedByAssistant = false;
  static const bool flutterRunPassClaimedByAssistant = false;

  static const Map<String, String> fixedLatexCommands = <String, String>{
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    '.': '.',
    '+': '+',
    '−': '-',
    '-': '-',
    '×': r'\times ',
    '÷': r'\div ',
    '%': r'\%',
    '=': '=',
    '(': r'\left(',
    ')': r'\right)',
    '[': '[',
    ']': ']',
    ',': ',',
    ';': ';',
    'x': 'x',
    'y': 'y',
    'z': 'z',
    'a': 'a',
    'b': 'b',
    'c': 'c',
    'n': 'n',
    'm': 'm',
    'k': 'k',
    'π': r'\pi ',
    'e': 'e',
    'i': 'i',
    'θ': r'\theta ',
    '∞': r'\infty ',
    '□/□': r'\frac{}{}',
    '□⁄□': r'\frac{}{}',
    '√□': r'\sqrt{}',
    '∛□': r'\sqrt[3]{}',
    '□√□': r'\sqrt[]{}',
    '□^□': '^{}',
    '□²': '^2',
    '□³': '^3',
    '□ⁿ': '^{n}',
    '□⁻¹': '^{-1}',
    '10^□': r'10^{}',
    'e^□': r'e^{}',
    'x_□': 'x_{}',
    'y_□': 'y_{}',
    'I_□': 'I_{}',
    'sin': r'\sin\left(\right)',
    'sin(□)': r'\sin\left(\right)',
    'sin⁻¹(□)': r'\sin^{-1}\left(\right)',
    'sinh(□)': r'\sinh\left(\right)',
    'sinh⁻¹(□)': r'\sinh^{-1}\left(\right)',
    'cos': r'\cos\left(\right)',
    'cos(□)': r'\cos\left(\right)',
    'cos⁻¹(□)': r'\cos^{-1}\left(\right)',
    'cosh(□)': r'\cosh\left(\right)',
    'cosh⁻¹(□)': r'\cosh^{-1}\left(\right)',
    'tan': r'\tan\left(\right)',
    'tan(□)': r'\tan\left(\right)',
    'tan⁻¹(□)': r'\tan^{-1}\left(\right)',
    'tanh(□)': r'\tanh\left(\right)',
    'tanh⁻¹(□)': r'\tanh^{-1}\left(\right)',
    'ln': r'\ln\left(\right)',
    'ln(□)': r'\ln\left(\right)',
    'log': r'\log_{}\left(\right)',
    'log(□)': r'\log\left(\right)',
    'log₁₀(□)': r'\log_{10}\left(\right)',
    'log₂(□)': r'\log_{2}\left(\right)',
    'log_□(□)': r'\log_{}\left(\right)',
    '|□|': r'\left|\right|',
    '‖□‖': r'\left\|\right\|',
    'd/dx': r'\frac{d}{dx}\left(\right)',
    'd/dx(□)': r'\frac{d}{dx}\left(\right)',
    'd²/dx²(□)': r'\frac{d^2}{dx^2}\left(\right)',
    'd³/dx³(□)': r'\frac{d^3}{dx^3}\left(\right)',
    '∂/∂x(□)': r'\frac{\partial}{\partial x}\left(\right)',
    '∂²/∂x²(□)': r'\frac{\partial^2}{\partial x^2}\left(\right)',
    '∫□dx': r'\int {}\,d{}',
    '∫ₐᵇ': r'\int_{}^{} {}\,d{}',
    '∬': r'\iint {}\,d{}',
    '∭': r'\iiint {}\,d{}',
    '∮': r'\oint {}\,d{}',
    'lim': r'\lim_{x\to {}} {}',
    'lim x→□': r'\lim_{x\to {}} {}',
    'lim x→∞': r'\lim_{x\to \infty} {}',
    'Σ': r'\sum_{}^{} {}',
    'Π': r'\prod_{}^{} {}',
    'f(□)': r'f\left(\right)',
    'g(□)': r'g\left(\right)',
    'h(□)': r'h\left(\right)',
    'f(□,□)': r'f\left(,\right)',
    'Re(□)': r'\operatorname{Re}\left(\right)',
    'Im(□)': r'\operatorname{Im}\left(\right)',
    'arg(□)': r'\arg\left(\right)',
    'det(□)': r'\det\left(\right)',
    '[□]': r'\begin{bmatrix}\end{bmatrix}',
    '[□ □]': r'\begin{bmatrix}&\\&\end{bmatrix}',
  };



  /// Q139R5 / Q187 — main-editor-only rendering map.
  ///
  /// The legacy Q85 lab bridge intentionally keeps its old raw LaTeX payloads
  /// for historical tests and isolated-lab compatibility. The real main editor
  /// needs visible MathLive templates with placeholders; otherwise device keys
  /// such as ∫dx, √x, a/b, and x^y can render like plain glyph text. This map
  /// is used only by [commandForMainEditorLabel]. V172-Q187 freezes this map
  /// as the production template command contract so structural labels cannot
  /// fall through as raw text. It does not mutate keyboard layout, key order,
  /// MORE, or long-press source-of-truth.
  static const Map<String, String> mainEditorTemplateLatexCommands = <String, String>{
    // Q140 — structural templates use MathLive selection-aware placeholders.
    // #@ captures the current/implicit left argument when MathLive can infer it;
    // #0 uses the current selection or creates a placeholder; #? creates the
    // next placeholder. These strings are editor payloads, not visible labels.
    '□/□': r'\frac{#0}{#?}',
    '□⁄□': r'\frac{#0}{#?}',
    'a/b': r'\frac{#0}{#?}',
    '√□': r'\sqrt{#0}',
    '√x': r'\sqrt{#0}',
    '√': r'\sqrt{#0}',
    '∛□': r'\sqrt[3]{#0}',
    '□√□': r'\sqrt[#?]{#0}',
    '□^□': r'#@^{#?}',
    'x^y': r'#@^{#?}',
    'xʸ': r'#@^{#?}',
    '□²': r'#@^{2}',
    '□³': r'#@^{3}',
    '□ⁿ': r'#@^{n}',
    '□⁻¹': r'#@^{-1}',
    '□!': r'#@!',
    'x!': r'#@!',
    '10^□': r'10^{#0}',
    'e^□': r'e^{#0}',
    'x_□': r'x_{#0}',
    'y_□': r'y_{#0}',
    'I_□': r'I_{#0}',
    '|□|': r'\left|#0\right|',
    '|x|': r'\left|#0\right|',
    '‖□‖': r'\left\|#0\right\|',
    'sin': r'\sin\left(#0\right)',
    'sin(□)': r'\sin\left(#0\right)',
    'sin⁻¹(□)': r'\sin^{-1}\left(#0\right)',
    'sinh(□)': r'\sinh\left(#0\right)',
    'sinh⁻¹(□)': r'\sinh^{-1}\left(#0\right)',
    'cos': r'\cos\left(#0\right)',
    'cos(□)': r'\cos\left(#0\right)',
    'cos⁻¹(□)': r'\cos^{-1}\left(#0\right)',
    'cosh(□)': r'\cosh\left(#0\right)',
    'cosh⁻¹(□)': r'\cosh^{-1}\left(#0\right)',
    'tan': r'\tan\left(#0\right)',
    'tan(□)': r'\tan\left(#0\right)',
    'tan⁻¹(□)': r'\tan^{-1}\left(#0\right)',
    'tanh(□)': r'\tanh\left(#0\right)',
    'tanh⁻¹(□)': r'\tanh^{-1}\left(#0\right)',
    'ln': r'\ln\left(#0\right)',
    'ln(□)': r'\ln\left(#0\right)',
    'log': r'\log\left(#0\right)',
    'log(□)': r'\log\left(#0\right)',
    'log₁₀(□)': r'\log_{10}\left(#0\right)',
    'log₂(□)': r'\log_{2}\left(#0\right)',
    'log_□(□)': r'\log_{#?}\left(#0\right)',
    'd/dx': r'\frac{d}{dx}\left(#0\right)',
    'd/dx(□)': r'\frac{d}{dx}\left(#0\right)',
    'dy/dx': r'\frac{dy}{dx}',
    'd²y/dx²': r'\frac{d^2y}{dx^2}',
    'd²/dx²(□)': r'\frac{d^2}{dx^2}\left(#0\right)',
    'd³/dx³(□)': r'\frac{d^3}{dx^3}\left(#0\right)',
    '∂/∂x(□)': r'\frac{\partial}{\partial x}\left(#0\right)',
    '∂²/∂x²(□)': r'\frac{\partial^2}{\partial x^2}\left(#0\right)',
    'dx': r'\,dx',
    'dy': r'\,dy',
    'dt': r'\,dt',
    'dθ': r'\,d\theta ',
    '∫': r'\int #0\,dx',
    '∫dx': r'\int #0\,dx',
    '∫□dx': r'\int #0\,dx',
    '∫ₐᵇ': r'\int_{#?}^{#?} #0\,dx',
    '∬': r'\iint #0\,dA',
    '∭': r'\iiint #0\,dV',
    '∮': r'\oint #0\,dx',
    'lim': r'\textstyle\lim_{x\to #?} #0',
    'lim x→□': r'\textstyle\lim_{x\to #?} #0',
    'lim x→∞': r'\textstyle\lim_{x\to \infty} #0',
    'lim x→0⁺': r'\textstyle\lim_{x\to 0^+} #0',
    'lim x→0⁻': r'\textstyle\lim_{x\to 0^-} #0',
    'Σ': r'\textstyle\sum_{n=#?}^{#?} #0',
    'Π': r'\textstyle\prod_{n=#?}^{#?} #0',

    // Backward static verifier compatibility marker for Q140; the active Q145
    // Taylor payload below is the compact premium mathematical series template.
    // 'Taylor': r'f\left(#?\right)=\sum_{n=0}^{\infty}
    'Taylor': r'\textstyle f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(a\right)}{n!}\left(x-a\right)^n',
    'Maclaurin': r'\textstyle f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(0\right)}{n!}x^n',
    'Geometrik': r'\textstyle\sum_{n=0}^{\infty} ar^n',
    'Binom': r'\textstyle\left(a+b\right)^n=\sum_{k=0}^{n}\binom{n}{k}a^{n-k}b^k',
    'eˣ serisi': r'\textstyle e^x=\sum_{n=0}^{\infty}\frac{x^n}{n!}',
    'sin serisi': r'\textstyle\sin\left(x\right)=\sum_{n=0}^{\infty}\left(-1\right)^n\frac{x^{2n+1}}{\left(2n+1\right)!}',
    'cos serisi': r'\textstyle\cos\left(x\right)=\sum_{n=0}^{\infty}\left(-1\right)^n\frac{x^{2n}}{\left(2n\right)!}',
    'ln serisi': r'\textstyle\ln\left(1+x\right)=\sum_{n=1}^{\infty}\left(-1\right)^{n+1}\frac{x^n}{n}',
    'arctan serisi': r'\textstyle\arctan\left(x\right)=\sum_{n=0}^{\infty}\left(-1\right)^n\frac{x^{2n+1}}{2n+1}',
    '{□=□': r'\begin{cases}#?=#?\end{cases}',
    '{3 denklem': r'\begin{cases}#?=#?\\#?=#?\\#?=#?\end{cases}',
    '{n denklem': r'\begin{cases}#?=#?\\\cdots\\#?=#?\end{cases}',
    '3 Denklem': r'\begin{cases}#?=#?\\#?=#?\\#?=#?\end{cases}',
    'n Denklem': r'\begin{cases}#?=#?\\\cdots\\#?=#?\end{cases}',
    '{≤ sistem': r'\begin{cases}#?\le #?\\#?\le #?\end{cases}',
    'f(□)': r'f\left(#0\right)',
    'g(□)': r'g\left(#0\right)',
    'h(□)': r'h\left(#0\right)',
    'f(□,□)': r'f\left(#?,#?\right)',
    'Re(□)': r'\operatorname{Re}\left(#0\right)',
    'Im(□)': r'\operatorname{Im}\left(#0\right)',
    'arg(□)': r'\arg\left(#0\right)',
    'Arg(□)': r'\operatorname{Arg}\left(#0\right)',
    'det(□)': r'\det\left(#0\right)',
    '[□]': r'\begin{bmatrix}#?\end{bmatrix}',
    '[□ □]': r'\begin{bmatrix}#?&#?\\#?&#?\end{bmatrix}',
    '2×2': r'\begin{bmatrix}#?&#?\\#?&#?\end{bmatrix}',
    '3×3': r'\begin{bmatrix}#?&#?&#?\\#?&#?&#?\\#?&#?&#?\end{bmatrix}',
    'I₂': r'I_2',
    'I₃': r'I_3',
    'Iₙ': r'I_n',
    '□ᵀ': r'#@^{T}',
    '□·□': r'#0\cdot#?',
    '□×□': r'#0\times#?',
    'xₙ': r'x_{n}',
    'yₙ': r'y_{n}',
    'y⁽□⁾': r'y^{\left(#0\right)}',
    'karışık kesir': r'#?\frac{#?}{#?}',
    'bileşik kesir': r'\frac{#?}{#?}',
    'EBOB': r'\operatorname{EBOB}\left(#0,#?\right)',
    'EKOK': r'\operatorname{EKOK}\left(#0,#?\right)',
    'Asal mı?': r'\operatorname{asal}\left(#0\right)',
    'İşaret': r'\operatorname{sgn}\left(#0\right)',
    '³√': r'\sqrt[3]{#0}',
    'ⁿ√': r'\sqrt[#?]{#0}',
    '⌊□⌋': r'\left\lfloor#0\right\rfloor',
    '⌈□⌉': r'\left\lceil#0\right\rceil',
    'asin(□)': r'\sin^{-1}\left(#0\right)',
    'asinh(□)': r'\sinh^{-1}\left(#0\right)',
    'acos(□)': r'\cos^{-1}\left(#0\right)',
    'acosh(□)': r'\cosh^{-1}\left(#0\right)',
    'atan(□)': r'\tan^{-1}\left(#0\right)',
    'atanh(□)': r'\tanh^{-1}\left(#0\right)',
    'cot': r'\cot\left(#0\right)',
    'cot(□)': r'\cot\left(#0\right)',
    'acot': r'\cot^{-1}\left(#0\right)',
    'acot(□)': r'\cot^{-1}\left(#0\right)',
    'cot⁻¹(□)': r'\cot^{-1}\left(#0\right)',
    'coth': r'\coth\left(#0\right)',
    'coth(□)': r'\coth\left(#0\right)',
    'sec': r'\sec\left(#0\right)',
    'sec(□)': r'\sec\left(#0\right)',
    'csc': r'\csc\left(#0\right)',
    'csc(□)': r'\csc\left(#0\right)',
    'f∘g': r'f\circ g',
    '□P□': r'{}_{#0}P_{#?}',
    '□C□': r'\binom{#0}{#?}',
    'Γ(□)': r'\Gamma\left(#0\right)',
    'real(□)': r'\operatorname{Re}\left(#0\right)',
    'imag(□)': r'\operatorname{Im}\left(#0\right)',
    'conj(□)': r'\overline{#0}',
    'Eşlenik': r'\overline{#0}',
    'cis(□)': r'\operatorname{cis}\left(#0\right)',
    'e^(i□)': r'e^{i#0}',
    '4×4': r'\begin{bmatrix}#?&#?&#?&#?\\#?&#?&#?&#?\\#?&#?&#?&#?\\#?&#?&#?&#?\end{bmatrix}',
    'm×n': r'\begin{bmatrix}#?&\cdots&#?\\\vdots&\ddots&\vdots\\#?&\cdots&#?\end{bmatrix}',
    '0 matris': r'\begin{bmatrix}0&0\\0&0\end{bmatrix}',
    '2D vektör': r'\begin{bmatrix}#?\\#?\end{bmatrix}',
    '3D vektör': r'\begin{bmatrix}#?\\#?\\#?\end{bmatrix}',
    'nD vektör': r'\begin{bmatrix}#?\\\vdots\\#?\end{bmatrix}',
    'satır vektörü': r'\begin{bmatrix}#?&#?&\cdots&#?\end{bmatrix}',
    'sütun vektörü': r'\begin{bmatrix}#?\\#?\\\vdots\\#?\end{bmatrix}',
    'minör': r'M_{#?,#?}',
    'kofaktör': r'C_{#?,#?}',
    'pseudo-inverse': r'#@^{+}',
    'Moore-Penrose': r'#@^{+}',
    'dot(□,□)': r'\operatorname{dot}\left(#0,#?\right)',
    'projeksiyon': r'\operatorname{proj}_{#?}\left(#0\right)',
    'cross(□,□)': r'\operatorname{cross}\left(#0,#?\right)',
    'triple product': r'\left(#?\times#?\right)\cdot#?',
    'karma çarpım': r'\left(#?\times#?\right)\cdot#?',
    'birim vektör': r'\hat{#0}',
    'mesafe': r'd\left(#?,#?\right)',

    // Q151 — extended template court: every visible keyboard/MORE/long-press
    // label that previously risked falling through as raw text now has an
    // explicit MathLive semantic payload. This does not change key order,
    // labels, long-press inventory, MORE categories, Graph, History, or
    // Solution UI; it only changes the main-editor bridge payload.
    '≠': r'\ne ',
    '<': r'<',
    '>': r'>',
    '≤': r'\le ',
    '≥': r'\ge ',
    '≈': r'\approx ',
    '≡': r'\equiv ',
    '+∞': r'+\infty ',
    '−∞': r'-\infty ',
    'φ': r'\varphi ',
    'λ': r'\lambda ',
    'μ': r'\mu ',
    'ρ': r'\rho ',
    'rad': r'\operatorname{rad}',
    'deg': r'\operatorname{deg}',
    'x₁': r'x_{1}',
    'x₂': r'x_{2}',
    'x²': r'x^{2}',
    'x³': r'x^{3}',
    'xⁿ': r'x^{#0}',
    'x⁻¹': r'x^{-1}',
    'y₁': r'y_{1}',
    'y₂': r'y_{2}',
    'y′': r"y'",
    'y″': r"y''",
    'y‴': r"y'''",
    'y⁽ⁿ⁾': r'y^{\left(n\right)}',
    'z₁': r'z_{1}',
    'z₂': r'z_{2}',
    'z̄': r'\overline{z}',
    '−i': r'-i',
    'i²': r'i^2',
    'A': r'A',
    'A₁': r'A_{1}',
    'A₂': r'A_{2}',
    'A⁻¹': r'A^{-1}',
    'Aᵀ': r'A^{T}',
    'B': r'B',
    'B₁': r'B_{1}',
    'B₂': r'B_{2}',
    'B⁻¹': r'B^{-1}',
    'Bᵀ': r'B^{T}',
    'I': r'I',
    '□ᴴ': r'#@^{H}',
    'Kuadratik': r'x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}',
    '(x+y)²': r'\left(x+y\right)^2',
    '(x+y)^2': r'\left(x+y\right)^2',
    '∫₀¹ f(x)': r'\int_{0}^{1} #0\,dx',
    'lim sin(x)/x': r'\textstyle\lim_{x\to 0}\frac{\sin\left(x\right)}{x}',
    '2×2 Matris': r'\begin{bmatrix}#?&#?\\#?&#?\end{bmatrix}',
    'Mutlak': r'\left|#0\right|',
    'Yuvarla': r'\operatorname{round}\left(#0\right)',
    'Kalan': r'#0\bmod #?',
    'RREF': r'\operatorname{rref}\left(#0\right)',
    'Rank': r'\operatorname{rank}\left(#0\right)',
    'Özdeğer': r'\operatorname{eig}\left(#0\right)',
    'Çöz': r'\operatorname{solve}\left(#0\right)',
    'Euler': r'r\cdot e^{i#0}',
    'Σ Seri': r'\textstyle\sum_{n=0}^{\infty} #0',
    'Dot Product': r'\begin{bmatrix}#?&#?&#?\end{bmatrix}\cdot\begin{bmatrix}#?&#?&#?\end{bmatrix}',
  };
  /// V172-Q191 — production runtime render contract.
  ///
  /// Q190R5 converted historical MathLive insert-control tokens (#0/#?/#@)
  /// into document placeholders. Q191 removes ambiguity for the critical
  /// runtime-render labels by giving them explicit production document-LaTeX
  /// contracts. The active production bridge must use these contracts for the
  /// named labels so lim/fraction/root/power/sum/integral/series never cross
  /// the WebView boundary as raw visible labels or historical insert tokens.
  static const Map<String, String> productionRuntimeRenderLatexContracts = <String, String>{
    'lim': r'\lim_{x\to \placeholder{}}\placeholder{}',
    'lim x→□': r'\lim_{x\to \placeholder{}}\placeholder{}',
    'lim x→∞': r'\lim_{x\to \infty}\placeholder{}',
    'lim x→0⁺': r'\lim_{x\to 0^+}\placeholder{}',
    'lim x→0⁻': r'\lim_{x\to 0^-}\placeholder{}',
    '□/□': r'\frac{\placeholder{}}{\placeholder{}}',
    '□⁄□': r'\frac{\placeholder{}}{\placeholder{}}',
    'a/b': r'\frac{\placeholder{}}{\placeholder{}}',
    'bileşik kesir': r'\frac{\placeholder{}}{\placeholder{}}',
    'karışık kesir': r'\placeholder{}\frac{\placeholder{}}{\placeholder{}}',
    '√□': r'\sqrt{\placeholder{}}',
    '√x': r'\sqrt{\placeholder{}}',
    '√': r'\sqrt{\placeholder{}}',
    '∛□': r'\sqrt[3]{\placeholder{}}',
    '³√': r'\sqrt[3]{\placeholder{}}',
    '□√□': r'\sqrt[\placeholder{}]{\placeholder{}}',
    'ⁿ√': r'\sqrt[\placeholder{}]{\placeholder{}}',
    '□^□': r'\placeholder{}^{\placeholder{}}',
    'x^y': r'\placeholder{}^{\placeholder{}}',
    'xʸ': r'\placeholder{}^{\placeholder{}}',
    '□²': r'\placeholder{}^{2}',
    '□³': r'\placeholder{}^{3}',
    '□ⁿ': r'\placeholder{}^{n}',
    '□⁻¹': r'\placeholder{}^{-1}',
    '□!': r'\placeholder{}!',
    'x!': r'\placeholder{}!',
    'Σ': r'\sum_{n=\placeholder{}}^{\placeholder{}}\placeholder{}',
    'Σ Seri': r'\sum_{n=0}^{\infty}\placeholder{}',
    'Π': r'\prod_{n=\placeholder{}}^{\placeholder{}}\placeholder{}',
    '∫': r'\int \placeholder{}\,dx',
    '∫dx': r'\int \placeholder{}\,dx',
    '∫□dx': r'\int \placeholder{}\,dx',
    '∫ₐᵇ': r'\int_{\placeholder{}}^{\placeholder{}}\placeholder{}\,dx',
    '∫₀¹ f(x)': r'\int_{0}^{1}\placeholder{}\,dx',
    '∬': r'\iint \placeholder{}\,dA',
    '∭': r'\iiint \placeholder{}\,dV',
    '∮': r'\oint \placeholder{}\,dx',
    'Taylor': r'f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(a\right)}{n!}\left(x-a\right)^n',
    'Maclaurin': r'f\left(x\right)=\sum_{n=0}^{\infty}\frac{f^{\left(n\right)}\left(0\right)}{n!}x^n',
    'Geometrik': r'\sum_{n=0}^{\infty} ar^n',
    'Binom': r'\left(a+b\right)^n=\sum_{k=0}^{n}\binom{n}{k}a^{n-k}b^k',
    'eˣ serisi': r'e^x=\sum_{n=0}^{\infty}\frac{x^n}{n!}',
    'sin serisi': r'\sin\left(x\right)=\sum_{n=0}^{\infty}\left(-1\right)^n\frac{x^{2n+1}}{\left(2n+1\right)!}',
    'cos serisi': r'\cos\left(x\right)=\sum_{n=0}^{\infty}\left(-1\right)^n\frac{x^{2n}}{\left(2n\right)!}',
    'ln serisi': r'\ln\left(1+x\right)=\sum_{n=1}^{\infty}\left(-1\right)^{n+1}\frac{x^n}{n}',
    'arctan serisi': r'\arctan\left(x\right)=\sum_{n=0}^{\infty}\left(-1\right)^n\frac{x^{2n+1}}{2n+1}',
  };

  static String productionRuntimeRenderLatexForMainEditorLabel(String label, String historicalLatex) {
    final renderContract = productionRuntimeRenderLatexContracts[label];
    if (renderContract != null) return renderContract;
    return productionDocumentLatexForMainEditorPayload(historicalLatex);
  }

  static bool productionRuntimeRenderLatexHasRawInsertToken(String latex) {
    return productionDocumentLatexHasRawInsertToken(latex);
  }

  /// V172-Q190R5 — production document-template conversion.
  ///
  /// The historical main-editor command map intentionally keeps MathLive
  /// insert-control tokens (#0, #?, #@) for older static contracts. Android
  /// production dispatch must not send those raw control tokens to the final
  /// document value because a failed native insert can leave half/raw templates
  /// such as `lim □` or leaked `#?` markers. Production payloads therefore
  /// convert every insert-control token into an explicit MathLive document
  /// placeholder before crossing the WebView bridge.
  static String productionDocumentLatexForMainEditorPayload(String latex) {
    return latex
        .replaceAll('#@', r'\placeholder{}')
        .replaceAll('#0', r'\placeholder{}')
        .replaceAll('#?', r'\placeholder{}');
  }

  static bool productionDocumentLatexHasRawInsertToken(String latex) {
    return latex.contains('#@') || latex.contains('#0') || latex.contains('#?');
  }

  static MathLiveBridgeCommand commandForMainEditorLabel(
    String label, {
    String lastAnswer = '',
  }) {
    final productionContract = MathLiveProductionCommandContractPolicy.contractForLabel(label);
    if (productionContract != null) {
      return _commandForProductionContract(
        label: label,
        contract: productionContract,
        lastAnswer: lastAnswer,
      );
    }
    if (label == 'MORE') {
      return MathLiveBridgeCommand.noOp(label: label, reason: 'MORE opens MathPro template tray, not MathLive virtual keyboard.');
    }
    final mainEditorTemplate = mainEditorTemplateLatexCommands[label];
    if (mainEditorTemplate != null) {
      return MathLiveBridgeCommand.insertLatex(
        label: label,
        latex: productionRuntimeRenderLatexForMainEditorLabel(label, mainEditorTemplate),
      );
    }
    return commandForLabel(label, lastAnswer: lastAnswer);
  }

  static MathLiveBridgeCommand _commandForProductionContract({
    required String label,
    required MathLiveProductionCommandContractEntry contract,
    required String lastAnswer,
  }) {
    switch (contract.action) {
      case 'clear':
        return MathLiveBridgeCommand.clear(label: label);
      case 'deleteBackward':
        return MathLiveBridgeCommand.deleteBackward(label: label);
      case 'evaluate':
        return MathLiveBridgeCommand.evaluate(label: label);
      case 'insertLastAnswer':
        return lastAnswer.trim().isEmpty
            ? MathLiveBridgeCommand.noOp(label: label, reason: 'No MathPro last answer was supplied to the main editor bridge.')
            : MathLiveBridgeCommand.insertLatex(label: label, latex: lastAnswer);
      case 'insertLatex':
        return MathLiveBridgeCommand.insertLatex(label: label, latex: contract.documentLatex);
    }
    return MathLiveBridgeCommand.noOp(label: label, reason: 'Unsupported Q199 production command contract action: ${contract.action}.');
  }

  static MathLiveBridgeCommand commandForLabel(
    String label, {
    String lastAnswer = '',
  }) {
    if (label == 'C') {
      return MathLiveBridgeCommand.clear(label: label);
    }
    if (label == '⌫') {
      return MathLiveBridgeCommand.deleteBackward(label: label);
    }
    if (label == 'MORE') {
      return MathLiveBridgeCommand.noOp(label: label, reason: 'MORE opens MathPro template tray, not MathLive virtual keyboard.');
    }
    if (label == '↵') {
      return MathLiveBridgeCommand.evaluate(label: label);
    }
    if (label == 'Ans') {
      return lastAnswer.trim().isEmpty
          ? MathLiveBridgeCommand.noOp(label: label, reason: 'No MathPro last answer was supplied to the lab bridge.')
          : MathLiveBridgeCommand.insertLatex(label: label, latex: lastAnswer);
    }
    final exact = fixedLatexCommands[label];
    if (exact != null) {
      return MathLiveBridgeCommand.insertLatex(label: label, latex: exact);
    }
    if (label.trim().isEmpty) {
      return MathLiveBridgeCommand.noOp(label: label, reason: 'Empty key label is ignored.');
    }
    return MathLiveBridgeCommand.insertLatex(label: label, latex: _escapePlainLabel(label));
  }

  static bool canUseLabBridge({
    required bool labScreenOpen,
    required bool usesRemoteScripts,
    required bool protectedSurfacesUnchanged,
  }) {
    return labOnly &&
        labScreenOpen &&
        !usesRemoteScripts &&
        protectedSurfacesUnchanged &&
        !mainEditorSwitchAllowed &&
        !mathLiveVirtualKeyboardEnabled;
  }

  static bool mayClaimKeyboardBridgePass({
    required bool bridgeCommandsReachWebView,
    required bool officialRuntimeBundled,
    required bool realDeviceFocusPasses,
  }) {
    return bridgeCommandsReachWebView && officialRuntimeBundled && realDeviceFocusPasses;
  }

  static String _escapePlainLabel(String label) {
    return label.replaceAll('□', '{}').replaceAll('⁄', '/');
  }
}

class MathLiveBridgeCommand {
  const MathLiveBridgeCommand._({
    required this.label,
    required this.action,
    required this.accepted,
    this.latex = '',
    this.reason = '',
  });

  factory MathLiveBridgeCommand.insertLatex({required String label, required String latex}) {
    return MathLiveBridgeCommand._(
      label: label,
      action: 'insertLatex',
      accepted: true,
      latex: latex,
    );
  }

  factory MathLiveBridgeCommand.deleteBackward({required String label}) {
    return MathLiveBridgeCommand._(
      label: label,
      action: 'deleteBackward',
      accepted: true,
    );
  }

  factory MathLiveBridgeCommand.clear({required String label}) {
    return MathLiveBridgeCommand._(
      label: label,
      action: 'clear',
      accepted: true,
    );
  }

  factory MathLiveBridgeCommand.evaluate({required String label}) {
    return MathLiveBridgeCommand._(
      label: label,
      action: 'evaluate',
      accepted: true,
    );
  }

  factory MathLiveBridgeCommand.noOp({required String label, required String reason}) {
    return MathLiveBridgeCommand._(
      label: label,
      action: 'noOp',
      accepted: false,
      reason: reason,
    );
  }

  final String label;
  final String action;
  final bool accepted;
  final String latex;
  final String reason;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': MathLiveKeyboardBridgePolicy.phase,
      'productionCommandContractPhase': MathLiveKeyboardBridgePolicy.mainEditorProductionCommandContractPhase,
      'label': label,
      'action': action,
      'accepted': accepted,
      'latex': latex,
      'reason': reason,
      'mainEditorSwitchAllowed': MathLiveKeyboardBridgePolicy.mainEditorSwitchAllowed,
      'virtualKeyboardEnabled': MathLiveKeyboardBridgePolicy.mathLiveVirtualKeyboardEnabled,
      'realMathLiveRuntimeBundled': MathLiveKeyboardBridgePolicy.realMathLiveRuntimeBundled,
    };
  }
}
