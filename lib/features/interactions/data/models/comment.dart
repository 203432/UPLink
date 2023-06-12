import '../../domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required int id,
    required int user,
    required int post,
    required String text,

  }) : super(
            id: id,
            user: user,
            post: post,
            text: text,);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      user: json['json'],
      post: json['post'],
      text: json['text'],
    );
  }

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
        id: comment.id,
        user: comment.user,
        post: comment.post,
        text: comment.text,);
  }
}
