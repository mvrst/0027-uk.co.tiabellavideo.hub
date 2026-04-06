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

class S05PortfolioPage extends StatelessWidget {
  const S05PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS05,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HubStatusBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Portfolio',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  key: Tk.s05Filter,
                  icon: const Icon(Icons.tune, color: HubColors.charcoal),
                  onPressed: () => showPortfolioFilterSheet(context),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _chip(context, Tk.s05ChipAll, 'All', true, RoutePaths.portfolio),
                _chip(context, Tk.s05ChipProduction, 'Production', false, RoutePaths.portfolioProduction),
                _chip(context, Tk.s05ChipPost, 'Post-Production', false, RoutePaths.portfolioPostProduction),
                _chip(context, Tk.s05ChipCorporate, 'Corporate', false, RoutePaths.portfolioCorporate),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _PortfolioGrid(items: PortfolioData.all),
          ),
        ],
      ),
      bottomNavigationBar: BottomPillTabs(currentIndex: BottomPillTabs.indexForPath(loc)),
    );
  }

  Widget _chip(
    BuildContext context,
    Key key,
    String label,
    bool selected,
    String path,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: selected ? HubColors.charcoal : HubColors.pageBg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          key: key,
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.go(path),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: selected ? HubColors.charcoal : HubColors.border),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : HubColors.charcoal,
              ),
            ),
          ),
        ),
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
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
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
                  child: i + 1 < items.length
                      ? _tile(context, items[i + 1])
                      : const SizedBox(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _tile(BuildContext context, PortfolioItem p) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: ValueKey<String>(p.tileTestKey),
        onTap: () => context.push('${RoutePaths.portfolioPreview}?project_id=${p.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhotoPlaceholder(gradient: p.gradient, height: 150),
            const SizedBox(height: 6),
            Text(
              p.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
