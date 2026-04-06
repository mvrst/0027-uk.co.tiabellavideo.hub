import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hub/app_state.dart';
import 'package:hub/services/prefs_service.dart';
import 'package:hub/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../support/test_harness.dart';

/// Google Play phone portrait logical size (1:1 with PNG pixel dimensions at [devicePixelRatio] 1.0).
const Size kStoreScreenshotLogicalSize = Size(1080, 1920);

/// Root [RepaintBoundary] for golden capture — must match [findStoreScreenshotBoundary].
const ValueKey<String> kStoreScreenshotRepaintKey = ValueKey<String>('STORE_SCREENSHOT_REPAINT');

Finder findStoreScreenshotBoundary() => find.byKey(kStoreScreenshotRepaintKey);

/// Wraps the same [hubTestShell] UI used elsewhere, fixed to [kStoreScreenshotLogicalSize] for goldens.
Widget storeScreenshotApp({required String initialLocation}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: RepaintBoundary(
      key: kStoreScreenshotRepaintKey,
      child: SizedBox.fromSize(
        size: kStoreScreenshotLogicalSize,
        child: ClipRect(
          child: hubTestShell(
            initialLocation: initialLocation,
            theme: AppTheme.lightForGoldens,
          ),
        ),
      ),
    ),
  );
}

/// Fixed viewport + pixel ratio so PNG dimensions are always 1080×1920.
Future<void> applyStoreScreenshotSurface(WidgetTester tester) async {
  tester.view.physicalSize = kStoreScreenshotLogicalSize;
  tester.view.devicePixelRatio = 1.0;
  await tester.pump();
}

void resetStoreScreenshotSurface(WidgetTester tester) {
  tester.view.resetPhysicalSize();
  tester.view.resetDevicePixelRatio();
}

/// Bounded layout settle — no [pumpAndSettle] (animations complete within budget or we accept frame).
Future<void> pumpStoreScreenshotLayout(WidgetTester tester) async {
  await tester.pump();
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 40));
  }
}

/// Prefs + fonts + url_launcher mock for isolated, prompt goldens.
Future<void> prepareStoreScreenshotSession() async {
  configureHubTestFonts();
  bindUrlLauncherRecording(<String>[]);
  SharedPreferences.setMockInitialValues(_deterministicPrefsSeed);
  AppScope.prefs = await PrefsService.create();
}

/// Stable toggle + empty drafts so Settings / Quote / Contact match the manifest description.
const Map<String, Object> _deterministicPrefsSeed = <String, Object>{
  'pref_notifications': true,
  'pref_email_updates': false,
};

void finishStoreScreenshotSession() {
  unbindUrlLauncherMock();
}
