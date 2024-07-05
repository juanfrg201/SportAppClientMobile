import 'package:flutter/material.dart';
import 'package:sport_app/src/screens/home/home_screen.dart';

class AppRoutes {
  static const String home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
