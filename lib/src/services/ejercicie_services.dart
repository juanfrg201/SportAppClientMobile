import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/src/helper/shared_preferences/shared_preferences_helper.dart';
import 'package:sport_app/src/models/ejercice.dart';
// Import correcto para el modelo Task

class EjerciceServices {
  static const String baseUrl = 'https://app-sport.onrender.com';

  static Future<Ejercice?> create(Ejercice ejercice) async {
    await SharedPreferencesHelper.init();
    final user_id = await SharedPreferencesHelper.verifyAndGetUserId();
    if(user_id != null) {
      final url = Uri.parse('$baseUrl/api/v1/user/$user_id/ejercice');
      var request = http.MultipartRequest('POST', url)
        ..fields['name'] = ejercice.name
        ..fields['series'] = ejercice.series.toString()
        ..fields['repeticions'] = ejercice.repeticions.toString()
        ..fields['weight'] = ejercice.weight.toString()
        ..fields['day'] = ejercice.day.toString()
        ..fields['user_id'] = ejercice.userId.toString();

      if (ejercice.image != null) {
        var imageStream = http.ByteStream(ejercice.image!.openRead());
        var imageLength = await ejercice.image!.length();
        var multipartFile = http.MultipartFile(
          'image',
          imageStream,
          imageLength,
          filename: ejercice.image!.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        return Ejercice.fromJson(jsonDecode(responseData));
      } else {
        print('Error al crear el ejercicio: ${response.reasonPhrase}');
        return null;
      }
    }else{
      print('');
      return null;
    }
    
  }

  static Future<List<Ejercice>> fetchExercises(int userId, int day) async {
    await SharedPreferencesHelper.init();
    final user_id = await SharedPreferencesHelper.verifyAndGetUserId();
    final response = await http.get(Uri.parse('$baseUrl/api/v1/user/$user_id/ejercice?day=$day'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data.map((json) => Ejercice.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los ejercicios');
    }
  }

   static Future<bool> destroy(int id) async {

    await SharedPreferencesHelper.init();
    final user_id = await SharedPreferencesHelper.verifyAndGetUserId();
    final response = await http.delete(Uri.parse('$baseUrl/api/v1/user/$user_id/ejercice/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}