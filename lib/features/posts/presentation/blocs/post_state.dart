part of 'post_bloc.dart';


abstract class PostState {}

class InitialState extends PostState {}

class Loading extends PostState {}

class Loaded extends PostState {
  final List<Post> posts;

  Loaded({required this.posts});
}


class Error extends PostState {
  final String error;

  Error({required this.error});
}

class Updating extends PostState {}

class Updated extends PostState {}
