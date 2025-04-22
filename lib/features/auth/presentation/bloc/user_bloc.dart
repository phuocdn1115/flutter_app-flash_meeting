import 'dart:async';

import 'package:flash_meeting_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flash_meeting_app/features/auth/domain/repository/user_repository.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_event.dart';
import 'package:flash_meeting_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  UserBloc({required this.authRepository, required this.userRepository})
    : super(UserState.initial()) {
    on<SignInWithGoogleEvent>(onSignInWithGoogleEvent);
    on<GetUserEvent>(onGetUserEvent);
  }

  Future onSignInWithGoogleEvent(
    SignInWithGoogleEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await authRepository.signInWithGoogle();
    result.fold(
      (l) {
        emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: UserStatus.success, userEntity: r));
      },
    );
  }

  Future onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserStatus.loading));
    var result = await userRepository.getUser();
    result.fold(
      (l) {
        emit(state.copyWith(status: UserStatus.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(status: UserStatus.success, userEntity: r));
      },
    );
  }
}
