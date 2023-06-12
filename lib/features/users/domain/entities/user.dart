class User{
  int id_user;
  String first_name;
  String last_name;
  String username;
  String email;
  String password;
  int id_profile;
  String url_image;
  // List<int> friendsList;
  String description;

  User({
    required this.id_user,
    required this.first_name,
    required this.last_name,
    required this.username,
    required this.email,
    required this.password,
    required this.id_profile,
    required this.url_image,
    // required this.friendsList,
    required this.description,
  });
}
