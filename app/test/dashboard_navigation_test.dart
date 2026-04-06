import 'package:flutter_test/flutter_test.dart';
import 'package:hub/app_state.dart';
import 'package:hub/core/test_keys.dart';
import 'package:hub/router/route_paths.dart';
import 'package:hub/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(configureHubTestFonts);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    AppScope.prefs = await PrefsService.create();
  });

  testWidgets('dashboard quick access: Portfolio', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.dashboard));
    await pumpHubFrames(tester);

    expect(find.textContaining('Quick Access'), findsWidgets);

    await tester.tap(find.byKey(Tk.s04QuickPortfolio));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS05), findsOneWidget);
    expect(find.text('Portfolio'), findsWidgets);
  });

  testWidgets('dashboard quick access: Contact', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.dashboard));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s04QuickContact));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS10), findsOneWidget);
    expect(find.textContaining('Contact Us'), findsWidgets);
  });

  testWidgets('bottom tab QUOTE from dashboard', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.dashboard));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.tabQuote));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS07), findsOneWidget);
    expect(find.textContaining('Quote Request'), findsWidgets);
  });

  testWidgets('bottom tab MORE opens settings', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.dashboard));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.tabMore));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS13), findsOneWidget);
    expect(find.text('Settings'), findsWidgets);
  });
}
