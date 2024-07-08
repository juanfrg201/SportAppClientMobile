import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/src/helper/shared_preferences/shared_preferences_helper.dart';
// Import correcto para el modelo Task

class SessionsServices {
  static const String baseUrl = 'https://sportappservice.onrender.com';

  static Future<bool> create(String email, String password) async {
    final url = Uri.parse('$baseUrl/api/v1/sessions');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      // Parsear la respuesta JSON para obtener el ID del usuario
      final responseData = jsonDecode(response.body);
      final userId = responseData['id'];

      // Almacenar el ID del usuario utilizando SharedPreferences
      await SharedPreferencesHelper.init();
      await SharedPreferencesHelper.setUserId(userId);

      return true;
    } else {
      print('Failed to create session: ${response.statusCode}');
      return false;
    }
  }

  static Future<void> deleteSession() async {
    // Borrar el estado de sesión utilizando SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }
}