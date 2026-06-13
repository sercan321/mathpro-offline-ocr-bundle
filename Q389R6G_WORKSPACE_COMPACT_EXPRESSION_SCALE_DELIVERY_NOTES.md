# Q389R6G — WORKSPACE COMPACT EXPRESSION SCALE

## Amaç
Workspace içindeki MathLive production expression görünümünü Fotomath benzeri daha kompakt, daha düzenlenebilir editör ölçeğine çekmek.

Bu faz sadece görsel ölçek fazıdır. Uzun ifade edge-scroll ve Fotomath tarzı long-press cursor drag sonraki fazlara bırakılmıştır.

## Cerrahi değişiklik
Tek runtime dosyası değişti:

- `assets/mathlive/main_editor_prod.html`

Değiştirilen CSS değerleri:

- `font-size: clamp(28px, 7.8vw, 38px);` → `font-size: clamp(23px, 6.35vw, 31px);`
- host min-height `92px` → `84px`
- host padding `9px 11px` → `7px 10px`
- math-field min-height `72px` → `62px`
- math-field line-height `1.24` → `1.20`
- math-field padding `8px 4px` → `5px 3px`
- MathLive editable/root/container min-height `62px` → `54px`

## Kırmızı çizgiler
Bu fazda dokunulmadı:

- Keyboard layout / key ordering
- MathLive production bridge JS
- MathLive input semantics
- Cursor/caret drag logic
- Long expression horizontal scroll logic
- Graph 2D/3D modules
- OCR/camera/Android native
- Solver/CAS
- AppShell graph refresh policy

## Beklenen görsel etki

- `sin(x)` artık dev vitrin yazısı gibi görünmemeli.
- `sin(x)+cos(y)` daha Fotomath benzeri kompakt editör ölçeğine yaklaşmalı.
- Kısa/orta ifadelerde workspace içindeki gereksiz görsel ağırlık azalmalı.
- Çok uzun ifade davranışı bu fazda çözülmez; Q389R6H fazında minimum readable scale + yatay scroll/caret takip güvenliği ayrıca ele alınacaktır.

## Kanıt sınırı
Bu pakette statik verifier çalıştırıldı. Bu ortamda Flutter/Dart bulunmadığı için `flutter analyze`, `flutter test`, release build, gerçek cihaz testi veya FPS PASS iddiası yoktur.
