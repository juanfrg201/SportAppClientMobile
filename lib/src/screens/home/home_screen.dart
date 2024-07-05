import 'package:flutter/material.dart';
import 'package:sport_app/src/components/home/home_botton.dart';
import 'package:sport_app/src/components/shared/home_down_view.dart';
import 'package:sport_app/src/components/shared/home_top_view.dart';
import 'package:sport_app/src/routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          HomeTopView(color: color, flex: 4),
          HomeDownView(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Text(
                    'Bienvenido',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  HomeBotton(name: "Inicio de Sesión", routes: AppRoutes.login),
                  SizedBox(height: 25),
                  HomeBotton(name: "Registro", routes: AppRoutes.register),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
