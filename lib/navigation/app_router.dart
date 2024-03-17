import 'package:go_router/go_router.dart';
import 'package:musicy/features/bottom_navigation/presentation/pages/main_navigation_page.dart';

final router = GoRouter(
  initialLocation: "/main-navigation",
  routes: [
    GoRoute(
      name: "main-navigation",
      path: "/main-navigation",
      builder: (context, state) => const MainNavigationPage(),
    ),
  ],
);
