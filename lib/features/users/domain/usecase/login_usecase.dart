import 'package:uplink/features/users/domain/entities/authentication.dart';

import '../repositories/user_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase(this.userRepository);

  Future<Authentication> execute(String username, String password) async {
    return await userRepository.login(username, password);
  }
}
