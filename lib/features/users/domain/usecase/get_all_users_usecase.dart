import 'package:uplink/features/users/domain/entities/user.dart';
import 'package:uplink/features/users/domain/repositories/user_repository.dart';

class GetAllUsersUseCase {
  final UserRepository userRepository;

  GetAllUsersUseCase(this.userRepository);

  Future<List<User>> execute() async {
    return await userRepository.getAllUsers();
  }
}
