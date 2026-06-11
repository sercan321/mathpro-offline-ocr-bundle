# GRAPH / HISTORY V7 — Known Limitations

- Flutter/Dart SDK was not available in this delivery environment; analyzer, widget tests and real-device run were not executed here.
- History persistence still uses `shared_preferences`; this is appropriate for small local history but not a final large-scale storage layer.
- Swipe delete / swipe pin remains future work; V7 focuses on item card structure and long-press/contextual actions.
- Advanced implicit graphing such as `x² + y² = 1` remains intentionally deferred.
- Graph mini previews are lightweight previews, not a separate high-fidelity plotting engine.
