# MathPro Core Editor — Phase H Real Device Manual Test Protocol

## Scope

Phase H is the real-device evidence gate for the MathPro Core Editor Engine. It does not change the frozen keyboard layout, tab order, key labels, long-press map, MORE/Ans/↵/= decisions, or visual keyboard geometry.

This phase converts the manual acceptance target into a code-backed protocol:

```text
10 attempts per scenario
minimum 9 correct selections per scenario
overall success rate >= 90%
physical Android device evidence required
```

Do not mark the package as final PASS unless the protocol is actually executed on a real device and evidence is attached.

## Required local commands

Run all commands before the manual device test:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

If any command fails, the package is not PASS. Fix the failure before doing the real-device slot test.

## Manual scenarios

### 1. √ iç slot doğrudan seçim

Expression:

```text
√(□)
```

Steps:

1. Open Cebir.
2. Tap the √ template.
3. Touch different points inside the root slot 10 times.

Acceptance:

```text
At least 9/10 touches select sqrt.value.
No sqrtValue / slotId / debug label is visible to the user.
```

### 2. Kesir pay/payda ayrımı

Expression:

```text
□⁄□
```

Steps:

1. Insert the fraction template.
2. Touch the numerator 10 times.
3. Touch the denominator 10 times.

Acceptance:

```text
Numerator and denominator each pass with at least 9/10 correct selections.
They must not steal each other’s taps.
```

### 3. Üs slotu seçimi

Expression:

```text
□^(□)
```

Steps:

1. Insert the power template.
2. Touch the exponent slot 10 times from slightly different points.

Acceptance:

```text
At least 9/10 touches select the exponent slot.
The base slot must not accidentally win near the exponent.
```

### 4. İntegral alt/üst/body/differential ayrımı

Expression:

```text
∫_{□}^{□}(□)d□
```

Steps:

1. Open Kalkülüs.
2. Insert the editable definite integral template.
3. Touch lower limit 10 times.
4. Touch upper limit 10 times.
5. Touch body 10 times.
6. Touch differential 10 times.

Acceptance:

```text
Each integral zone must pass at least 9/10.
The body slot must not steal upper/lower limit taps.
```

### 5. İç içe kökte en iç slot seçimi

Expression:

```text
√(√(√(□)))
```

Steps:

1. Build a three-level nested square root.
2. Touch near the deepest placeholder 10 times.
3. Touch around outer root lines to check intentional outer selection behavior.

Acceptance:

```text
Near the deepest placeholder, the deepest sqrt.value wins at least 9/10.
Outer sqrt slots must not randomly steal intended inner taps.
```

### 6. Pan/zoom sonrası hit-test senkronu

Expression:

```text
√(□) + □⁄□ + ∫_{□}^{□}(□)d□
```

Steps:

1. Build a long expression with sqrt, fraction, and integral.
2. Pinch zoom in.
3. Pan horizontally.
4. Re-test the sqrt, fraction, and integral slots.

Acceptance:

```text
After pan/zoom, hit-test must not drift.
Each slot group must still pass at least 9/10.
```

### 7. Debug/technical label visual audit

Steps:

1. Select sqrt, fraction, and integral slots.
2. Check editor surface, toolbar, result area, and history surface.
3. Capture screenshot/video evidence.

Forbidden visible strings/objects:

```text
sqrtValue
integralBody
slotId
activeSlot
debug
Aktif slot:
green debug rectangle
```

Acceptance:

```text
No technical slot name or debug overlay is visible.
Only user-safe labels such as Seçim / Aktif alan may appear.
```

### 8. Frozen keyboard visual audit

Steps:

1. Check Temel 20-key core.
2. Check expanded tabs remain 8 × 5.
3. Check MORE, Ans, ↵, and =.
4. Check √, ∫, and ^ long-press menus.

Acceptance:

```text
No keyboard layout, tab, key position, label, or long-press map drift.
```

## Evidence template

Use this format when reporting real-device results:

```text
Device: 23106RN0DA
Flutter commands: PASS / FAIL
Evidence: screenshot/video attached: YES / NO

Scenario sqrt-slot-direct: __ / 10
Scenario fraction-numerator: __ / 10
Scenario fraction-denominator: __ / 10
Scenario power-exponent: __ / 10
Scenario integral-lower: __ / 10
Scenario integral-upper: __ / 10
Scenario integral-body: __ / 10
Scenario integral-differential: __ / 10
Scenario nested-sqrt-depth: __ / 10
Scenario pan-zoom-hit-sync: __ / 10
Debug visual audit: PASS / FAIL
Keyboard visual audit: PASS / FAIL

Overall verdict: PASS / CONDITIONAL PASS / REJECT
Blockers:
- ...
```

## PASS law

Final PASS is allowed only when:

1. `flutter pub get` passes.
2. `flutter analyze` passes.
3. `flutter test` passes.
4. `flutter run -d 23106RN0DA` opens on the device.
5. Every manual slot scenario is at least 9/10.
6. Overall success rate is at least 90%.
7. Evidence is attached.
8. No debug/technical label is visible.
9. Frozen keyboard contract remains intact.

If any one of these fails, do not call it final PASS.
