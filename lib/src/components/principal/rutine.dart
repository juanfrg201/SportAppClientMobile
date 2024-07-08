// rutine.dart

import 'package:flutter/material.dart';
import 'package:sport_app/src/components/snack_bar/custom_snack_bar.dart';
import 'package:sport_app/src/models/ejercice.dart';
import 'package:sport_app/src/routes.dart';
import 'package:sport_app/src/services/ejercicie_services.dart';

class Rutine extends StatefulWidget {
  @override
  _RutineState createState() => _RutineState();
}

class _RutineState extends State<Rutine> {
  // Lista de ejercicios para el día seleccionado
  List<Ejercice> exercises = [];

  // Variable para almacenar el índice del día seleccionado
  int selectedDayIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Row de tarjetas para los días de la semana
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) => _buildDayCard(index)),
        ),
        SizedBox(height: 20), // Espacio entre las tarjetas y el texto principal
        // Mostrar los ejercicios del día seleccionado si se ha seleccionado un día
        if (selectedDayIndex != -1)
          Expanded(
            child: exercises.isEmpty
                ? Center(child: Text('No hay ejercicios para este día.'))
                : ListView(
                    children: exercises
                        .map((exercise) => _buildExerciseCard(exercise))
                        .toList(),
                  ),
          ),
      ],
    );
  }

  Widget _buildDayCard(int index) {
    String day = _getDayName(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          // Actualizar el índice del día seleccionado
          selectedDayIndex = index;
          fetchExercisesForDay(index);
        });
      },
      child: Card(
        color: selectedDayIndex == index ? Colors.blue[100] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido horizontalmente
            children: [
              Container(
                width: 10,
                height: 10,
              ),
              Text(
                day,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14), // Tamaño de fuente más pequeño
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Ejercice exercise) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(exercise.image?.path ?? 'https://cdn-icons-png.flaticon.com/256/6478/6478052.png'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        exercise.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          final destroy_ejercicie = await EjerciceServices.destroy(exercise.id);
                          if(destroy_ejercicie){
                            Navigator.pushNamed(context, AppRoutes.principal_screen);
                            CustomSnackBar.show(context, "Se elimino el ejercicio", Colors.green);
                          }else{
                            CustomSnackBar.show(context, "Se elimino el ejercicio", Colors.red);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("Series: ${exercise.series}"),
                  Text("Repeticiones: ${exercise.repeticions}"),
                  Text("Peso: ${exercise.weight} kg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayName(int index) {
    switch (index) {
      case 0:
        return "L";
      case 1:
        return "M";
      case 2:
        return "Mi";
      case 3:
        return "J";
      case 4:
        return "V";
      case 5:
        return "S";
      case 6:
        return "D";
      default:
        return "";
    }
  }

  Future<void> fetchExercisesForDay(int day) async {
    try {
      List<Ejercice> fetchedExercises = await EjerciceServices.fetchExercises(1, day); // Reemplaza 1 con el ID del usuario actual

      setState(() {
        exercises = fetchedExercises;
      });
    } catch (e) {
      print(e);
      // Manejo de errores
    }
  }
}
