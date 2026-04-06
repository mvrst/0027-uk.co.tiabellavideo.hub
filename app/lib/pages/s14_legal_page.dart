import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../data/legal_data.dart';
import '../router/route_paths.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';

class S14LegalPage extends StatelessWidget {
  const S14LegalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Tk.screenS14,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HubStatusBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                TextButton.icon(
                  key: Tk.s14Back,
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(RoutePaths.settings);
                    }
                  },
                  icon: const Icon(Icons.chevron_left, color: HubColors.charcoal),
                  label: const Text('Settings', style: TextStyle(color: HubColors.charcoal)),
                ),
                const Expanded(
                  child: Text(
                    'Legal Information',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 80),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              children: [
                _sec(LegalCopy.section1Title, LegalCopy.section1Body),
                const Divider(height: 32),
                _sec(LegalCopy.section2Title, LegalCopy.section2Body),
                const Divider(height: 32),
                _sec(LegalCopy.section3Title, LegalCopy.section3Body),
                const SizedBox(height: 24),
                Text(
                  LegalCopy.footer,
                  style: const TextStyle(fontSize: 12, color: HubColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sec(String title, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
        const SizedBox(height: 10),
        Text(body, style: const TextStyle(fontSize: 13, height: 1.5, color: HubColors.muted)),
      ],
    );
  }
}
