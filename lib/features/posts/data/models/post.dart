import 'package:uplink/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required int id,
    required int user,
    required String text,
    required String published,
    required String media,
    required String image,
    required String location,
    required int num_likes,
    required String first_name,
    required String last_name,
    required String url_image
  }) : super(
            id: id,
            user: user,
            text: text,
            published: published,
            media: media,
            image: image,
            location: location,
            num_likes: num_likes,
            first_name: first_name,
            last_name:last_name,
            url_image:url_image);

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      user: json['json'],
      text: json['text'],
      published: json['publshed'],
      media: json['media'],
      image: json['image'],
      location: json['location'],
      num_likes: json['num_likes'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      url_image: json['url_image']
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
        location: post.location,
        num_likes: post.num_likes,
        first_name: post.first_name,
        last_name: post.last_name,
        url_image: post.url_image);
  }
}
