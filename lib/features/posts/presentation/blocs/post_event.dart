part of 'post_bloc.dart';

abstract class PostEvent {}

class GetByUserId extends PostEvent {
  final int userId;

  GetByUserId({required this.userId});
}

class Posting extends PostEvent {
  final Post post;

  Posting({required this.post});
}

class UpdatePost extends PostEvent {
  final Post post;

  UpdatePost({required this.post});
}

class DeletePost extends PostEvent {
  final String postId;

  DeletePost({required this.postId});
}