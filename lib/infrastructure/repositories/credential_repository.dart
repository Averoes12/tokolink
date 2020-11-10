import 'package:tokolink/model/user.dart';

abstract class CredentialRepository {
  Future<void> register(User user);

  Future<void> resendOTP(User user);

  Future<void> verifyOTP(User user);

  Future<void> login(User user);

  Future<void> forgotPassword(User user);

  Future<void> updatePassword(User user);
}
