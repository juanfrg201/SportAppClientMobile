import 'package:flutter/material.dart';
import 'package:sport_app/src/components/shared/home_down_view.dart';
import 'package:sport_app/src/components/shared/home_top_view.dart';
import 'package:sport_app/src/components/snack_bar/custom_snack_bar.dart';
import 'package:sport_app/src/helper/shared_preferences/shared_preferences_helper.dart';
import 'package:sport_app/src/routes.dart';
import 'package:sport_app/src/services/sessions_services.dart';
 // Importa SharedPreferencesHelper

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields state
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final userId = await SharedPreferencesHelper.verifyAndGetUserId();
    if (userId != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.principal_screen);
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newUser = await SessionsServices.create(_email, _password);

      if (newUser != null) {
        CustomSnackBar.show(
          context,
          'Logueado:',
          Colors.green,
        );
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.principal_screen, (route) => false);
      } else {
        CustomSnackBar.show(
          context,
          'Error al loguearte',
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
                    const Text(
                      'Inicio de Sesión',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15), // Ajusta el padding vertical según tu diseño
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0), // Hace que el botón sea redondeado
                          ),
                          backgroundColor: color.primary, // Color de fondo rojo
                        ),
                        child: const Text(
                          'Inicia sesion',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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

