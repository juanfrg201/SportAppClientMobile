import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sport_app/src/components/snack_bar/custom_snack_bar.dart';
import 'package:sport_app/src/models/ejercice.dart';
import 'package:sport_app/src/routes.dart';
import 'package:sport_app/src/services/ejercicie_services.dart';

class NewRutine extends StatefulWidget {
  @override
  _NewRutineState createState() => _NewRutineState();
}

class _NewRutineState extends State<NewRutine> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  int? _series;
  int? _repetitions;
  double? _weight;
  File? _image;
  int? _day;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Ejercice newEjercice = Ejercice(
        id: 0, // id temporal, se actualizará con el valor real al recibir la respuesta del servidor
        name: _name!,
        series: _series!,
        repeticions: _repetitions!,
        weight: _weight!,
        day: _day!,
        userId: 1, // Reemplaza con el ID real del usuario
        image: _image,
      );

      final response = await EjerciceServices.create(newEjercice);

      if (response != null) {
        // Ejercicio creado con éxito
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.principal_screen, (route) => false);
        CustomSnackBar.show(
          context,
          'Se creo el ejercicio',
          Colors.green,
        );
      
      } else {
        CustomSnackBar.show(
          context,
          'No se pudo crear el ejercicio',
          Colors.red,
        );
    
      }
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre del ejercicio',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    prefixIcon: Icon(Icons.fitness_center),
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
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    prefixIcon: Icon(Icons.format_list_numbered),
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
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    prefixIcon: Icon(Icons.repeat),
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
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    prefixIcon: Icon(Icons.fitness_center),
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
                DropdownButtonFormField<int>(
                  decoration: InputDecoration(
                    labelText: 'Día de la semana',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  items: [
                    DropdownMenuItem(value: 0, child: Text('Lunes')),
                    DropdownMenuItem(value: 1, child: Text('Martes')),
                    DropdownMenuItem(value: 2, child: Text('Miércoles')),
                    DropdownMenuItem(value: 3, child: Text('Jueves')),
                    DropdownMenuItem(value: 4, child: Text('Viernes')),
                    DropdownMenuItem(value: 5, child: Text('Sábado')),
                    DropdownMenuItem(value: 6, child: Text('Domingo')),
                  ],
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona un día';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _day = value!;
                  },
                  onChanged: (value) {
                    setState(() {
                      _day = value;
                    });
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
      ),
    );
  }
}
