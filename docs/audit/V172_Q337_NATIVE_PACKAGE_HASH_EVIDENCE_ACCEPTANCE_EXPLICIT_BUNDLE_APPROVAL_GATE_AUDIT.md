# V172 Q337 — Native Package Hash Evidence Acceptance / Explicit Bundle Approval Gate

## Faz

`V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE`

## Amaç

Q337, Q328/Q336 native package hash evidence JSON ve kullanıcının açık binary bundle onayı olmadan `.so` / `.jar` dosyalarının projeye kopyalanmasını engelleyen son kabul kapısıdır.

## Yapılan

- `mathpro/ocr_runtime_bridge` kanalına `nativePackageHashEvidenceAcceptanceExplicitBundleApproval` method envelope'u eklendi.
- Q337 manifest envelope'u eklendi.
- Q337 Dart policy/runtime self-check dosyaları eklendi.
- Q337 verifier eklendi.
- Q337, Q336'dan successor olarak ilerler.

## Bilerek Yapılmayan

- `.so`, `.jar`, `.aar` bundle edilmedi.
- `jniLibs/` ve `android/app/libs/` oluşturulmadı.
- Gradle, pubspec ve AndroidManifest değiştirilmedi.
- `System.loadLibrary` eklenmedi.
- Paddle Lite instantiate edilmedi.
- Runtime startup, model load, dummy call, image-to-LaTeX, MathLive review, workspace import ve OCR PASS yoktur.

## Protected Değişiklik Beyanı

`android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt` bilerek değişti. Değişiklik sadece default-off bridge envelope method'u içindir.
