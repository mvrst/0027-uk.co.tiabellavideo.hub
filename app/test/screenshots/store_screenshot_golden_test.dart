@Tags(['store-screenshots', 'store_listing'])
import 'package:flutter_test/flutter_test.dart';
import 'package:hub/router/route_paths.dart';

import 'store_screenshot_harness.dart';

/// Play Store PNG generation via widget goldens (`flutter test ... --update-goldens`).
///
/// Run subset: `flutter test test/screenshots/store_screenshot_golden_test.dart --tags store-screenshots`
/// Tag `store_listing`: excluded in release CI (`flutter test --exclude-tags store_listing`).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Play Store widget goldens', () {
    setUp(() async {
      await prepareStoreScreenshotSession();
    });

    tearDown(finishStoreScreenshotSession);

    testWidgets('store_01_splash — S01 initial frame (timer not elapsed)', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.splash));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_01_splash.png'),
      );
    });

    testWidgets('store_02_onboarding_intro — S02', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.onboardingIntro));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_02_onboarding_intro.png'),
      );
    });

    testWidgets('store_03_dashboard — S04', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.dashboard));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_03_dashboard.png'),
      );
    });

    testWidgets('store_04_portfolio — S05', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.portfolio));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_04_portfolio.png'),
      );
    });

    testWidgets('store_05_quote — S07', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.quote));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_05_quote.png'),
      );
    });

    testWidgets('store_06_contact — S10', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.contact));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_06_contact.png'),
      );
    });

    testWidgets('store_07_settings — S13', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      await tester.pumpWidget(storeScreenshotApp(initialLocation: RoutePaths.settings));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_07_settings.png'),
      );
    });

    testWidgets('store_08_portfolio_preview — S06 corporate_campaign', (tester) async {
      await applyStoreScreenshotSurface(tester);
      addTearDown(() => resetStoreScreenshotSurface(tester));

      final loc = '${RoutePaths.portfolioPreview}?project_id=corporate_campaign';
      await tester.pumpWidget(storeScreenshotApp(initialLocation: loc));
      await pumpStoreScreenshotLayout(tester);

      await expectLater(
        findStoreScreenshotBoundary(),
        matchesGoldenFile('goldens/store_08_portfolio_preview.png'),
      );
    });
  });
}
