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
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routes);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15), // Ajusta el padding vertical según tu diseño
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0), // Hace que el botón sea redondeado
          ),
          backgroundColor: color.primary, // Color de fondo rojo
        ),
        child: Text(name, style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

 