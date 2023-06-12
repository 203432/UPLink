import '../entities/user.dart';
import '../repositories/user_repository.dart';

class ViewProfileUseCase {
  final UserRepository userRepository;

  ViewProfileUseCase(this.userRepository);

  Future<User> execute(String username) async {
    return await userRepository.findUserByUsername(username);
  }
}
