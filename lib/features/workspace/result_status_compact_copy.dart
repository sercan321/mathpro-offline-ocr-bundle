/// V172-Q232 — Result status compact copy resolver.
///
/// The SONUÇ panel is a compact result/status surface, not a tutorial copy
/// surface.  Raw evaluator/status reasons can remain descriptive for internal
/// state, logs, History, and debugging, but runtime panel copy is resolved here
/// into short premium labels before it reaches `ResultView`.
class ResultStatusCopy {
  const ResultStatusCopy({required this.full, required this.compact});

  final String full;
  final String compact;

  String select({required bool compactMode}) => compactMode ? compact : full;
}

class ResultStatusCopyResolver {
  const ResultStatusCopyResolver._();

  static const ResultStatusCopy openSlot = ResultStatusCopy(
    full: 'Açık slotları doldurun',
    compact: 'Slot bekleniyor',
  );
  static const ResultStatusCopy emptyExpression = ResultStatusCopy(
    full: 'İfade girin',
    compact: 'İfade bekleniyor',
  );
  static const ResultStatusCopy noResult = ResultStatusCopy(
    full: 'Sonuç henüz yok',
    compact: 'Sonuç yok',
  );
  static const ResultStatusCopy unsupported = ResultStatusCopy(
    full: 'İfade değerlendirilemiyor',
    compact: 'Değerlendirilemedi',
  );
  static const ResultStatusCopy graphIncompatible = ResultStatusCopy(
    full: 'Grafik için uygun değil',
    compact: 'Grafik uygun değil',
  );
  static const ResultStatusCopy invalidExpression = ResultStatusCopy(
    full: 'Geçersiz ifade',
    compact: 'Geçersiz',
  );
  static const ResultStatusCopy calculationError = ResultStatusCopy(
    full: 'Hesaplama hatası',
    compact: 'Hata',
  );
  static const ResultStatusCopy noSolutionStep = ResultStatusCopy(
    full: 'Çözüm adımı yok',
    compact: 'Adım yok',
  );
  static const ResultStatusCopy advancedRequired = ResultStatusCopy(
    full: 'İleri işlem gerekli',
    compact: 'İleri işlem',
  );

  static ResultStatusCopy resolve(String rawMessage) {
    final raw = rawMessage.trim();
    if (raw.isEmpty) return noResult;

    final lower = _fold(raw);

    if (_containsAny(lower, const <String>[
      'açık slot',
      'placeholder',
      'slotları doldur',
    ])) {
      return openSlot;
    }

    if (_containsAny(lower, const <String>[
      'ifade girilmeden',
      'ifade bekleniyor',
      'klavye ile ifade',
    ])) {
      return emptyExpression;
    }

    if (_containsAny(lower, const <String>[
      'grafik gösterimi',
      'grafik moduna uygun',
      'graph incompatible',
    ])) {
      return graphIncompatible;
    }

    if (_containsAny(lower, const <String>[
      'geçersiz',
      'kapanış parantezi eksik',
      'açılış parantezi eksik',
      'sayı beklenen konum',
      'desteklenmeyen fonksiyon',
      'format',
    ])) {
      return invalidExpression;
    }

    if (_containsAny(lower, const <String>[
      'hesaplama hatası',
      'sonlu değil',
      'nan',
      'infinite',
      'negatif sayının reel karekökü',
      'pozitif argüman gerekir',
    ])) {
      return calculationError;
    }

    if (_containsAny(lower, const <String>[
      'çözüm adımı',
      'solution step',
    ])) {
      return noSolutionStep;
    }

    if (_containsAny(lower, const <String>[
      'solver bridge',
      'ileri solver',
      'ileri lineer cebir',
      'gerçek çözüm',
      'solver gerekli',
      'matris',
      'vektör',
      'diferansiyel denklem',
      'kısmi diferansiyel',
    ])) {
      return advancedRequired;
    }

    if (_containsAny(lower, const <String>[
      'değerlendirilemiyor',
      'değerlendiricide',
      'değerlendirici kapsamının dışında',
      'şu anda değerlendirilemiyor',
      'henüz desteklenmiyor',
      'desteklenmiyor',
      'değişken içeren ifade',
      'cebirsel ifade',
      'ileri ifade',
    ])) {
      return unsupported;
    }

    // Keep already-short premium labels intact.  Any longer raw reason falls
    // back to the calm unsupported copy so the compact SONUÇ panel never turns
    // into a cropped explanatory paragraph.
    if (raw.length <= 22 && !raw.contains('.')) {
      return ResultStatusCopy(full: raw, compact: raw);
    }
    return unsupported;
  }

  static String displayText(String rawMessage, {required bool compactMode}) {
    return resolve(rawMessage).select(compactMode: compactMode);
  }

  static bool _containsAny(String source, List<String> needles) {
    for (final needle in needles) {
      if (source.contains(_fold(needle))) return true;
    }
    return false;
  }

  static String _fold(String value) {
    return value.toLowerCase().replaceAll('ı', 'i').replaceAll('i̇', 'i');
  }
}
