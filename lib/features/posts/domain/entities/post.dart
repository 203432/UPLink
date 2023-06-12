class Post {
  int id;
  int user;
  String text;
  String published;
  String media;
  String image;
  int num_likes;

  Post(
      {required this.id,
      required this.user,
      required this.text,
      required this.published,
      required this.media,
      required this.image,
      required this.num_likes,
      });
}
