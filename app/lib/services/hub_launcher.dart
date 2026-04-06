import 'package:url_launcher/url_launcher.dart';

import '../core/constants.dart';

class HubLauncher {
  static Future<bool> openHttp(String url) async {
    final uri = Uri.parse(url);
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// Privacy policy — `<PRIVACY_POLICY_URL>` byte-for-byte via [kPrivacyPolicyUrl] only.
  static Future<bool> openPrivacyPolicy() {
    return launchUrl(
      Uri.parse(kPrivacyPolicyUrl),
      mode: LaunchMode.externalApplication,
    );
  }

  static Future<bool> dialPhone() => launchUrl(Uri.parse(kPhoneTel));

  static Future<bool> sendEmail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: kEmail,
    );
    return launchUrl(uri);
  }

  static Future<bool> openMapsSearch() async {
    final q = Uri.encodeComponent(kMapsSearchQuery);
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$q');
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
