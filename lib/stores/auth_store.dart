import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  bool isLoggedIn = false;

  @action
  Future<bool> login(String email, String password) async {
    if (email == 'user@maxmobility.in' && password == 'Abc@#123') {
      isLoggedIn = true;
      await _saveLoginStatus(true);
      return true;
    }
    return false;
  }

  @action
  Future<void> logout() async {
    isLoggedIn = false;
    await _saveLoginStatus(false);
  }

  @action
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> _saveLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }
}
