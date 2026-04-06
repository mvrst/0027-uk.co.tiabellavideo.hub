import 'package:flutter/material.dart';

/// Surfaces failed or unsupported external intents (contract: honest error states).
extension LaunchFeedback on BuildContext {
  Future<void> runExternal(
    Future<bool> Function() launch, {
    String failureMessage = 'Could not open this on your device.',
  }) async {
    try {
      final ok = await launch();
      if (!mounted) return;
      if (!ok) {
        ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(failureMessage)));
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(failureMessage)));
    }
  }
}
