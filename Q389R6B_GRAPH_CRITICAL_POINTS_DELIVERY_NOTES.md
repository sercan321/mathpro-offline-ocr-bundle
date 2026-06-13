# Q389R6B — Grafik Üzerinde Premium Önemli Nokta Etkileşimi

## Kapsam

Bu paket, grafik paneline kalıcı alt "Önemli Noktalar" kartı eklemeden, grafik üzerinde küçük marker + dokununca tooltip davranışı ekleyen aday pakettir.

Eklenenler:
- 2D grafik üzerinde kök, y-kesişimi, maksimum ve minimum marker katmanı.
- Marker'a dokununca grafik içinde küçük premium tooltip.
- Boş grafik alanına dokununca crosshair + koordinat tooltip'i.
- Mevcut graph settings sheet içinde önemli nokta göster/gizle kontrolleri.
- Fullscreen 2D grafik yüzeyinde aynı interaktif katman.
- Yanlış/kesin olmayan ileri sembolik iddialar yerine güvenli sayısal/viewport tabanlı yaklaşım.

## Bilerek yapılmayanlar

- Kalıcı alt "Önemli Noktalar" kartı eklenmedi.
- Keyboard layout'a dokunulmadı.
- MathLive bridge'e dokunulmadı.
- OCR/camera/Android native çalışma koduna dokunulmadı.
- Solver/CAS motoru değiştirilmedi.
- 3D yüzey davranışı değiştirilmedi.

## Statik doğrulama

Bu ortamda Flutter/Dart yoksa gerçek `flutter analyze`, `flutter test`, `flutter build` ve cihaz PASS iddia edilemez.

Çalıştırılan statik/verifier kontrolleri:

```powershell
node tool/verify_graph_critical_points_interaction_q389r6b.mjs
node tool/verify_graph_canvas_premium_polish_v172_q223.mjs
node tool/verify_graph_mini_panel_final_regression_freeze_v172_q224.mjs
node tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs
node tool/verify_graph_settings_bottom_sheet_control_migration_v172_q222.mjs
```

Not: Eski `verify_graph_2d_3d_elite_toggle_architecture_v172_q208.mjs` verifier'ı bu ZIP'in orijinal halinde de `lib/features/keyboard/math_keyboard.dart` sebebiyle FAIL veriyor; Q389R6B değişikliğine özgü değildir.

## Kullanıcı tarafında istenecek gerçek kanıt

```powershell
cd C:\Users\user\Desktop\MathProFlutterPhase17
flutter clean
flutter pub get
flutter analyze
flutter test
flutter build apk --release --target-platform android-arm64
```

Release APK boyutu:

```powershell
$apk = "build\app\outputs\flutter-apk\app-release.apk"
"{0:N2} MB" -f ((Get-Item $apk).Length / 1MB)
```

Telefona release kurulum:

```powershell
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

Manuel grafik kabul testleri:
- `sin(x)` grafiği: kök/maksimum/minimum/y-kesişimi markerları ve tooltip.
- `x^2 - 4`: `(-2,0)`, `(2,0)`, `(0,-4)` civarı markerlar.
- Boş grafik alanına dokunma: koordinat tooltip + crosshair.
- Settings > Noktalar: kök, maksimum/minimum, y-kesişimi aç/kapat.
- Fullscreen 2D grafik: aynı marker/tooltip davranışı.
- 3D toggle, zoom, trace, workspace, keyboard, camera entry bozulmamalı.
