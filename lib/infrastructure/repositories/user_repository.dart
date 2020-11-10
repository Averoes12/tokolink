import 'package:tokolink/model/user.dart';

abstract class UserRepository {
  Future<User> profile();

  Future<void> updateProfile(User user);
}
