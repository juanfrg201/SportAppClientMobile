import 'package:flutter/material.dart';
import 'package:sport_app/src/routes.dart';
import 'package:sport_app/src/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRoutes.generateRoute,
      home: const HomeScreen(),
    );
  }
}
