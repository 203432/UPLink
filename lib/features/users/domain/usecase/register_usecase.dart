import '../entities/userD.dart';
import '../repositories/user_repository.dart';

class RegisterUseCase {
  final UserRepository userRepository;

  RegisterUseCase(this.userRepository);

  Future<void> execute(UserD user) async {
    return await userRepository.createUser(user);
  }
}
