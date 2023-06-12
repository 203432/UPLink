part of 'comment_bloc.dart';


@immutable
abstract class CommentState {}

class Loading extends CommentState {}

class InitialState extends CommentState {}

class Loaded extends CommentState {
  final List<Comment> comment;

  Loaded({required this.comment});
}

class Error extends CommentState {
  final String error;

  Error({required this.error});
}

class Updating extends CommentState {}

class Updated extends CommentState {}
