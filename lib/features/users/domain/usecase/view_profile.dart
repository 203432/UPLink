import '../entities/userD.dart';
import '../repositories/user_repository.dart';

class ViewProfileUseCase {
  final UserRepository userRepository;

  ViewProfileUseCase(this.userRepository);

  Future<UserD> execute(String username, String password) async {
    return await userRepository.findUserByUsername(username);
  }
}
