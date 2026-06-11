/// Real-device manual acceptance contract for MathPro Core Editor Engine.
///
/// This file does not mark the app as manually tested. It defines the exact
/// evidence gate that must be satisfied on a physical Android device before a
/// human can call the slot interaction work PASS. Keeping it in code makes the
/// 9/10 target testable and prevents silent drift in future phases.
class RealDeviceSlotTestProtocol {
  const RealDeviceSlotTestProtocol._();

  static const String version = 'mathpro-v65-real-device-interaction-lock-protocol';
  static const int attemptsPerScenario = 10;
  static const int minimumCorrectPerScenario = 9;
  static const double minimumOverallSuccessRate = 0.90;
  static const String targetDeviceId = '23106RN0DA';

  static const List<String> requiredFlutterCommands = <String>[
    'flutter pub get',
    'flutter analyze',
    'flutter test',
    'flutter run -d 23106RN0DA',
  ];

  static const List<String> forbiddenPassClaimsWithoutEvidence = <String>[
    'PASS',
    'final PASS',
    'Photomath-level verified',
    'real-device verified',
  ];

  static const List<ManualSlotScenario> scenarios = <ManualSlotScenario>[

    ManualSlotScenario(
      id: 'function-argument-direct',
      title: 'tan/sin/cos fonksiyon argüman kutusu seçimi',
      expression: 'tan(□)',
      expectedSlotRole: 'functionArgument',
      steps: <String>[
        'Kalkülüs veya Cebir sekmesinde tan() template seç.',
        'tan içindeki kutunun merkezine, soluna, sağına ve alt/üst kenarlarına toplam 10 kez dokun.',
        'Aynı testi sin(□), cos(□) ve ln(□) ile tekrarla.',
      ],
      acceptance: 'Her fonksiyon argüman kutusunda en az 9/10 dokunuş functionArgument slotunu seçmeli; linear caret fallback slot seçiminin yerine geçmemeli.',
    ),
    ManualSlotScenario(
      id: 'sqrt-slot-direct',
      title: '√ iç slot doğrudan seçim',
      expression: '√(□)',
      expectedSlotRole: 'sqrtValue',
      steps: <String>[
        'Cebir sekmesini aç.',
        '√ template tuşuna bas.',
        'Kök içindeki slotun farklı noktalarına 10 kez dokun.',
      ],
      acceptance: 'En az 9/10 dokunuş sqrt.value slotunu seçmeli; kullanıcı teknik slot adı görmemeli.',
    ),
    ManualSlotScenario(
      id: 'fraction-numerator-denominator',
      title: 'Kesir pay/payda ayrımı',
      expression: '□⁄□',
      expectedSlotRole: 'fractionNumerator/fractionDenominator',
      steps: <String>[
        'Cebir sekmesinde kesir template tuşuna bas.',
        'Pay alanına 10 kez farklı noktalardan dokun.',
        'Payda alanına 10 kez farklı noktalardan dokun.',
      ],
      acceptance: 'Pay ve payda ayrı ayrı en az 9/10 doğru seçilmeli; birbirine karışmamalı.',
    ),
    ManualSlotScenario(
      id: 'power-exponent',
      title: 'Üs slotu seçimi',
      expression: '□^(□)',
      expectedSlotRole: 'powerExponent',
      steps: <String>[
        'Cebir sekmesinde ^ template tuşuna bas.',
        'Üs slotuna 10 kez farklı noktalardan dokun.',
      ],
      acceptance: 'En az 9/10 dokunuş exponent slotunu seçmeli; base slotu yanlışlıkla seçilmemeli.',
    ),
    ManualSlotScenario(
      id: 'editable-integral-limits-body',
      title: 'İntegral alt/üst/body/differential ayrımı',
      expression: '∫_{□}^{□}(□)d□',
      expectedSlotRole: 'integralLowerLimit/integralUpperLimit/integralBody/integralDifferential',
      steps: <String>[
        'Kalkülüs sekmesinde ∫ₐᵇ template seç.',
        'Alt limit slotuna 10 kez dokun.',
        'Üst limit slotuna 10 kez dokun.',
        'Body slotuna 10 kez dokun.',
        'Differential slotuna 10 kez dokun.',
      ],
      acceptance: 'Her integral slotu kendi bölgesinde en az 9/10 doğru seçilmeli; body limitleri çalmamalı.',
    ),
    ManualSlotScenario(
      id: 'nested-sqrt-depth-priority',
      title: 'İç içe kökte en iç slot seçimi',
      expression: '√(√(√(□)))',
      expectedSlotRole: 'deepest sqrtValue',
      steps: <String>[
        'Üç seviyeli iç içe kök oluştur.',
        'En iç placeholder çevresine 10 kez dokun.',
        'Dış kök çizgisine yakın alanları da ayrıca dene.',
      ],
      acceptance: 'En iç slota yakın dokunuşlarda en az 9/10 en iç slot seçilmeli; dış slot yanlışlıkla baskın olmamalı.',
    ),
    ManualSlotScenario(
      id: 'pan-zoom-hit-sync',
      title: 'Pan/zoom sonrası hit-test senkronu',
      expression: '√(□) + □⁄□ + ∫_{□}^{□}(□)d□',
      expectedSlotRole: 'selected visible slot after inverse transform',
      steps: <String>[
        'Uzun bir ifade oluştur.',
        'Pinch zoom ile ifadeyi büyüt.',
        'Pan ile ifadeyi sağa/sola kaydır.',
        'Kök, kesir ve integral slotlarına 10 kez dokun.',
      ],
      acceptance: 'Pan/zoom sonrası slotlar kaymamalı; her slot grubu için en az 9/10 doğru seçim alınmalı.',
    ),

    ManualSlotScenario(
      id: 'linear-caret-navigation-direct',
      title: 'Dolu ifadede cursor/caret gezdirme',
      expression: 'tan(cos(ln(9)))',
      expectedSlotRole: 'linear caret insertion point',
      steps: <String>[
        'tan(cos(ln(9))) ifadesini oluştur veya yaz.',
        'tan ile cos arasına, cos ile ln arasına, ln ile 9 arasına, son parantez önüne ve ifade sonuna toplam 10 kez dokun.',
        'Her dokunuştan sonra ince mavi cursor çizgisinin tıklanan mantıklı insertion point çevresine gittiğini kontrol et.',
      ],
      acceptance: 'En az 9/10 dokunuşta cursor tıklanan mantıklı insertion point çevresine gitmeli; cursor yazı baseline altında sarkmamalı.',
    ),

    ManualSlotScenario(
      id: 'raw-equation-four-placeholders',
      title: 'Ham denklemde 4 ayrı □ kutusunun tek dokunuşla seçimi',
      expression: '9□ = □; □ = □',
      expectedSlotRole: 'placeholder sequence 1/2/3/4',
      steps: <String>[
        'Cebir sekmesinde veya template akışıyla 9□ = □; □ = □ ifadesini oluştur.',
        'Birinci, ikinci, üçüncü ve dördüncü kutuya ayrı ayrı 10 kez dokun.',
        'Her denemede aktif focus ringin dokunulan kutuda kaldığını ve yazının o kutuya girdiğini kontrol et.',
      ],
      acceptance: 'Her kutu kendi sırasında en az 9/10 doğru seçilmeli; yakın kutular veya linear caret dokunuşu çalmamalı.',
    ),
    ManualSlotScenario(
      id: 'partially-filled-derivative-slot',
      title: 'd/dx(88□) içinde kısmen dolu fonksiyon argüman slotu',
      expression: 'd/dx(88□)',
      expectedSlotRole: 'functionArgument',
      steps: <String>[
        'Kalkülüs sekmesinde d/dx(□) template oluştur ve içine 88 yaz.',
        'Kalan kutunun merkezine, soluna, sağına ve alt/üst çevresine 10 kez dokun.',
        'Focus ringin d/dx içindeki argüman kutusunda kaldığını kontrol et.',
      ],
      acceptance: 'En az 9/10 dokunuş functionArgument slotunu seçmeli; ifade düz text caret moduna düşmemeli.',
    ),
    ManualSlotScenario(
      id: 'plain-8955-caret-midpoints',
      title: '8955 düz ifadede karakter arası cursor hassasiyeti',
      expression: '8955',
      expectedSlotRole: 'linear caret insertion point',
      steps: <String>[
        'Temel sekmede 8955 yaz.',
        'Cursoru 8|955, 89|55, 895|5 ve 8955| konumlarına 10 deneme içinde taşı.',
        'Cursorun yazının üstünde/altında kopuk değil, sayı hattıyla aynı optik merkezde durduğunu kontrol et.',
      ],
      acceptance: 'En az 9/10 dokunuş istenen karakter aralığına gitmeli; cursor baseline/center hizası bozulmamalı.',
    ),
    ManualSlotScenario(
      id: 'template-auto-advance-after-fill',
      title: 'Slot doldurunca sonraki açık kutuya doğal geçiş',
      expression: '9□ = □; □ = □',
      expectedSlotRole: 'next open placeholder after insert',
      steps: <String>[
        '9□ = □; □ = □ ifadesinde ilk kutuya sayı yaz.',
        'Focusun sonraki açık kutuya geçtiğini izle.',
        'Aynı işlemi tüm kutular dolana kadar tekrarla.',
      ],
      acceptance: 'En az 9/10 akışta yazı girildikten sonra focus bir sonraki açık kutuya geçmeli; kullanıcı tekrar milimetrik seçim yapmak zorunda kalmamalı.',
    ),
    ManualSlotScenario(
      id: 'debug-leak-visual-audit',
      title: 'Debug/teknik label sızıntısı yok',
      expression: '√(□), □⁄□, ∫_{□}^{□}(□)d□',
      expectedSlotRole: 'user-safe UI only',
      steps: <String>[
        'Kök, kesir ve integral slotlarını sırayla seç.',
        'Toolbar, editor yüzeyi ve sonuç alanını kontrol et.',
        'Ekran kaydı veya ekran görüntüsü al.',
      ],
      acceptance: 'sqrtValue, integralBody, slotId, activeSlot, debug, yeşil debug kutusu görünmemeli.',
    ),
    ManualSlotScenario(
      id: 'keyboard-contract-visual-audit',
      title: 'Donmuş klavye sözleşmesi gerçek cihaz kontrolü',
      expression: 'N/A',
      expectedSlotRole: 'N/A',
      steps: <String>[
        'Temel sekmede 20 tuşu kontrol et.',
        'Expanded sekmelerde 8×5 grid kontrol et.',
        'MORE, Ans, ↵ ve = kararlarını kontrol et.',
        '√, ∫ ve ^ long-press seçeneklerini kontrol et.',
      ],
      acceptance: 'Klavye layout, sekmeler, tuş yerleri ve long-press map değişmemiş olmalı.',
    ),
  ];

  static bool isScenarioPass(int correctAttempts, {int attempts = attemptsPerScenario}) {
    if (attempts <= 0) return false;
    return correctAttempts >= minimumCorrectPerScenario && correctAttempts <= attempts;
  }

  static double successRate({required int correctAttempts, int attempts = attemptsPerScenario}) {
    if (attempts <= 0) return 0;
    return correctAttempts / attempts;
  }

  static RealDeviceProtocolVerdict evaluate(RealDeviceSlotTestReport report) {
    final allCommandsPassed = report.flutterCommandsPassed;
    final hasEvidence = report.evidenceAttached;
    final allScenariosPresent = scenarios.every((scenario) => report.results.any((result) => result.scenarioId == scenario.id));
    final allScenarioResultsPass = report.results.every((result) => isScenarioPass(result.correctAttempts, attempts: result.totalAttempts));
    final overallPass = report.overallSuccessRate >= minimumOverallSuccessRate;

    final pass = allCommandsPassed && hasEvidence && allScenariosPresent && allScenarioResultsPass && overallPass;
    final blockers = <String>[];
    if (!allCommandsPassed) blockers.add('Flutter command evidence is missing or failed.');
    if (!hasEvidence) blockers.add('Real-device screenshot/video evidence is missing.');
    if (!allScenariosPresent) blockers.add('One or more mandatory manual scenarios were not recorded.');
    if (!allScenarioResultsPass) blockers.add('One or more scenarios are below 9/10 correct selections.');
    if (!overallPass) blockers.add('Overall success rate is below 90%.');

    return RealDeviceProtocolVerdict(pass: pass, blockers: blockers);
  }
}

class ManualSlotScenario {
  const ManualSlotScenario({
    required this.id,
    required this.title,
    required this.expression,
    required this.expectedSlotRole,
    required this.steps,
    required this.acceptance,
  });

  final String id;
  final String title;
  final String expression;
  final String expectedSlotRole;
  final List<String> steps;
  final String acceptance;
}

class ManualSlotScenarioResult {
  const ManualSlotScenarioResult({
    required this.scenarioId,
    required this.correctAttempts,
    this.totalAttempts = RealDeviceSlotTestProtocol.attemptsPerScenario,
  });

  final String scenarioId;
  final int correctAttempts;
  final int totalAttempts;

  double get successRate => RealDeviceSlotTestProtocol.successRate(correctAttempts: correctAttempts, attempts: totalAttempts);

  bool get isPass => RealDeviceSlotTestProtocol.isScenarioPass(correctAttempts, attempts: totalAttempts);
}

class RealDeviceSlotTestReport {
  const RealDeviceSlotTestReport({
    required this.flutterCommandsPassed,
    required this.evidenceAttached,
    required this.results,
  });

  final bool flutterCommandsPassed;
  final bool evidenceAttached;
  final List<ManualSlotScenarioResult> results;

  int get totalAttempts => results.fold<int>(0, (sum, result) => sum + result.totalAttempts);
  int get correctAttempts => results.fold<int>(0, (sum, result) => sum + result.correctAttempts);
  double get overallSuccessRate => totalAttempts == 0 ? 0 : correctAttempts / totalAttempts;
}

class RealDeviceProtocolVerdict {
  const RealDeviceProtocolVerdict({required this.pass, required this.blockers});

  final bool pass;
  final List<String> blockers;
}
