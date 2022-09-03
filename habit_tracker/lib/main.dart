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

void addNewDate() {
  var habitBox = Hive.box<Habit>('habits');
  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<Habit> habits = habitBox.values.toList();

  for (int i=0; i<habits.length; i++) {
    if (!habits[i].dates!.containsKey(today)) {
      habits[i].dates![today] = false;
    }
  }

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