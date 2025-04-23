import 'package:flash_meeting_app/core/ui/default_modal_bottom_sheet.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meeting_app/features/profile/presentation/page/edit_profile_page.dart';
import 'package:flash_meeting_app/features/profile/presentation/widget/circle_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return DefaultModalBottomSheet(
                        elements: [
                          ListTile(
                            leading: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            title: Text("Edit profile"),
                            onTap: () {
                              context.pop();
                              context.push(EditProfilePage.route);
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Theme.of(context).colorScheme.error,
                            ),
                            title: Text("Sign out"),
                            onTap: () {
                              context.read<UserBloc>().add(SignOutEvent());
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.more_vert),
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleUserAvatar(
                        height: 100,
                        width: 100,
                        url: state.userEntity?.avatar,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${state.userEntity?.name}',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '${state.userEntity?.email}',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    state.userEntity?.bio ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text('Last meets', style:  Theme.of(context).textTheme.headlineSmall,),
                  SizedBox(height: 10,),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
