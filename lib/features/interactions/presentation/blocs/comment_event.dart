part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class GetComments extends CommentEvent {
  final int postId;

  GetComments({required this.postId});
}

class LikePost extends CommentEvent {
  final int postId;

  LikePost({required this.postId});
}

class AddComment extends CommentEvent {
  final Comment comment;

  AddComment({required this.comment});
}