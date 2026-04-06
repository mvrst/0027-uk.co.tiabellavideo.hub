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

  final launched = <String>[];

  setUp(() async {
    launched.clear();
    bindUrlLauncherRecording(launched);
    SharedPreferences.setMockInitialValues({});
    AppScope.prefs = await PrefsService.create();
  });

  tearDown(unbindUrlLauncherMock);

  testWidgets('quote flow: submit shows local-save snackbar', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.quote));
    await pumpHubFrames(tester);

    await tester.ensureVisible(find.byKey(Tk.s07Submit));
    await tester.tap(find.byKey(Tk.s07Submit));
    await pumpAsyncGap(tester);

    expect(find.textContaining('saved on this device'), findsWidgets);
  });

  testWidgets('quote flow: change type then submit', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.quote));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s07TypePost));
    await pumpHubFrames(tester);
    await tester.tap(find.byKey(Tk.s07DurWk));
    await pumpHubFrames(tester);
    await tester.ensureVisible(find.byKey(Tk.s07Submit));
    await tester.tap(find.byKey(Tk.s07Submit));
    await pumpAsyncGap(tester);

    expect(find.textContaining('saved on this device'), findsWidgets);
  });

  testWidgets('contact flow: validation then successful save', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.contact));
    await pumpHubFrames(tester);

    await tester.ensureVisible(find.byKey(Tk.s10Send));
    await tester.tap(find.byKey(Tk.s10Send));
    await pumpHubFrames(tester);
    expect(find.text('Required'), findsWidgets);

    await tester.enterText(find.byKey(Tk.s10FieldName), 'Test User');
    await tester.enterText(find.byKey(Tk.s10FieldEmail), 'not-an-email');
    await tester.enterText(find.byKey(Tk.s10FieldMessage), 'Hello');
    await tester.ensureVisible(find.byKey(Tk.s10Send));
    await tester.tap(find.byKey(Tk.s10Send));
    await pumpHubFrames(tester);
    expect(find.textContaining('valid email'), findsWidgets);

    await tester.enterText(find.byKey(Tk.s10FieldEmail), 'client@example.com');
    await tester.ensureVisible(find.byKey(Tk.s10Send));
    await tester.tap(find.byKey(Tk.s10Send));
    await pumpAsyncGap(tester);

    expect(find.textContaining('saved on this device'), findsWidgets);
  });

  testWidgets('contact quick call uses mocked url launcher', (tester) async {
    await tester.pumpWidget(hubTestShell(initialLocation: RoutePaths.contact));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s10QuickCall));
    await pumpAsyncGap(tester);

    expect(launched, isNotEmpty);
    expect(launched.last, startsWith('tel:'));
  });
}
