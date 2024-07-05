import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class NewRutine extends StatefulWidget {
  @override
  _NewRutineState createState() => _NewRutineState();
}

class _NewRutineState extends State<NewRutine> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  int _series = 0;
  int _repetitions = 0;
  double _weight = 0.0;
  File? _image;

  final ImagePicker _picker = ImagePicker();
  

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Aquí debes implementar la lógica para enviar los datos a tu API
    // Reemplaza con tu lógica de API real
    String apiUrl = 'tu_api/aqui';

    // Ejemplo de cómo enviar datos con http.post (reemplaza según tu API)
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.fields['name'] = _name;
      request.fields['series'] = _series.toString();
      request.fields['repetitions'] = _repetitions.toString();
      request.fields['weight'] = _weight.toString();

      if (_image != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', _image!.path),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        // Éxito, puedes manejar la respuesta aquí
        print('Ejercicio registrado correctamente');
      } else {
        // Manejar errores de petición aquí
        print('Error al registrar ejercicio: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores generales aquí
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Ejercicio'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nombre del ejercicio',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del ejercicio';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Series',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el número de series';
                  }
                  return null;
                },
                onSaved: (value) {
                  _series = int.parse(value!);
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Repeticiones',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el número de repeticiones';
                  }
                  return null;
                },
                onSaved: (value) {
                  _repetitions = int.parse(value!);
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el peso utilizado';
                  }
                  return null;
                },
                onSaved: (value) {
                  _weight = double.parse(value!);
                },
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Seleccionar Imagen'),
              ),
              SizedBox(height: 12.0),
              if (_image != null) Image.file(_image!),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Registrar Ejercicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
