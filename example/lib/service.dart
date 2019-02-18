import 'package:example/app_state.dart';

abstract class Service {
  Future<User> currentUser();
  Future<User> login(String email, String password);
  Future<void> logout();
}
