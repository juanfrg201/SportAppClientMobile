import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, Color color, {Duration duration = const Duration(seconds: 3)}) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
