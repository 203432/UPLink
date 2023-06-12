import 'package:uplink/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required int id,
    required int user,
    required String text,
    required String published,
    required String media,
    required String image,
    required int num_likes,
  }) : super(
            id: id,
            user: user,
            text: text,
            published: published,
            media: media,
            image: image,
            num_likes: num_likes);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      user: json['json'],
      text: json['text'],
      published: json['publshed'],
      media: json['media'],
      image: json['image'],
      num_likes: json['num_likes'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
        id: post.id,
        user: post.user,
        text: post.text,
        published: post.published,
        media: post.media,
        image: post.image,
        num_likes: post.num_likes);
  }
}
