import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/src/models/user.dart'; // Import correcto para el modelo Task

class UserServices {
  static const String baseUrl = 'http://10.0.2.2:3000/';

  static Future<bool> create(User user) async {
    final url = Uri.parse('$baseUrl/api/v1/user?name=${user.name}&last_name=${user.last_name}&email=${user.email}&password=${user.password}&password_confirmation=${user.password_confirmation}');
    final response = await http.post(
      url // Llama a un método que convierte el objeto User en parámetros de consulta
    );

    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      return true;
    } else {
      print('Failed to create task: ${response.statusCode}');
      return false;
    }
  }
}
