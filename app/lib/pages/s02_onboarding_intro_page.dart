import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
class S02OnboardingIntroPage extends StatelessWidget {
  const S02OnboardingIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Tk.screenS02,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HubStatusBar(),
          SizedBox(
            height: 340,
            width: double.infinity,
            child: Image.asset(
              'assets/images/onboarding_intro.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: HubColors.charcoal,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, color: Colors.white54),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Professional Production Services',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: HubColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tiabella Production Hub gives you direct access to our services, '
                    'project workflow, and quotation tools — all in one place.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: HubColors.muted,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      key: Tk.s02Next,
                      onPressed: () => context.go(RoutePaths.onboardingWorkflow),
                      child: const Text('Next'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      key: Tk.s02Skip,
                      onPressed: () => context.go(RoutePaths.dashboard),
                      child: const Text('Skip', style: TextStyle(color: HubColors.muted)),
                    ),
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
