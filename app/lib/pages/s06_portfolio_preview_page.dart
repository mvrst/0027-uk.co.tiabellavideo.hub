import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../core/test_keys.dart';
import '../data/portfolio_data.dart';
import '../router/route_paths.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/photo_placeholder.dart';

class S06PortfolioPreviewPage extends StatefulWidget {
  const S06PortfolioPreviewPage({super.key, this.projectId});

  final String? projectId;

  @override
  State<S06PortfolioPreviewPage> createState() => _S06PortfolioPreviewPageState();
}

class _S06PortfolioPreviewPageState extends State<S06PortfolioPreviewPage> {
  int _slide = 0;

  @override
  Widget build(BuildContext context) {
    final item = PortfolioData.byId(widget.projectId) ?? PortfolioData.defaultPreview;
    return Scaffold(
      key: Tk.screenS06,
      backgroundColor: const Color(0xFF0A0A0A),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HubStatusBar(dark: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  key: Tk.s06Back,
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(RoutePaths.portfolio);
                    }
                  },
                  icon: const Icon(Icons.chevron_left, color: Colors.white70),
                  label: const Text('Portfolio', style: TextStyle(color: Colors.white)),
                ),
                IconButton(
                  key: Tk.s06Share,
                  icon: const Icon(Icons.share, color: Colors.white70),
                  onPressed: () async {
                    try {
                      await Share.share('${item.title} — Tiabella Production Hub');
                    } catch (_) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open the share sheet.')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          PhotoPlaceholder(gradient: item.gradient, height: 360, borderRadius: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  key: Tk.s06CarouselPrev,
                  icon: const Icon(Icons.chevron_left, color: Colors.white54, size: 28),
                  onPressed: () => setState(() => _slide = (_slide + 2) % 3),
                ),
                Row(
                  children: List.generate(
                    3,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: i == _slide ? Colors.white : Colors.white24,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  key: Tk.s06CarouselNext,
                  icon: const Icon(Icons.chevron_right, color: Colors.white54, size: 28),
                  onPressed: () => setState(() => _slide = (_slide + 1) % 3),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.tags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: item.tags
                        .map((t) => Chip(
                              label: Text(t, style: const TextStyle(fontSize: 11)),
                              backgroundColor: Colors.white12,
                              labelStyle: const TextStyle(color: Colors.white70),
                            ))
                        .toList(),
                  ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.subtitle ??
                      'Full production from concept development through to final delivery.',
                  style: const TextStyle(color: HubColors.lightMuted, fontSize: 13, height: 1.6),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                key: Tk.s06RequestQuote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: HubColors.accentRed,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => context.go(RoutePaths.quote),
                child: const Text('Request a Quote'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
