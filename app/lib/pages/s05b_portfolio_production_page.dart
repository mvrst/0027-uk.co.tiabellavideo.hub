import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../data/portfolio_data.dart';
import '../models/portfolio_item.dart';
import '../router/route_paths.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/photo_placeholder.dart';
import '../widgets/portfolio_filter_sheet.dart';

class S05bPortfolioProductionPage extends StatelessWidget {
  const S05bPortfolioProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS05b,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HubStatusBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                TextButton.icon(
                  key: Tk.s05bBack,
                  onPressed: () => context.go(RoutePaths.portfolio),
                  icon: const Icon(Icons.chevron_left, color: HubColors.charcoal),
                  label: const Text('Portfolio', style: TextStyle(color: HubColors.charcoal)),
                ),
                const Spacer(),
                IconButton(
                  key: Tk.s05bFilter,
                  icon: const Icon(Icons.tune),
                  onPressed: () => showPortfolioFilterSheet(context),
                ),
              ],
            ),
          ),
          _chips(context),
          Expanded(
            child: _PortfolioGrid(items: PortfolioData.production),
          ),
        ],
      ),
      bottomNavigationBar: BottomPillTabs(currentIndex: BottomPillTabs.indexForPath(loc)),
    );
  }

  Widget _chips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _c(context, const ValueKey('TK_S05B_CHIP_ALL'), 'All', RoutePaths.portfolio),
          _c(context, const ValueKey('TK_S05B_CHIP_PRODUCTION'), 'Production', RoutePaths.portfolioProduction, sel: true),
          _c(context, const ValueKey('TK_S05B_CHIP_POST'), 'Post-Production', RoutePaths.portfolioPostProduction),
          _c(context, const ValueKey('TK_S05B_CHIP_CORPORATE'), 'Corporate', RoutePaths.portfolioCorporate),
        ],
      ),
    );
  }

  Widget _c(BuildContext context, Key key, String label, String path, {bool sel = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        key: key,
        label: Text(label),
        selected: sel,
        onSelected: (_) => context.go(path),
        selectedColor: HubColors.charcoal,
        labelStyle: TextStyle(color: sel ? Colors.white : HubColors.charcoal, fontSize: 13),
      ),
    );
  }
}

class _PortfolioGrid extends StatelessWidget {
  const _PortfolioGrid({required this.items});
  final List<PortfolioItem> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        for (var i = 0; i < items.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _tile(context, items[i])),
                const SizedBox(width: 12),
                Expanded(
                  child: i + 1 < items.length ? _tile(context, items[i + 1]) : const SizedBox(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _tile(BuildContext context, PortfolioItem p) {
    return Material(
      child: InkWell(
        key: ValueKey<String>(p.tileTestKey),
        onTap: () => context.push('${RoutePaths.portfolioPreview}?project_id=${p.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoPlaceholder(gradient: p.gradient, height: 160),
            const SizedBox(height: 6),
            Text(p.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
            if (p.subtitle != null)
              Text(p.subtitle!, style: const TextStyle(fontSize: 11, color: HubColors.muted)),
          ],
        ),
      ),
    );
  }
}

