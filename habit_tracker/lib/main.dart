import 'package:flutter/material.dart';
import 'package:habit_tracker/models.dart';
import 'set_habit.dart';
import 'package:hive_flutter/hive_flutter.dart';


const primaryColor = Color(0xFF131a27);
void main() async {
  Hive.registerAdapter(HabitAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Habit>('habits');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: const SetHabit(),
    );
  }
}