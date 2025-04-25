abstract class MeetEvent {}

class GetMeetEvent extends MeetEvent {
  final String meetId;

  GetMeetEvent({required this.meetId});
}

class JoinMeetEvent extends MeetEvent {

  JoinMeetEvent();
}
