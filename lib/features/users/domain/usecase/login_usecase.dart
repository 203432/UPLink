import 'package:uplink/features/users/domain/entities/userD.dart';

import '../repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase(this.userRepository);

  Future<UserD> execute(String username, String password) async {
    return await userRepository.findUserByUsername(username);
  }
}
