import 'services/prefs_service.dart';

/// Global app services (no DI package; contract-sized app).
class AppScope {
  static late final PrefsService prefs;
}
