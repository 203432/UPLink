import '../../domain/entities/authentication.dart';
import '../../domain/entities/user.dart';

class AuthenticationModel extends Authentication {
  AuthenticationModel({
    required String token,
    required String user_id,

  }) : super(
            token: token,
            user_id: user_id,
            );

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
        token: json['token'],
        user_id: json['user_id'],
        );
  }

  factory AuthenticationModel.fromEntity(Authentication authentication) {
    return AuthenticationModel(
        token: authentication.token,
        user_id: authentication.user_id,
);
  }
}
