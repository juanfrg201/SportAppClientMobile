import 'package:flutter/material.dart';
import 'package:sport_app/src/components/shared/home_down_view.dart';
import 'package:sport_app/src/components/shared/home_top_view.dart';
import 'package:sport_app/src/components/snack_bar/custom_snack_bar.dart';
import 'package:sport_app/src/models/user.dart';
import 'package:sport_app/src/routes.dart';
import 'package:sport_app/src/services/user_services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields state
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  String _password_confirmation = '';

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = User(name: _firstName, last_name: _lastName, email: _email, password: _password, password_confirmation: _password_confirmation);
      final newUser = await UserServices.create(user);

      if (newUser) {
        CustomSnackBar.show(
          context,
          'Usuario registrado:',
          Theme.of(context).colorScheme.primary,
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.principal_screen, (route) => false);
      } else {
        CustomSnackBar.show(
          context,
          'Error al registrar usuario',
          Theme.of(context).errorColor,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          HomeTopView(color: color, flex: 2),
          HomeDownView(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      'Registro',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
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
                      onSaved: (value) {
                        _firstName = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
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
                      onSaved: (value) {
                        _lastName = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Correo Electrónico',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor ingresa tu correo electrónico';
                        }
                        // Add more sophisticated email validation if needed
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
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
                      onSaved: (value) {
                        _password = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirma tu constraseña',
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
                      onSaved: (value) {
                        _password_confirmation = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15), // Ajusta el padding vertical según tu diseño
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0), // Hace que el botón sea redondeado
                          ),
                          backgroundColor: color.primary, // Color de fondo rojo
                        ),
                        child: Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
