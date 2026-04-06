import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
class S03OnboardingWorkflowPage extends StatelessWidget {
  const S03OnboardingWorkflowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Tk.screenS03,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HubStatusBar(),
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Image.asset(
              'assets/images/onboarding_workflow.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: HubColors.charcoal),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Follow Every Project Stage',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: HubColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Track your project from initial brief to final delivery. Request quotes, '
                    'review milestones, and stay informed throughout the production process.',
                    style: TextStyle(fontSize: 14, height: 1.6, color: HubColors.muted),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          key: Tk.s03Back,
                          onPressed: () => context.go(RoutePaths.onboardingIntro),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(0, 52),
                            side: const BorderSide(color: HubColors.border),
                          ),
                          child: const Text('Back', style: TextStyle(color: HubColors.charcoal)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          key: Tk.s03GetStarted,
                          onPressed: () => context.go(RoutePaths.dashboard),
                          style: ElevatedButton.styleFrom(minimumSize: const Size(0, 52)),
                          child: const Text('Get Started'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
