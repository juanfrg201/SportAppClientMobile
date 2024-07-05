import 'package:flutter/material.dart';
class HomeBotton extends StatelessWidget {
  final String name;
  final String routes;

  const HomeBotton({
    super.key,
    required this.name,
    required this.routes
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routes);
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        textStyle: TextStyle(fontSize: 14),
      ),
      child: Text('${name}'),
    );
  }
}