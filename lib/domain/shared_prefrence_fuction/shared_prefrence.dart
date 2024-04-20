import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceFunction {
  static String login = '';
// checking user already logined or not
  userLoginCheck() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    login = sharedPreferences.getString('login') ?? '';
    return login;
  }
// user login function
  userLogin(String val) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('login', val);
    login = val;
  }
// user logout function
  userLogOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('login', '');
    login = '';
  }
}
