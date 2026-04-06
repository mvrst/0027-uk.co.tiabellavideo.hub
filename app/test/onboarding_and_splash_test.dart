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

  testWidgets('splash tap continues to onboarding intro', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.splash));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s01Continue));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS02), findsOneWidget);
    expect(find.textContaining('Professional Production'), findsWidgets);
  });

  testWidgets('onboarding intro → workflow → dashboard', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.onboardingIntro));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s02Next));
    await pumpHubFrames(tester);
    expect(find.byKey(Tk.screenS03), findsOneWidget);
    expect(find.textContaining('Follow Every Project Stage'), findsWidgets);

    await tester.tap(find.byKey(Tk.s03GetStarted));
    await pumpHubFrames(tester);
    expect(find.byKey(Tk.screenS04), findsOneWidget);
    expect(find.textContaining('Production Hub'), findsWidgets);
  });

  testWidgets('onboarding skip reaches dashboard', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.onboardingIntro));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s02Skip));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS04), findsOneWidget);
  });
}
