import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/src/models/user.dart'; // Import correcto para el modelo Task

class UserServices {
  static const String baseUrl = 'https://app-sport.onrender.com';

  static Future<bool> create(User user) async {
    final url = Uri.parse('$baseUrl/api/v1/user?name=${user.name}&last_name=${user.last_name}&email=${user.email}&password=${user.password}&password_confirmation=${user.password_confirmation}');
    final response = await http.post(
      url ,
      headers: {'Content-Type': 'application/json'},// Llama a un método que convierte el objeto User en parámetros de consulta
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

  static Future<bool> update(String name, String last_name, String email, String password) async {
    // Obtener el user_id almacenado en SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      print('User ID not found in SharedPreferences');
      return false;
    }

    final url = Uri.parse('$baseUrl/api/v1/user/$userId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'last_name': last_name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update user: ${response.statusCode}');
      return false;
    }
  }

  static Future<User?> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    final response = await http.get(Uri.parse('$baseUrl/api/v1/user/$userId'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }
}
