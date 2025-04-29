abstract class MeetEvent {}

class GetMeetEvent extends MeetEvent {
  final String meetId;

  GetMeetEvent({required this.meetId});
}

class JoinMeetEvent extends MeetEvent {
}

class KickUserEvent extends MeetEvent {
  final String userId;

  KickUserEvent({required this.userId});

}

class TransferAdminEvent extends MeetEvent {
  final String userId;

  TransferAdminEvent({required this.userId});
}

class CancelMeetEvent extends MeetEvent {

}

class LeaveMeetEvent extends MeetEvent {

}