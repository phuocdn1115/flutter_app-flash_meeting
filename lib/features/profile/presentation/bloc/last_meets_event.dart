abstract class LastMeetEvent {}

class GetLastMeetsEvent extends LastMeetEvent {
  final bool refresh;

  GetLastMeetsEvent({this.refresh = false});
}
