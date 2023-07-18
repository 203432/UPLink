part of 'comment_bloc.dart';


@immutable
abstract class CommentState {}

class LoadingComment extends CommentState {}

class InitialStateComment extends CommentState {}

class LoadedComment extends CommentState {
  final List<Comment> comment;

  LoadedComment({required this.comment});
}

class ErrorComment extends CommentState {
  final String error;

  ErrorComment({required this.error});
}

class UpdatingComment extends CommentState {}

class UpdatedComment extends CommentState {}
