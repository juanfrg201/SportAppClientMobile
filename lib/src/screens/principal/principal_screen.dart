import 'package:flutter/material.dart';
import 'package:sport_app/src/components/shared/home_down_view.dart';
import 'package:sport_app/src/components/shared/home_top_view.dart';

class PrincipalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        children: [
          HomeTopView(color: color, flex: 2),
          const HomeDownView(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Login"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
