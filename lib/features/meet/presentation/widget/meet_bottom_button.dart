import 'package:flash_meeting_app/core/ui/default_button.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_event.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetBottomButton extends StatelessWidget {
  const MeetBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetBloc, MeetState>(
      builder: (context, meetState) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            if (!(meetState.meetEntity?.attendees.any(
                  (e) => e.id == userState.userEntity?.id,
                ) ??
                false)) {
              return DefaultButton(
                text: 'Join',
                onPressed: () {
                  context.read<MeetBloc>().add(JoinMeetEvent());
                },
              );
            }
            if (meetState.meetEntity?.admin.id == userState.userEntity?.id) {
              return Row(
                children: [
                  Expanded(
                    child: DefaultButton(text: 'Chat', onPressed: () {}),
                  ),
                  SizedBox(width: 10),
                  if (!(meetState.meetEntity?.isFinished ?? true))
                    IconButton(
                      onPressed: () {
                        context.read<MeetBloc>().add(CancelMeetEvent());
                      },
                      icon: Icon(CupertinoIcons.clear_circled),
                      style: IconButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.surface,
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    ),
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: DefaultButton(text: 'Chat', onPressed: () {})),
                SizedBox(width: 10),
                if (!(meetState.meetEntity?.isFinished ?? true))
                  IconButton(
                    onPressed: () {
                      context.read<MeetBloc>().add(LeaveMeetEvent());
                    },
                    icon: Icon(Icons.exit_to_app),
                    style: IconButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.surface,
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
