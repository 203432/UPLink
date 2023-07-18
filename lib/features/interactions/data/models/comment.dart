import '../../domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    required int id,
    required int user,
    required int post,
    required String text,
    required String first_name,
    required String last_name,
    required String url_image

  }) : super(
            id: id,
            user: user,
            post: post,
            text: text,
            first_name: first_name,
            last_name:last_name,
            url_image:url_image);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      user: json['json'],
      post: json['post'],
      text: json['text'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      url_image: json['url_image']
    );
  }

  factory CommentModel.fromEntity(Comment comment) {
    return CommentModel(
        id: comment.id,
        user: comment.user,
        post: comment.post,
        text: comment.text,
        first_name: comment.first_name,
        last_name: comment.last_name,
        url_image: comment.url_image);
  }
}
