import 'dart:io';

class Ejercice {
  final int id;
  final String name;
  final int series;
  final int repeticions;
  final double weight;
  final int day;
  final int userId;
  final File? image;

  Ejercice({
    required this.id,
    required this.name,
    required this.series,
    required this.repeticions,
    required this.weight,
    required this.day,
    required this.userId,
    this.image,
  });

  factory Ejercice.fromJson(Map<String, dynamic> json) {
    return Ejercice(
      id: json['id'],
      name: json['name'],
      series: json['series'] is int ? json['series'] : int.parse(json['series']),
      repeticions: json['repeticions'] is int ? json['repeticions'] : int.parse(json['repeticions']),
      weight: json['weight'] is double ? json['weight'] : double.parse(json['weight'].toString()),
      day: json['day'] is int ? json['day'] : int.parse(json['day']),
      userId: json['user_id'],
      image: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'series': series,
      'repeticions': repeticions,
      'weight': weight,
      'day': day,
      'user_id': userId,
      // La imagen no se envía como parte del JSON normal
    };
  }
}
