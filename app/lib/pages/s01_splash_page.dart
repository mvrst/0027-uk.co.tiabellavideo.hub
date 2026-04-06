import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants.dart';
import '../core/test_keys.dart';
import '../router/route_paths.dart';
import '../services/hub_launcher.dart';
import '../widgets/hub_colors.dart';
import '../widgets/hub_status_bar.dart';
import '../widgets/launch_feedback.dart';

class S01SplashPage extends StatefulWidget {
  const S01SplashPage({super.key});

  @override
  State<S01SplashPage> createState() => _S01SplashPageState();
}

class _S01SplashPageState extends State<S01SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2600), _goIntro);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goIntro() {
    if (!mounted) return;
    context.go(RoutePaths.onboardingIntro);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Tk.screenS01,
      backgroundColor: HubColors.splashBg,
      body: GestureDetector(
        key: Tk.s01Continue,
        behavior: HitTestBehavior.opaque,
        onTap: _goIntro,
        child: Column(
          children: [
            const HubStatusBar(dark: true),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.videocam, size: 44, color: HubColors.charcoal),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Tiabella Production Hub',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Production Services',
                    style: TextStyle(
                      color: HubColors.lightMuted,
                      fontSize: 13,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              key: Tk.s01FooterWebsite,
              onPressed: () => context.runExternal(() => HubLauncher.openHttp(kWebsiteUrl)),
              child: Text(
                'tiabellavideo.co.uk',
                style: TextStyle(color: HubColors.muted, fontSize: 12, letterSpacing: 0.5),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
