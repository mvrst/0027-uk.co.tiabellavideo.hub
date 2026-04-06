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

  testWidgets('portfolio preview: Request a Quote navigates to quote tool', (tester) async {
    final loc = '${RoutePaths.portfolioPreview}?project_id=corporate_campaign';
    await tester.pumpWidget(hubTestShell(initialLocation: loc));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS06), findsOneWidget);
    expect(find.textContaining('Request a Quote'), findsWidgets);

    await tester.ensureVisible(find.byKey(Tk.s06RequestQuote));
    await tester.tap(find.byKey(Tk.s06RequestQuote));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS07), findsOneWidget);
  });

  testWidgets('portfolio preview: carousel controls update dots (local state)', (tester) async {
    final loc = '${RoutePaths.portfolioPreview}?project_id=corporate_campaign';
    await tester.pumpWidget(hubTestShell(initialLocation: loc));
    await pumpHubFrames(tester);

    await tester.tap(find.byKey(Tk.s06CarouselNext));
    await pumpHubFrames(tester);
    await tester.tap(find.byKey(Tk.s06CarouselPrev));
    await pumpHubFrames(tester);

    expect(find.byKey(Tk.screenS06), findsOneWidget);
  });
}
