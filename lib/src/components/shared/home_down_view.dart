import 'package:flutter/material.dart';
import 'package:sport_app/src/components/home/home_botton.dart';
import 'package:sport_app/src/routes.dart';

class HomeDownView extends StatelessWidget {
  final int flex;
  final Widget child;

  const HomeDownView({
    Key? key,
    required this.flex,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Flexible(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: child,
        ),
      ),
    );
  }
}


