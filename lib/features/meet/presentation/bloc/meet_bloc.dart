import 'dart:async';

import 'package:flash_meeting_app/features/meet/domain/repository/meet_repository.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_event.dart';
import 'package:flash_meeting_app/features/meet/presentation/bloc/meet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetBloc extends Bloc<MeetEvent, MeetState> {
  final MeetRepository meetRepository;

  MeetBloc({required this.meetRepository}) : super(MeetState.initial()) {
    on<GetMeetEvent>(onGetMeetEvent);
    on<JoinMeetEvent>(onJoinMeetEvent);
  }

  Future onGetMeetEvent(GetMeetEvent event, Emitter<MeetState> emit) async {
    emit(state.copyWith(status: MeetStatus.loading));
    var result = await meetRepository.getMeet(event.meetId);
    result.fold(
      (l) {
        emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: MeetStatus.success, meetEntity: r));
      },
    );
  }

  Future onJoinMeetEvent(JoinMeetEvent event, Emitter<MeetState> emit) async {
    if (state.meetEntity == null) {
      return;
    }
    emit(state.copyWith(status: MeetStatus.loading));
    var result = await meetRepository.joinMeet(state.meetEntity!.id);
    result.fold(
      (l) {
        emit(state.copyWith(status: MeetStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: MeetStatus.success));
        add(GetMeetEvent(meetId: state.meetEntity!.id));
      },
    );
  }
}
