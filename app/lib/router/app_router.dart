import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/quote_selection.dart';
import '../pages/s01_splash_page.dart';
import '../pages/s02_onboarding_intro_page.dart';
import '../pages/s03_onboarding_workflow_page.dart';
import '../pages/s04_dashboard_page.dart';
import '../pages/s05_portfolio_page.dart';
import '../pages/s05b_portfolio_production_page.dart';
import '../pages/s05c_portfolio_post_page.dart';
import '../pages/s05d_portfolio_corporate_page.dart';
import '../pages/s06_portfolio_preview_page.dart';
import '../pages/s07_quote_tool_page.dart';
import '../pages/s08_service_detail_page.dart';
import '../pages/s09_workflow_page.dart';
import '../pages/s10_contact_page.dart';
import '../pages/s11_about_page.dart';
import '../pages/s12_order_status_page.dart';
import '../pages/s13_settings_page.dart';
import '../pages/s14_legal_page.dart';
import 'route_paths.dart';

/// Central route registry — mirrors [RoutePaths] / docs/routes.yaml.
///
/// [initialLocation] is optional for tests and tooling; production uses [RoutePaths.splash].
GoRouter createAppRouter({String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation ?? RoutePaths.splash,
    routes: <RouteBase>[
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const S01SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.onboardingIntro,
        builder: (context, state) => const S02OnboardingIntroPage(),
      ),
      GoRoute(
        path: RoutePaths.onboardingWorkflow,
        builder: (context, state) => const S03OnboardingWorkflowPage(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        builder: (context, state) => const S04DashboardPage(),
      ),
      GoRoute(
        path: RoutePaths.portfolio,
        builder: (context, state) => const S05PortfolioPage(),
      ),
      GoRoute(
        path: RoutePaths.portfolioProduction,
        builder: (context, state) => const S05bPortfolioProductionPage(),
      ),
      GoRoute(
        path: RoutePaths.portfolioPostProduction,
        builder: (context, state) => const S05cPortfolioPostPage(),
      ),
      GoRoute(
        path: RoutePaths.portfolioCorporate,
        builder: (context, state) => const S05dPortfolioCorporatePage(),
      ),
      GoRoute(
        path: RoutePaths.portfolioPreview,
        builder: (context, state) {
          final id = state.uri.queryParameters['project_id'];
          return S06PortfolioPreviewPage(projectId: id);
        },
      ),
      GoRoute(
        path: RoutePaths.quote,
        builder: (context, state) {
          final q = state.uri.queryParameters;
          return S07QuoteToolPage(
            initialType: ProjectTypeKindX.fromQuery(q['initial_project_type']),
            initialDuration: DurationKindX.fromQuery(q['initial_duration']),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.serviceDetail,
        builder: (context, state) => const S08ServiceDetailPage(),
      ),
      GoRoute(
        path: RoutePaths.workflow,
        builder: (context, state) => const S09WorkflowPage(),
      ),
      GoRoute(
        path: RoutePaths.contact,
        builder: (context, state) => const S10ContactPage(),
      ),
      GoRoute(
        path: RoutePaths.about,
        builder: (context, state) => const S11AboutPage(),
      ),
      GoRoute(
        path: RoutePaths.ordersStatus,
        builder: (context, state) => const S12OrderStatusPage(),
      ),
      GoRoute(
        path: RoutePaths.settings,
        builder: (context, state) => const S13SettingsPage(),
      ),
      GoRoute(
        path: RoutePaths.legal,
        builder: (context, state) => const S14LegalPage(),
      ),
    ],
  );
}
