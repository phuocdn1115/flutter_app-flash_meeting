import 'package:equatable/equatable.dart';
import 'package:flash_meeting_app/features/auth/domain/entity/user_entity.dart';
import 'package:flash_meeting_app/features/meet/domain/entity/meet_entity.dart';

enum LastMeetStatus { initial, loading, success, error }

class LastMeetsState extends Equatable {
  final LastMeetStatus status;
  final String? errorMessage;
  final List<MeetEntity>? lastMeets;
  final int currentPage;
  final bool isLastPage;

  LastMeetsState._({
    required this.status,
    this.errorMessage,
    this.lastMeets,
    this.currentPage = 1,
    this.isLastPage = false,
  });

  factory LastMeetsState.initial() =>
      LastMeetsState._(status: LastMeetStatus.initial);

  LastMeetsState copyWith({
    LastMeetStatus? status,
    String? errorMessage,
    List<MeetEntity>? lastMeets,
    int? currentPage,
    bool? isLastPage,
  }) => LastMeetsState._(
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    lastMeets: lastMeets ?? this.lastMeets,
    currentPage: currentPage ?? this.currentPage,
    isLastPage: isLastPage ?? this.isLastPage,
  );

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    lastMeets,
    currentPage,
    isLastPage,
  ];
}
