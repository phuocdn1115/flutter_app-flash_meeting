import 'package:equatable/equatable.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';

enum CreateMeetStatus { initial, loading, success, error }

class CreateMeetState  extends Equatable {
  final CreateMeetStatus status;
  final String? errorMessage;
  final MeetEntity? meetEntity;

  CreateMeetState._({required this.status, this.errorMessage, this.meetEntity});

  factory CreateMeetState.initial() =>
      CreateMeetState._(status: CreateMeetStatus.initial);

  CreateMeetState copyWith({
    CreateMeetStatus? status,
    String? errorMessage,
    MeetEntity? meetEntity,
  }) => CreateMeetState._(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    meetEntity: meetEntity ?? this.meetEntity,
  );

  @override
  List<Object?> get props => [status, errorMessage, meetEntity];
}
