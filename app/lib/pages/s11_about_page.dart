import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants.dart';
import '../core/test_keys.dart';
import '../services/hub_launcher.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/launch_feedback.dart';

class S11AboutPage extends StatelessWidget {
  const S11AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS11,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HubStatusBar(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text('About Us', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: HubColors.charcoal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.videocam, color: HubColors.charcoal),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tiabella',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Production services',
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Who We Are', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const Text(
                  'Tiabella is a professional production services company providing video production, '
                  'post-production, and related services to businesses and organisations.\n\n'
                  'We work with clients across corporate, commercial, and documentary sectors, managing '
                  'projects from initial brief through to final delivery.',
                  style: TextStyle(fontSize: 13, height: 1.6, color: HubColors.muted),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  child: Material(
                    color: HubColors.pageBg,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      key: Tk.s11Maps,
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => context.runExternal(HubLauncher.openMapsSearch),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map, size: 32, color: HubColors.muted),
                            SizedBox(height: 8),
                            Text('Open in Maps', style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  key: Tk.s11Email,
                  leading: const Icon(Icons.email),
                  title: const Text(kEmail),
                  onTap: () => context.runExternal(HubLauncher.sendEmail),
                ),
                ListTile(
                  key: Tk.s11Web,
                  leading: const Icon(Icons.language),
                  title: const Text(kWebsiteHostDisplay),
                  onTap: () => context.runExternal(() => HubLauncher.openHttp(kWebsiteUrl)),
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
