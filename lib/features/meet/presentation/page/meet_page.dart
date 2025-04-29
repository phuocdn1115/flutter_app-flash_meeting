import 'package:flash_meeting_app/core/get_it/get_it.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_bloc.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_event.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_state.dart';
import 'package:flash_meeting_app/features/meet/presentation/widget/meet_attendenes_section.dart';
import 'package:flash_meeting_app/features/meet/presentation/widget/meet_bottom_button.dart';
import 'package:flash_meeting_app/features/meet/presentation/widget/meet_details_section.dart';
import 'package:flash_meeting_app/features/meet/presentation/widget/meet_location_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MeetPage extends StatelessWidget {
  final String meetId;

  const MeetPage({super.key, required this.meetId});

  static String route(String meetId) => '/meet/$meetId';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MeetBloc>()..add(GetMeetEvent(meetId: meetId)),
      child: BlocConsumer<MeetBloc, MeetState>(
        listener: (context, state) {
          if( state.status == MeetStatus.left || state.status == MeetStatus.canceled) {
            context.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Meet from ${state.meetEntity?.admin.name}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              centerTitle: false,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        MeetDetailsSection(),
                        SizedBox(height: 15),
                        MeetAttendeesSection(),
                        SizedBox(height: 15),
                        MeetLocationSection(),
                      ],
                    ),
                  ),
                  Column(children: [Spacer(), MeetBottomButton()]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
