import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hub/app_state.dart';
import 'package:hub/core/test_keys.dart';
import 'package:hub/router/route_paths.dart';
import 'package:hub/services/prefs_service.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/support/test_harness.dart';

/// Deterministic smoke checks with [IntegrationTestWidgetsFlutterBinding] (CI-friendly `flutter test integration_test/...`).
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(configureHubTestFonts);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    AppScope.prefs = await PrefsService.create();
  });

  testWidgets('smoke: dashboard shell and quote tab', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.dashboard));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS04), findsOneWidget);
    expect(find.textContaining('Quick Access'), findsWidgets);

    await tester.tap(find.byKey(Tk.tabQuote));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS07), findsOneWidget);
  });
}
