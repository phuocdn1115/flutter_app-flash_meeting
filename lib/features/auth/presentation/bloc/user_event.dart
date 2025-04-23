import 'dart:io';

abstract class UserEvent {

}

class SignInWithGoogleEvent extends UserEvent {

}

class GetUserEvent extends UserEvent {

}

class SignOutEvent extends UserEvent {

}

class EditUserEvent extends UserEvent {
  final String name;
  final String bio;
  final File? avatar;

  EditUserEvent({required this.name, required this.bio, this.avatar});
}