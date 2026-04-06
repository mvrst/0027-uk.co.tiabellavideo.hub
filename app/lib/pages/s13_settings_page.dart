import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app_state.dart';
import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../services/hub_launcher.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/launch_feedback.dart';

class S13SettingsPage extends StatefulWidget {
  const S13SettingsPage({super.key});

  @override
  State<S13SettingsPage> createState() => _S13SettingsPageState();
}

class _S13SettingsPageState extends State<S13SettingsPage> {
  late bool _notif;
  late bool _emailUp;

  @override
  void initState() {
    super.initState();
    _notif = AppScope.prefs.notifications;
    _emailUp = AppScope.prefs.emailUpdates;
  }

  Future<void> _syncNotif(bool v) async {
    final prev = _notif;
    setState(() => _notif = v);
    final ok = await AppScope.prefs.setNotifications(v);
    if (!mounted) return;
    if (!ok) {
      setState(() => _notif = prev);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not update notification preference.')),
      );
    }
  }

  Future<void> _syncEmail(bool v) async {
    final prev = _emailUp;
    setState(() => _emailUp = v);
    final ok = await AppScope.prefs.setEmailUpdates(v);
    if (!mounted) return;
    if (!ok) {
      setState(() => _emailUp = prev);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not update email preference.')),
      );
    }
  }

  /// Opens exactly `kPrivacyPolicyUrl` via [HubLauncher.openPrivacyPolicy] only.
  Future<void> _openPrivacy() async {
    await context.runExternal(
      HubLauncher.openPrivacyPolicy,
      failureMessage: 'Could not open privacy policy in a browser.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS13,
      backgroundColor: HubColors.pageBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HubStatusBar(),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: const Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'PREFERENCES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: HubColors.muted,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      SwitchListTile(
                        key: Tk.s13Notif,
                        title: const Text('Notifications'),
                        secondary: const Icon(Icons.notifications_outlined),
                        value: _notif,
                        onChanged: (v) {
                          _syncNotif(v);
                        },
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        key: Tk.s13EmailUpdates,
                        title: const Text('Email Updates'),
                        secondary: const Icon(Icons.mail_outline),
                        value: _emailUp,
                        onChanged: (v) {
                          _syncEmail(v);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'LEGAL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: HubColors.muted,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        key: Tk.s13Privacy,
                        leading: const Icon(Icons.shield_outlined),
                        title: const Text('Privacy Policy'),
                        trailing: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('External', style: TextStyle(fontSize: 11, color: HubColors.muted)),
                            SizedBox(width: 4),
                            Icon(Icons.open_in_new, size: 14, color: HubColors.muted),
                          ],
                        ),
                        onTap: _openPrivacy,
                      ),
                      const Divider(height: 1),
                      ListTile(
                        key: Tk.s13About,
                        leading: const Icon(Icons.info_outline),
                        title: const Text('About Us'),
                        trailing: const Icon(Icons.chevron_right, color: HubColors.lightMuted),
                        onTap: () => context.push(RoutePaths.about),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        key: Tk.s13Legal,
                        leading: const Icon(Icons.description_outlined),
                        title: const Text('Legal Information'),
                        trailing: const Icon(Icons.chevron_right, color: HubColors.lightMuted),
                        onTap: () => context.push(RoutePaths.legal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    key: Tk.s13SignOut,
                    onPressed: () async {
                      try {
                        final ok = await AppScope.prefs.clearSession();
                        if (!context.mounted) return;
                        if (!ok) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Could not sign out (storage error).')),
                          );
                          return;
                        }
                        context.go(RoutePaths.splash);
                      } catch (_) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Could not sign out (storage error).')),
                        );
                      }
                    },
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPillTabs(currentIndex: BottomPillTabs.indexForPath(loc)),
    );
  }
}
