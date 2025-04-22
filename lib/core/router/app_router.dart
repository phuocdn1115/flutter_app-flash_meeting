import 'package:flash_meeting_app/features/auth/presentation/page/auth_page.dart';
import 'package:flash_meeting_app/features/main/presentation/page/main_page.dart';
import 'package:flash_meeting_app/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: AuthPage.route,
    routes: [
      GoRoute(
        path: AuthPage.route,
        builder: (context, state) {
          return AuthPage();
        },
      ),
      GoRoute(
        path: MainPage.route,
        builder: (context, state) {
          return MainPage();
        },
      ),
      GoRoute(
        path: SplashPage.route,
        builder: (context, state) {
          return SplashPage();
        },
      ),
    ],
  );
}
