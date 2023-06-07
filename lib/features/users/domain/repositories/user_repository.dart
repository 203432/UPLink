import '../entities/userD.dart';

abstract class UserRepository {
  Future<void> createUser(UserD user);
  Future<UserD> findUserByUsername(String username);
  Future<void> updateUser(UserD user);
  Future<void> deleteUser(String userId);
}
