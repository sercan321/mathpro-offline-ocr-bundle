# MathPro Flutter Phase 17 — Run Instructions

## 1. Open in VS Code

1. Extract `MathPro_Flutter_Phase13_FULL.zip`.
2. Open **VS Code**.
3. Click **File > Open Folder**.
4. Select the extracted `MathProFlutterPhase13` folder.
5. Install the **Flutter** and **Dart** extensions if VS Code suggests them.

## 2. Check Flutter installation

Open **Terminal > New Terminal** in VS Code and run:

```bash
flutter doctor
```

If Flutter is not found, Flutter is not installed or PATH is not set.

## 3. Download packages

```bash
flutter pub get
```

## 4. Analyze code

```bash
flutter analyze
```

## 5. Run tests

```bash
flutter test
```

## 6. Launch app

Start an Android emulator or connect your phone by USB, then run:

```bash
flutter run
```

If multiple devices exist:

```bash
flutter devices
flutter run -d DEVICE_ID
```

## Honest status

Flutter/Dart SDK was not available in the packaging environment. These commands were not executed during package generation. Runtime PASS requires you to run them locally.
