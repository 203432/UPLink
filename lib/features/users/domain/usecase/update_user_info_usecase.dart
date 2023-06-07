import '../entities/userD.dart';
import '../repositories/user_repository.dart';

class UpdateUserInfoUseCase {
  final UserRepository userRepository;

  UpdateUserInfoUseCase(this.userRepository);

  Future<void> execute(UserD user) async {
    return await userRepository.updateUser(user);
  }
}
