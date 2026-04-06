import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hub/router/app_router.dart';
import 'package:hub/theme/app_theme.dart';

/// Channel used by `package:url_launcher` on common embedders (VM / test).
const MethodChannel kUrlLauncherChannel = MethodChannel('plugins.flutter.io/url_launcher');

/// Call once per test file (or in `setUpAll`) before pumping widgets that use [AppTheme.light]
/// (Google Fonts). Avoids runtime HTTP font fetches and long/fragile settles.
void configureHubTestFonts() {
  GoogleFonts.config.allowRuntimeFetching = false;
}

/// Records each launched URL from the platform channel and returns promptly (CI-safe).
void bindUrlLauncherRecording(List<String> recorded) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
    kUrlLauncherChannel,
    (MethodCall call) async {
      final args = call.arguments;
      if (args is Map && args['url'] is String) {
        recorded.add(args['url'] as String);
      }
      switch (call.method) {
        case 'launch':
        case 'launchUrl':
        case 'canLaunch':
        case 'canLaunchUrl':
          return true;
        default:
          return true;
      }
    },
  );
}

void unbindUrlLauncherMock() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(kUrlLauncherChannel, null);
}

/// Hub shell with the same routes as production [HubApp], for widget tests.
///
/// Defaults to [AppTheme.light]; pass [theme] for goldens (e.g. [AppTheme.lightForGoldens]).
Widget hubTestShell({String? initialLocation, ThemeData? theme}) {
  return MaterialApp.router(
    debugShowCheckedModeBanner: false,
    theme: theme ?? AppTheme.light,
    routerConfig: createAppRouter(initialLocation: initialLocation),
  );
}

/// Bounded frame advance — prefer over unbounded [WidgetTester.pumpAndSettle].
Future<void> pumpHubFrames(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
}

/// Lets microtasks from `runExternal` / `launchUrl` complete without idling all animations.
Future<void> pumpAsyncGap(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 32));
}
