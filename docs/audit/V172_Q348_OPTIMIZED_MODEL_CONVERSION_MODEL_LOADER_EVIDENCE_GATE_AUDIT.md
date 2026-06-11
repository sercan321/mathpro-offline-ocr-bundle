# V172-Q348 Optimized Model Conversion / Model Loader Evidence Gate Audit

Q348 is an evidence gate between the Q347 Paddle Lite Predictor instantiate smoke bridge and the future Q349 real model-load smoke.

## Scope

- Records that Q344/Q345/Q346/Q347 are present.
- Preserves the Q344 native binary bundle exactly.
- Records the known user-side Q315 `inference.pdiparams` artifact hash and size.
- Blocks Q349 until Paddle Lite Android model-format and conversion evidence is provided outside the Flutter project root.

## Important Boundary

`inference.pdiparams` alone is not accepted as proof that the Android Paddle Lite model loader can load PP-FormulaNet-S. Q348 requires model-format evidence, conversion command/log, converted artifact hash/size, and an approved model-loader path contract before a real model-load attempt.

## Non-goals

Q348 does not add a model binary, does not add a model loader, does not call Paddle Lite, does not start runtime, does not run dummy input, does not run image-to-LaTeX, does not open OCR review UI, does not import workspace content, and does not claim OCR or Android real-device PASS.

## Protected Surfaces

MainActivity, AndroidManifest, Gradle, pubspec, workspace, keyboard, MORE, long-press, MathLive production bridge/editor, Graph, Solution, History, splash/icon, and solver/evaluator runtime surfaces are not changed by Q348.
