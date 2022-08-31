import 'package:flutter/material.dart';

Widget quickHabit() {
  return Container(
    height: 120.0,
    width: 120.0,
    color: Colors.red,
    child: Container(
      margin: const EdgeInsets.all(20.0),
      height: 80.0,
      width: 80.0,
      color: Colors.green,
      child: const Text('JOGGING'),
    ),
  );
}
