import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/photo_placeholder.dart';

class S08ServiceDetailPage extends StatelessWidget {
  const S08ServiceDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Tk.screenS08,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              const HeroPhotoPlaceholder(
                height: 240,
                gradient: [Color(0xFF2D3436), Color(0xFF636E72)],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: const HubStatusBar(dark: true),
              ),
              Positioned(
                top: 56,
                left: 12,
                child: TextButton.icon(
                  key: Tk.s08Back,
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(RoutePaths.dashboard);
                    }
                  },
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  label: const Text('Services', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Wrap(
                  spacing: 8,
                  children: ['Corporate', 'Commercial', 'Documentary']
                      .map((t) => Chip(label: Text(t, style: const TextStyle(fontSize: 11))))
                      .toList(),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Full-Service Video Production',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                const Text(
                  'End-to-end production from initial concept and scripting through to shooting and delivery. '
                  'We work with businesses of all sizes across corporate, commercial, and documentary formats.',
                  style: TextStyle(fontSize: 13, height: 1.6, color: HubColors.muted),
                ),
                const Divider(height: 32),
                const Text("What's Included", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 12),
                for (final line in const [
                  'Creative development & scripting',
                  'Professional filming crew & equipment',
                  'Post-production editing & colour',
                  'Delivery in agreed formats',
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 18, color: HubColors.charcoal),
                        const SizedBox(width: 8),
                        Expanded(child: Text(line, style: const TextStyle(fontSize: 13))),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: HubColors.pageBg,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Pricing is scoped per project. Use the quote tool for an indicative request.',
                    style: TextStyle(fontSize: 13, color: HubColors.muted),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    key: Tk.s08GetQuote,
                    onPressed: () => context.go(
                      '${RoutePaths.quote}?initial_project_type=video_production',
                    ),
                    child: const Text('Get a Quote for This Service'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
