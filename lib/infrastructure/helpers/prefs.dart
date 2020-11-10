import 'package:shared_preferences/shared_preferences.dart';

Future<void> setToken(String token) async {
  final _p = await SharedPreferences.getInstance();
  await _p.setString('token', token);
}

Future<String> getToken() async {
  final _p = await SharedPreferences.getInstance();
  return _p.getString('token');
}

Future<void> setFcm(String token) async {
  final _p = await SharedPreferences.getInstance();
  await _p.setString('fcm', token);
}

Future<String> getFcm() async {
  final _p = await SharedPreferences.getInstance();
  return _p.getString('fcm');
}

Future<void> setUserId(String id) async {
  final _p = await SharedPreferences.getInstance();
  await _p.setString('userId', id);
}

Future<String> getUserId() async {
  final _p = await SharedPreferences.getInstance();
  return _p.getString('userId');
}
