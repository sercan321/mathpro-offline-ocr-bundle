# Q389R6F — WORKSPACE EXPRESSION SCALE PREFLIGHT AUDIT

## Durum

Bu faz bilinçli olarak davranış değiştirmez. Amaç, Fotomath benzeri kompakt expression ölçeği, çok uzun ifade yatay scroll davranışı ve long-press cursor drag fazlarına girmeden önce gerçek aktif dosyaları ve kırmızı çizgileri dondurmaktır.

Bu fazda şunlar yapılmadı:

- MathLive font-size değiştirilmedi.
- Workspace padding/minHeight değiştirilmedi.
- Cursor/caret davranışı değiştirilmedi.
- Long-press drag eklenmedi.
- Yatay scroll davranışı değiştirilmedi.
- Keyboard, Graph, OCR, Android native, solver/CAS tarafına dokunulmadı.

## Aktif yüzey haritası

### 1. Workspace kartı

Ana dosya:

```text
lib/features/workspace/workspace_panel.dart
```

Önemli bölgeler:

```text
_PremiumQuestionAnswerCard
_PremiumCardMetrics
_Q382R30ExpressionFrameSection
```

Risk:

- Kart height/padding değişiklikleri keyboard/workspace dengesini bozabilir.
- Graph açıkken workspace slot yüksekliği değişirse graph/keyboard ritmi bozulabilir.
- Solution panel açıkken expression alanı ezilebilir.

Q389R6G için güvenli yaklaşım:

- Önce MathLive HTML içindeki font-scale küçültülecek.
- Workspace card metrics ancak gerekiyorsa minimal ayarlanacak.
- Keyboard/graph/solution layout matematiği değiştirilmemeli.

### 2. Production MathLive HTML/CSS

Ana dosya:

```text
assets/mathlive/main_editor_prod.html
```

Mevcut ölçek baseline:

```css
#mathpro-editor-host {
  padding: 9px 11px;
}

math-field {
  font-size: clamp(28px, 7.8vw, 38px);
  line-height: 1.24;
  padding: 8px 4px;
  overflow-x: auto;
  white-space: nowrap;
}
```

Bu ekran görüntülerindeki büyük expression görünümünün ana kaynağı büyük ihtimalle bu `font-size: clamp(28px, 7.8vw, 38px)` değeridir.

Q389R6G için önerilen cerrahi müdahale:

- `font-size` kontrollü şekilde düşürülecek.
- Minimum okunabilirlik korunacak.
- `overflow-x: auto` ve `white-space: nowrap` korunacak.
- MathLive native caret ownership korunacak.

### 3. Production bridge / caret hattı

Ana dosya:

```text
assets/mathlive/mathlive_prod_bridge.js
```

Mevcut kritik davranışlar:

```text
pointerdown → native MathLive focus/caret state
pointerup/click/touchend → keepNativeCaretInView
selection-change → caret state push
keepNativeCaretInView → host/mf görünürlük talebi
```

Q389R6G ve Q389R6H için karar:

- Bu dosyaya dokunulmayacak.
- Font/scale ve minimum yatay scroll davranışı önce HTML/CSS tarafında çözülecek.

Q389R6I için karar:

- Long-press cursor drag gerekiyorsa bu dosya ancak ayrı fazda, ayrı verifier ile ve native MathLive caret authority bozulmadan ele alınacak.
- Legacy Flutter cursor overlay kesinlikle geri getirilmeyecek.

### 4. Flutter production WebView surface

Ana dosyalar:

```text
lib/features/mathlive/mathlive_main_editor_surface.dart
lib/features/mathlive/mathlive_production_editor_surface.dart
```

Karar:

- Q389R6G için bu dosyalara dokunmak gerekmiyor.
- MathLive HTML/CSS tek dosya üzerinden production editor görünümüne zaten inline ediliyor.
- WebView gestureRecognizers değiştirilmemeli.

## Dokunulmayacak kırmızı çizgiler

Aşağıdaki alanlara Q389R6G/Q389R6H sırasında dokunulmayacak:

```text
lib/features/keyboard/**
assets/mathlive/mathlive_prod_bridge.js  (Q389R6I öncesi)
lib/app/app_shell.dart                   (grafik refresh hattı korunacak)
lib/features/graph/**
lib/features/camera/**
android/**
lib/features/solution/**
solver/CAS dosyaları
legacy Flutter cursor/render path
```

Korunacak kritik davranışlar:

```text
C → 88888 → 7777 = 888887777
normal tap-to-place
MathLive native caret authority
sin(300) içinde parantez dışına erken kaçmama
fraction/root/exponent slot hizası
2D/3D graph marker/tooltip
3D 360° rotate
Enter ile graph refresh
OCR/camera import yüzeyi
```

## Sonraki fazlar

### Q389R6G — Workspace compact expression scale

Amaç:

- Fotomath benzeri daha kontrollü expression font ölçeği.
- Kısa ifadeler dev vitrin yazısı gibi durmayacak.
- Orta ifadeler daha rahat sığacak.
- MathLive davranışına dokunulmayacak.

Öncelikli dosya:

```text
assets/mathlive/main_editor_prod.html
```

### Q389R6H — Long expression horizontal scroll + caret visibility hardening

Amaç:

- Çok uzun ifade minimum okunabilir ölçekten sonra yatay scroll ile taşınacak.
- Expression minicik olmayacak.
- Caret görünür kalacak.

Öncelikli dosyalar:

```text
assets/mathlive/main_editor_prod.html
assets/mathlive/mathlive_prod_bridge.js  (sadece zorunlu olursa)
```

### Q389R6I — Fotomath-style long-press cursor drag + edge autoscroll

Amaç:

- Basılı tutup sağa/sola sürükleme ile caret akıcı hareket edecek.
- Kenara yaklaşınca expression yatay kayacak.
- Kullanıcı parmağını kaldırmadan başa/sona ulaşacak.

Bu en riskli fazdır. Q389R6G/Q389R6H kanıtı olmadan uygulanmamalıdır.

## Kanıt sınırı

Bu ortamda Flutter/Dart yoktur. Bu yüzden bu faz için:

```text
flutter analyze geçti denmez.
flutter test geçti denmez.
flutter build/run geçti denmez.
telefonda PASS denmez.
```

Bu faz yalnızca statik audit/verifier paketidir.
