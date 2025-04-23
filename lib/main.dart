import 'package:firebase_core/firebase_core.dart';
import 'package:flash_meeting_app/core/get_it/get_it.dart';
import 'package:flash_meeting_app/core/router/app_router.dart';
import 'package:flash_meeting_app/core/theme/app_theme.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meeting_app/features/auth/presentation/page/auth_page.dart';
import 'package:flash_meeting_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUp();
  runApp(
    BlocProvider(
      create: (context) => getIt<UserBloc>()..add(GetUserEvent()),
      child: MaterialApp.router(
        theme: AppTheme.getTheme(),
        builder: (context, widget) {
          return BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if(state.status == UserStatus.error || state.status == UserStatus.logout) {
                  AppRouter.router.go(AuthPage.route);
                }
              }, child: Center(child: widget,)
          );
        },
        routerConfig: AppRouter.router,
      ),
    ),
  );
}
