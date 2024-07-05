import 'package:flutter/material.dart';

class Rutine extends StatefulWidget {
  @override
  _RutineState createState() => _RutineState();
}

class _RutineState extends State<Rutine> {
  // Lista de ejercicios por día
  List<List<Exercise>> exercises = [
    [
      Exercise(
        name: "Flexiones de pecho",
        imageUrl: "https://example.com/flexiones.jpg",
        series: 3,
        repetitions: 15,
      ),
      Exercise(
        name: "Sentadillas",
        imageUrl: "https://example.com/sentadillas.jpg",
        series: 3,
        repetitions: 20,
      ),
    ],
    [
      Exercise(
        name: "Abdominales",
        imageUrl: "https://example.com/abdominales.jpg",
        series: 4,
        repetitions: 25,
      ),
      Exercise(
        name: "Plancha",
        imageUrl: "https://example.com/plancha.jpg",
        series: 3,
        repetitions: 30,
      ),
    ],
    [
      Exercise(
        name: "Estiramientos",
        imageUrl: "https://example.com/estiramientos.jpg",
        series: 2,
        repetitions: 10,
      ),
    ],
    [
      Exercise(
        name: "Carrera",
        imageUrl: "https://example.com/carrera.jpg",
        series: 1,
        repetitions: 30,
      ),
    ],
    [
      Exercise(
        name: "Natación",
        imageUrl: "https://example.com/natacion.jpg",
        series: 2,
        repetitions: 25,
      ),
    ],
    [
      Exercise(
        name: "Descanso",
        imageUrl: "https://example.com/descanso.jpg",
        series: 0,
        repetitions: 0,
      ),
    ],
    [
      Exercise(
        name: "Descanso",
        imageUrl: "https://example.com/descanso.jpg",
        series: 0,
        repetitions: 0,
      ),
    ],
  ];

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
          children: [
            _buildDayCard(0),
            _buildDayCard(1),
            _buildDayCard(2),
            _buildDayCard(3),
            _buildDayCard(4),
            _buildDayCard(5),
            _buildDayCard(6),
          ],
        ),
        SizedBox(height: 20), // Espacio entre las tarjetas y el texto principal
        // Mostrar los ejercicios del día seleccionado si se ha seleccionado un día
        if (selectedDayIndex != -1)
          Column(
            children: exercises[selectedDayIndex]
                .map((exercise) => _buildExerciseCard(exercise))
                .toList(),
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
        });
      },
      child: Card(
        color: selectedDayIndex == index ? Colors.blue[100] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      exercises[index][0].imageUrl, // Usar la imagen del primer ejercicio
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
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

  Widget _buildExerciseCard(Exercise exercise) {
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
                image: NetworkImage(exercise.imageUrl),
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
                      onPressed: () {
                        // Aquí puedes implementar la lógica para eliminar el ejercicio
                        // Por ejemplo, puedes mostrar un diálogo de confirmación
                        // y luego actualizar la lista de ejercicios.
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text("Series: ${exercise.series}"),
                Text("Repeticiones: ${exercise.repetitions}"),
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
}

class Exercise {
  final String name;
  final String imageUrl;
  final int series;
  final int repetitions;

  Exercise({required this.name, required this.imageUrl, required this.series, required this.repetitions});
}
 
