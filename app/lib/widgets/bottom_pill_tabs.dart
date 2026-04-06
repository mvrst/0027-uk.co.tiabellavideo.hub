import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/route_paths.dart';
import '../core/test_keys.dart';
import 'hub_colors.dart';

/// Pill tab bar — keys TK_TAB_* shared across tab-hosting screens (contract).
class BottomPillTabs extends StatelessWidget {
  const BottomPillTabs({
    super.key,
    required this.currentIndex,
  });

  /// 0 HOME, 1 PORTFOLIO, 2 QUOTE, 3 STATUS, 4 MORE
  final int currentIndex;

  static int indexForPath(String location) {
    if (location.startsWith(RoutePaths.dashboard)) return 0;
    if (location.contains('/portfolio')) return 1;
    if (location.startsWith(RoutePaths.quote)) return 2;
    if (location.startsWith(RoutePaths.ordersStatus)) return 3;
    if (location.startsWith(RoutePaths.settings)) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(21, 12, 21, 21),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(36),
          border: Border.all(color: HubColors.border),
        ),
        child: Row(
          children: [
            _pill(context, 0, 'HOME', Tk.tabHome, RoutePaths.dashboard),
            _pill(context, 1, 'PORTFOLIO', Tk.tabPortfolio, RoutePaths.portfolio),
            _pill(context, 2, 'QUOTE', Tk.tabQuote, RoutePaths.quote),
            _pill(context, 3, 'STATUS', Tk.tabStatus, RoutePaths.ordersStatus),
            _pill(context, 4, 'MORE', Tk.tabMore, RoutePaths.settings),
          ],
        ),
      ),
    );
  }

  Widget _pill(
    BuildContext context,
    int i,
    String label,
    ValueKey<String> key,
    String path,
  ) {
    final sel = currentIndex == i;
    return Expanded(
      child: Material(
        color: sel ? HubColors.charcoal : Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          key: key,
          onTap: () => context.go(path),
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: sel ? Colors.white : HubColors.muted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
