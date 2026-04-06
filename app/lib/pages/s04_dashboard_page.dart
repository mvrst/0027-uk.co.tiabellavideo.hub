import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../widgets/bottom_pill_tabs.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/photo_placeholder.dart';

class S04DashboardPage extends StatelessWidget {
  const S04DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: Tk.screenS04,
      backgroundColor: HubColors.pageBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const HubStatusBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: HubColors.charcoal,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.videocam, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Tiabella',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/dashboard_banner.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const HeroPhotoPlaceholder(
                        height: 180,
                        gradient: [Color(0xFF2D3436), Color(0xFF636E72)],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.45),
                            Colors.black.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Production Hub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Services · Portfolio · Quotes',
                      style: TextStyle(
                        color: Color(0xAAFFFFFF),
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Our Services',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _ServiceCard(
                                key: Tk.s04CardVideo,
                                title: 'Video Production',
                                subtitle: 'From brief to screen',
                                dark: true,
                                onTap: () => context.push(RoutePaths.serviceDetail),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _ServiceCard(
                                key: Tk.s04CardPost,
                                title: 'Post Production',
                                subtitle: 'Editing & delivery',
                                dark: false,
                                onTap: () => context.go(
                                  '${RoutePaths.quote}?initial_project_type=post_production',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: HubColors.pageBg,
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quick Access',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 12),
                        _qaRow(context, [
                          _Qa(Tk.s04QuickServices, Icons.business_center, 'Services', () => context.push(RoutePaths.serviceDetail)),
                          _Qa(Tk.s04QuickPortfolio, Icons.image, 'Portfolio', () => context.go(RoutePaths.portfolio)),
                          _Qa(Tk.s04QuickQuote, Icons.description, 'Quote', () => context.go(RoutePaths.quote)),
                        ]),
                        const SizedBox(height: 10),
                        _qaRow(context, [
                          _Qa(Tk.s04QuickWorkflow, Icons.account_tree, 'Workflow', () => context.go(RoutePaths.workflow)),
                          _Qa(Tk.s04QuickStatus, Icons.inventory_2, 'Order Status', () => context.go(RoutePaths.ordersStatus)),
                          _Qa(Tk.s04QuickContact, Icons.phone, 'Contact', () => context.go(RoutePaths.contact)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomPillTabs(currentIndex: BottomPillTabs.indexForPath(loc)),
    );
  }
}

class _Qa {
  const _Qa(this.key, this.icon, this.label, this.onTap);
  final Key key;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

Widget _qaRow(BuildContext context, List<_Qa> items) {
  return Row(
    children: items
        .map(
          (q) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: _QuickTile(key: q.key, icon: q.icon, label: q.label, onTap: q.onTap),
            ),
          ),
        )
        .toList(),
  );
}

class _QuickTile extends StatelessWidget {
  const _QuickTile({super.key, required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: HubColors.charcoal),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dark,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool dark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? HubColors.charcoal : HubColors.cardGrey;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: dark ? HubColors.lightMuted : const Color(0xFFDFE6E9),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
