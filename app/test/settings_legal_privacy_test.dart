import 'package:flutter_test/flutter_test.dart';
import 'package:hub/app_state.dart';
import 'package:hub/core/constants.dart';
import 'package:hub/core/test_keys.dart';
import 'package:hub/router/route_paths.dart';
import 'package:hub/services/prefs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/test_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(configureHubTestFonts);

  final launched = <String>[];

  setUp(() async {
    launched.clear();
    bindUrlLauncherRecording(launched);
    SharedPreferences.setMockInitialValues({});
    AppScope.prefs = await PrefsService.create();
  });

  tearDown(unbindUrlLauncherMock);

  testWidgets('settings → Legal Information → back', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.settings));
    await pumpHubFrames(tester);

    await tester.ensureVisible(find.byKey(Tk.s13Legal));
    await tester.tap(find.byKey(Tk.s13Legal));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS14), findsOneWidget);
    expect(find.textContaining('Legal Information'), findsWidgets);

    await tester.tap(find.byKey(Tk.s14Back));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS13), findsOneWidget);
  });

  testWidgets('settings Privacy Policy launches exact PRIVACY_POLICY_URL', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.settings));
    await pumpHubFrames(tester);

    await tester.ensureVisible(find.byKey(Tk.s13Privacy));
    await tester.tap(find.byKey(Tk.s13Privacy));
    await pumpAsyncGap(tester);

    expect(kPrivacyPolicyUrl, 'https://tiabellavideo.co.uk/privacy-policy');
    expect(launched, contains(kPrivacyPolicyUrl));
    expect(launched.last, kPrivacyPolicyUrl);
  });

  testWidgets('settings About Us reaches /about', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.settings));
    await pumpHubFrames(tester);

    await tester.ensureVisible(find.byKey(Tk.s13About));
    await tester.tap(find.byKey(Tk.s13About));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS11), findsOneWidget);
    expect(find.textContaining('About Us'), findsWidgets);
  });
}
