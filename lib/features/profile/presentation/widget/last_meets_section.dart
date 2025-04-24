import 'package:flash_meeting_app/features/profile/presentation/bloc/last_meets_bloc.dart';
import 'package:flash_meeting_app/features/profile/presentation/bloc/last_meets_state.dart';
import 'package:flash_meeting_app/features/profile/presentation/widget/last_meet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LastMeetsSection extends StatelessWidget {
  const LastMeetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LastMeetsBloc, LastMeetsState>(
      builder: (context, state) {
        return ListView.builder(itemBuilder: (context, index) {
          return LastMeetWidget(meetEntity: state.lastMeets![index]);
        }, itemCount: state.lastMeets?.length ?? 0, shrinkWrap: true,);
      },
    );
  }
}
