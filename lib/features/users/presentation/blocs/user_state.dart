part of 'user_bloc.dart';


abstract class UserState {}

class InitialState extends UserState {}

class Loading extends UserState {}

class Loaded extends UserState {
  final User user;

  Loaded({required this.user});
}
class Error extends UserState {
  final String error;

  Error({required this.error});
}

class Updating extends UserState {}

class Updated extends UserState {}
