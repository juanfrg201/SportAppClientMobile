import 'package:flutter/material.dart';

class HomeTopView extends StatelessWidget {
  final int flex;

  const HomeTopView({
    super.key,
    required this.color,
    required this.flex,
  });

  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex, // 40% of the height
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.primary, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}