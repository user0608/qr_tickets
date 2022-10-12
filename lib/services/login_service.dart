import 'package:qr_tickets/services/bases/services.dart';

class LoginService {
  final _basepath = "login";
  LoginService();

  Future<String> login(String username, String password) async {
    username = username.trim();
    password = password.trim();
    if (username.isEmpty) {
      throw Exception("Username Vacio");
    }
    if (password.isEmpty) {
      throw Exception("Password Vacio");
    }
    final response = await ApiService.post(_basepath, {'username': username, 'password': password});
    return response['data']['token'];
  }
}
