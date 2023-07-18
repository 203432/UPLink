import '../repositories/user_repository.dart';

class LogoutUseCase {
  final UserRepository userRepository;

  LogoutUseCase(this.userRepository);

  Future<String> execute(String username, String password) async {
    return "Logout";
  }
}