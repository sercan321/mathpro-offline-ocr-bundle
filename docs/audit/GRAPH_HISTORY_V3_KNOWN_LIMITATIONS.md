# GRAPH/HISTORY V3 — Known Limitations

- This phase hardens the lightweight explicit graph painter; it is not a full CAS/math engine.
- Implicit curves such as `x² + y² = 1` remain deferred to advanced graph mode.
- Tangent/asymptote segmentation is now safer, but exact symbolic discontinuity detection is not yet implemented.
- The graph engine still samples functions numerically; adaptive root/extrema/domain analysis is future work.
- Pinch-to-zoom is not part of this phase; fullscreen supports button zoom and drag pan from V2.
- Flutter analyze/test/run must still be executed on the user's Flutter environment.
