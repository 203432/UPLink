import 'package:uplink/features/users/domain/entities/authentication.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<void> register(User user);
  Future<User> findUserByUsername(int userId);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  Future<Authentication> login(String username, String password);
  Future<List<User>> getAllUsers();
}
