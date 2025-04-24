import 'package:flash_meeting_app/features/auth/presentation/page/auth_page.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/page/create_meet_page.dart';
import 'package:flash_meeting_app/features/create_meet/presentation/page/location_picker_page.dart';
import 'package:flash_meeting_app/features/main/presentation/page/main_page.dart';
import 'package:flash_meeting_app/features/profile/presentation/page/edit_profile_page.dart';
import 'package:flash_meeting_app/features/profile/presentation/page/profile_page.dart';
import 'package:flash_meeting_app/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static var router = GoRouter(
    initialLocation: SplashPage.route,
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
      GoRoute(
        path: ProfilePage.route,
        builder: (context, state) {
          return ProfilePage();
        },
      ),
      GoRoute(
        path: EditProfilePage.route,
        builder: (context, state) {
          return EditProfilePage();
        },
      ),
      GoRoute(
        path: CreateMeetPage.route,
        builder: (context, state) {
          return CreateMeetPage();
        },
      ),
      GoRoute(
        path: LocationPickerPage.route,
        builder: (context, state) {
          return LocationPickerPage();
        },
      ),
    ],
  );
}
