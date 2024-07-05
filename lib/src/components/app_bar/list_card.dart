import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String name_card;
  final Icon? icon;
  final String? routes;

  const ListCard({
    super.key,
    required this.name_card,
    this.icon,
    required this.routes
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text("${name_card}"),
      onTap: () {
        // Maneja la opción aquí
        Navigator.pushNamed(context, routes!);
      },
    );
  }
}