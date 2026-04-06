import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../data/order_status_data.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';

class S12OrderStatusPage extends StatefulWidget {
  const S12OrderStatusPage({super.key});

  @override
  State<S12OrderStatusPage> createState() => _S12OrderStatusPageState();
}

class _S12OrderStatusPageState extends State<S12OrderStatusPage> {
  int _refreshGeneration = 0;

  void _onRefresh() {
    setState(() => _refreshGeneration++);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order status view refreshed (local sample data).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS12,
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
                  'Order Status',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  key: Tk.s12Refresh,
                  icon: const Icon(Icons.refresh, color: HubColors.muted),
                  onPressed: _onRefresh,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              key: ValueKey<int>(_refreshGeneration),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: HubColors.charcoal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              OrderStatusData.projectTitle,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ref: ${OrderStatusData.reference}',
                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: 0.65,
                          minHeight: 8,
                          backgroundColor: Colors.white24,
                          color: HubColors.accentRed,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        OrderStatusData.progressLabel,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Project Milestones', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: 12),
                for (final m in OrderStatusData.milestones)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: m.highlight ? const Color(0xFFFFF8F7) : HubColors.pageBg,
                        borderRadius: BorderRadius.circular(10),
                        border: m.highlight ? Border.all(color: HubColors.accentRed.withValues(alpha: 0.3), width: 1.5) : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            m.done ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: m.done ? HubColors.charcoal : HubColors.muted,
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: Text(m.label)),
                        ],
                      ),
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
