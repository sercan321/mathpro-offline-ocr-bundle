import 'math_key_inventory.dart';
import 'math_template_contract_registry.dart';
import 'mathpro_package_contract.dart';
import 'premium_math_key_specs.dart';

/// V137: single visual classification contract for keyboard, MORE and
/// long-press math labels.
///
/// This file does not own key positions or long-press ordering.  It only owns
/// the visual family/weight/scale profile that compact math surfaces should
/// use so a label cannot look premium in one surface and oversized/bold/raw in
/// another.  MathLabel consumes this contract for fallback text labels while
/// custom glyph widgets keep using the same family names for audit coverage.
class MathKeyVisualProfile {
  const MathKeyVisualProfile({
    required this.family,
    required this.compactFontSize,
    required this.inlineFontSize,
    required this.weightClass,
    this.letterSpacing = -0.16,
    this.height = 1.02,
  });

  final String family;
  final double compactFontSize;
  final double inlineFontSize;

  /// One of: regular, medium, semibold.
  final String weightClass;
  final double letterSpacing;
  final double height;

  bool get isHeavy => weightClass == 'semibold';
}

class MathKeyVisualContract {
  const MathKeyVisualContract._();

  static const String phase = MathProPackageContract.phase;

  static const Map<String, MathKeyVisualProfile> familyProfiles = <String, MathKeyVisualProfile>{
    'command': MathKeyVisualProfile(family: 'command', compactFontSize: 13.6, inlineFontSize: 16.6, weightClass: 'semibold'),
    'primitive': MathKeyVisualProfile(family: 'primitive', compactFontSize: 13.4, inlineFontSize: 16.6, weightClass: 'medium'),
    'operator': MathKeyVisualProfile(family: 'operator', compactFontSize: 13.8, inlineFontSize: 16.8, weightClass: 'medium'),
    'function': MathKeyVisualProfile(family: 'function', compactFontSize: 13.0, inlineFontSize: 16.2, weightClass: 'medium', letterSpacing: -0.18),
    'trig': MathKeyVisualProfile(family: 'trig', compactFontSize: 13.0, inlineFontSize: 16.2, weightClass: 'medium', letterSpacing: -0.18),
    'log': MathKeyVisualProfile(family: 'log', compactFontSize: 12.8, inlineFontSize: 16.0, weightClass: 'medium', letterSpacing: -0.22),
    'limit': MathKeyVisualProfile(family: 'limit', compactFontSize: 12.2, inlineFontSize: 15.6, weightClass: 'medium', letterSpacing: -0.18),
    'integral': MathKeyVisualProfile(family: 'integral', compactFontSize: 13.0, inlineFontSize: 16.2, weightClass: 'medium', letterSpacing: -0.22),
    'big-operator': MathKeyVisualProfile(family: 'big-operator', compactFontSize: 13.2, inlineFontSize: 16.4, weightClass: 'medium', letterSpacing: -0.2),
    'derivative': MathKeyVisualProfile(family: 'derivative', compactFontSize: 12.6, inlineFontSize: 15.8, weightClass: 'medium', letterSpacing: -0.24),
    'fraction': MathKeyVisualProfile(family: 'fraction', compactFontSize: 13.0, inlineFontSize: 16.2, weightClass: 'medium'),
    'root': MathKeyVisualProfile(family: 'root', compactFontSize: 13.2, inlineFontSize: 16.4, weightClass: 'medium'),
    'power': MathKeyVisualProfile(family: 'power', compactFontSize: 12.9, inlineFontSize: 16.0, weightClass: 'medium'),
    'postfix': MathKeyVisualProfile(family: 'postfix', compactFontSize: 12.8, inlineFontSize: 16.0, weightClass: 'medium'),
    'binary-slot-operator': MathKeyVisualProfile(family: 'binary-slot-operator', compactFontSize: 12.4, inlineFontSize: 15.8, weightClass: 'medium'),
    'series': MathKeyVisualProfile(family: 'series', compactFontSize: 11.8, inlineFontSize: 15.4, weightClass: 'medium', letterSpacing: -0.22),
    'matrix': MathKeyVisualProfile(family: 'matrix', compactFontSize: 12.4, inlineFontSize: 15.8, weightClass: 'medium'),
    'vector': MathKeyVisualProfile(family: 'vector', compactFontSize: 12.4, inlineFontSize: 15.8, weightClass: 'medium'),
    'system': MathKeyVisualProfile(family: 'system', compactFontSize: 12.2, inlineFontSize: 15.6, weightClass: 'medium'),
    'general': MathKeyVisualProfile(family: 'general', compactFontSize: 13.2, inlineFontSize: 16.4, weightClass: 'medium'),
  };

  static MathKeyVisualProfile profileFor(String label) {
    final family = visualFamilyFor(label);
    return familyProfiles[family] ?? familyProfiles['general']!;
  }

  static String visualFamilyFor(String label) {
    final normalized = label.trim();
    if (MathKeyInventory.commandLabels.contains(normalized)) return 'command';
    if (_operatorLabels.contains(normalized)) return 'operator';
    final contract = MathTemplateContractRegistry.contractFor(normalized);
    if (contract != null) return _normalizeFamily(contract.visualFamily.isEmpty ? contract.family : contract.visualFamily);
    final spec = PremiumMathKeySpecs.specFor(normalized);
    if (spec != null) return _familyFromSpecFamily(spec.family);
    if (MathKeyInventory.primitiveTextLabels.contains(normalized)) return 'primitive';
    if (normalized.contains('lim')) return 'limit';
    if (normalized.contains('∫')) return 'integral';
    if (normalized.contains('Σ') || normalized.contains('Π')) return 'big-operator';
    if (normalized.contains('serisi') || normalized == 'Taylor' || normalized == 'Maclaurin') return 'series';
    if (normalized.contains('log')) return 'log';
    if (_looksLikeFunction(normalized)) return 'function';
    return 'general';
  }

  static Set<String> unprofiledPublicLabels(Iterable<String> labels) {
    final unprofiled = <String>{};
    for (final label in labels) {
      final family = visualFamilyFor(label);
      if (!familyProfiles.containsKey(family)) unprofiled.add(label);
    }
    return unprofiled;
  }

  static Set<String> heavyCompactPublicLabels(Iterable<String> labels) {
    final heavy = <String>{};
    for (final label in labels) {
      final profile = profileFor(label);
      if (profile.isHeavy && !_allowedHeavyLabels.contains(label)) heavy.add(label);
    }
    return heavy;
  }

  static String _normalizeFamily(String family) {
    if (family.contains('series')) return 'series';
    if (family.contains('integral')) return 'integral';
    if (family.contains('limit')) return 'limit';
    if (family.contains('derivative')) return 'derivative';
    if (family.contains('matrix')) return 'matrix';
    if (family.contains('vector')) return 'vector';
    if (family.contains('system')) return 'system';
    if (family.contains('log')) return 'log';
    if (family.contains('trig')) return 'function';
    if (family.contains('function')) return 'function';
    if (family.contains('postfix')) return 'postfix';
    if (family.contains('root')) return 'root';
    if (family.contains('fraction')) return 'fraction';
    if (family.contains('power')) return 'power';
    if (family.contains('binary-slot')) return 'binary-slot-operator';
    if (family.contains('big-operator')) return 'big-operator';
    return familyProfiles.containsKey(family) ? family : 'general';
  }

  static String _familyFromSpecFamily(String family) => _normalizeFamily(family);

  static bool _looksLikeFunction(String value) {
    return RegExp(r'^(?:sin|cos|tan|cot|sec|csc|sinh|cosh|tanh|ln|log|det|arg|Arg|cis|Re|Im|f|g|h|Γ|rank|rref|eig|solve)\(').hasMatch(value) ||
        value.contains('⁻¹(□)');
  }

  static const Set<String> _operatorLabels = <String>{
    '+', '−', '×', '÷', '%', '=', '≠', '<', '>', '≤', '≥', '≈', '≡', ',', ';', '.',
  };

  static const Set<String> _allowedHeavyLabels = <String>{'C', '⌫', 'MORE', 'Ans', '↵'};
}
