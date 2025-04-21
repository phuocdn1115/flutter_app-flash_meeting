import 'package:equatable/equatable.dart';
import 'package:flash_meeting_app/features/auth/domain/entity/user_entity.dart';

enum UserStatus { initial, loading, success, error, logout }

class UserState extends Equatable {
  final UserStatus status;
  final String? errorMessage;
  final UserEntity? userEntity;

  const UserState._({
    required this.status,
    this.errorMessage,
    this.userEntity,
  });

  factory UserState.initial() => UserState._(status: UserStatus.initial);

  UserState copyWith({
    UserStatus? status,
    String? errorMessage,
    UserEntity? userEntity,
  }) => UserState._(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    userEntity: userEntity ?? this.userEntity,
  );

  @override
  List<Object?> get props => throw UnimplementedError();
}
