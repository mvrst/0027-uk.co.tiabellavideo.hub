import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hub/app_state.dart';
import 'package:hub/main.dart';
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

  testWidgets('HubApp builds with splash', (tester) async {
    await tester.pumpWidget(const HubApp());
    await pumpHubFrames(tester);

    expect(find.textContaining('Tiabella'), findsWidgets);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
