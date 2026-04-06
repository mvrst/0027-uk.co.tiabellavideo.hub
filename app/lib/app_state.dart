import 'services/prefs_service.dart';

/// Global app services (no DI package; contract-sized app).
///
/// [prefs] is not `late final` so integration/widget tests can rebind it per test.
class AppScope {
  static late PrefsService prefs;
}
