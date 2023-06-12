import 'package:uplink/features/users/domain/entities/authentication.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<void> register(User user);
  Future<User> findUserByUsername(String username);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String userId);
  Future<Authentication> login(String username, String password);
}
