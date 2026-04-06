/// Central route registry — paths must match docs/routes.yaml
abstract final class RoutePaths {
  static const splash = '/splash';
  static const onboardingIntro = '/onboarding/intro';
  static const onboardingWorkflow = '/onboarding/workflow';
  static const dashboard = '/dashboard';
  static const portfolio = '/portfolio';
  static const portfolioProduction = '/portfolio/category/production';
  static const portfolioPostProduction = '/portfolio/category/post-production';
  static const portfolioCorporate = '/portfolio/category/corporate';
  static const portfolioPreview = '/portfolio/preview';
  static const quote = '/quote';
  static const serviceDetail = '/service/detail';
  static const workflow = '/workflow';
  static const contact = '/contact';
  static const about = '/about';
  static const ordersStatus = '/orders/status';
  static const settings = '/settings';
  static const legal = '/legal';

  static const all = <String>[
    splash,
    onboardingIntro,
    onboardingWorkflow,
    dashboard,
    portfolio,
    portfolioProduction,
    portfolioPostProduction,
    portfolioCorporate,
    portfolioPreview,
    quote,
    serviceDetail,
    workflow,
    contact,
    about,
    ordersStatus,
    settings,
    legal,
  ];
}
