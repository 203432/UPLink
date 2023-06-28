import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required int id_user,
      required String first_name,
      required String last_name,
      required String username,
      required String email,
      required String password,
      required int id_profile,
      required String url_image,
      required String description,
      required List<int> friends})
      : super(
            id_user: id_user,
            first_name: first_name,
            last_name: last_name,
            username: username,
            email: email,
            password: password,
            id_profile: id_profile,
            url_image: url_image,
            description: description,
            friends: friends);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id_user: json['id_user'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        id_profile: json['id_profile'],
        url_image: json['url_image'],
        description: json['description'],
        friends: json['friends']);
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id_user: user.id_user,
      first_name: user.first_name,
      last_name: user.last_name,
      username: user.username,
      email: user.email,
      password: user.password,
      id_profile: user.id_profile,
      url_image: user.url_image,
      description: user.description,
      friends: user.friends,
    );
  }
}
