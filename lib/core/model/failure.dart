abstract class Failure{
  final String message;
   Failure({ required this.message});
}

class AuthFailure extends Failure {
  AuthFailure({required super.message});
}

class UserFailure extends Failure {
  UserFailure({required super.message});
}

class MeetFailure extends Failure {
  MeetFailure({ required super.message});
}