part of 'user_bloc.dart';

abstract class UserEvent {}

class GetByUsername extends UserEvent {
  final int userId;

  GetByUsername({required this.userId});
}

class Login extends UserEvent {
  final String username;
  final String password;

  Login({required this.username, required this.password});
}

class Register extends UserEvent {
  final User user;

  Register({required this.user});
}
