import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/src/components/snack_bar/custom_snack_bar.dart';
import 'package:sport_app/src/routes.dart';
import 'package:sport_app/src/services/sessions_services.dart';
import 'package:sport_app/src/services/user_services.dart'; // Asegúrate de agregar esta dependencia en pubspec.yaml

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String lastName = _lastNameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Aquí puedes agregar la lógica para enviar los datos a la API
      final updateUser = await UserServices.update(name , lastName, email, password);

      if (updateUser) {
        // Si la respuesta es exitosa, puedes manejar la lógica aquí
        print('Perfil actualizado exitosamente');
        _toggleEdit();
        CustomSnackBar.show(
          context,
          'Perfil actualizado exitosamente',
          Colors.green,
        );
      } else {
        // Si la respuesta no es exitosa, puedes manejar los errores aquí
        print('Error al actualizar el perfil');
        CustomSnackBar.show(
          context,
          'Error al actualizar el perfil',
          Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleEdit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0), // Hace que el botón sea redondeado
                ),
                backgroundColor: color.primary, // Color de fondo rojo
                minimumSize: Size(200, 50), // Ajusta estos valores para hacer el botón más largo
              ),
              child: Text(
                isEditing ? 'Cancelar' : 'Editar Perfil',
                style: TextStyle(color: Colors.white),
              ),
            ),
            isEditing ? _buildEditForm() : _buildProfileInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    final color = Theme.of(context).colorScheme;
    return Column(
      children: [
        // Aquí puedes agregar widgets para mostrar la información del perfil
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            SessionsServices.deleteSession();
            CustomSnackBar.show(
              context,
              'Cerraste sesión exitosamente',
              Colors.green,
            );
            Navigator.pushNamed(context, AppRoutes.home);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0), // Hace que el botón sea redondeado
            ),
            backgroundColor: color.primary, // Color de fondo rojo
            minimumSize: Size(200, 50), // Ajusta estos valores para hacer el botón más largo
          ),
          child: Text(
            "Cerrar Sesión",
            style: TextStyle(color: Colors.white),
          ),
        ),
        // Otros campos de perfil
      ],
    );
  }

  Widget _buildEditForm() {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu nombre';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu apellido';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu email';
                  }
                  // Puedes agregar validaciones adicionales para el formato de email si lo deseas
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  // Add more password validation if needed
                  return null;
                },
              ),
            ),
            // Otros campos de edición del perfil
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                backgroundColor: Colors.white,
                minimumSize: Size(200, 50),
              ),
              child: Text(
                'Guardar',
                style: TextStyle(color: color.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
