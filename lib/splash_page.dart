import 'package:flash_meeting_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meeting_app/features/main/presentation/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String route = '/splash';
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        print("************************************** STATE ${state.status}");
        if(state.status == UserStatus.success) {
          context.go(MainPage.route);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Text(
            'FlashMeet',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: Theme.of(context).colorScheme.surface,
              fontSize: 50,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
