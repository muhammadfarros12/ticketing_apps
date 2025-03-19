import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketing_apps/model/response/login_response_model.dart';

class AuthLocalDatasource {
  // simpan session login
  Future<void> saveAuthData(LoginResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('login_session', data.toJson());
  }

  // hapus session login
  Future<void> removeAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('login_session');
  }

  // ambil session login
  Future<LoginResponseModel> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('login_session');
    if (data != null) {
      return LoginResponseModel.fromJson(data);
    } else {
      throw Exception('Data not found');
    }
  }

  // cek session login : true | false
  Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.containsKey('login_session');
  }
}
