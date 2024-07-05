import 'package:flutter/material.dart';
import 'package:sport_app/src/screens/home/home_screen.dart';
import 'package:sport_app/src/screens/sessions/login_screen.dart';
import 'package:sport_app/src/screens/sessions/register_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
