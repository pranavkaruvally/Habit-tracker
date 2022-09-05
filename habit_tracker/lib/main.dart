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
  updateAppDate();
}

// void addNewDate() {
//   var habitBox = Hive.box<Habit>('habits');
//   DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
//   DateTime yesterday = today.subtract(const Duration(days: 1));
//   List<Habit> habits = habitBox.values.toList();

//   for (int i=0; i<habits.length; i++) {
//     if (!habits[i].dates!.containsKey(today)) {
//       habits[i].dates![today] = false;
//       if (habits[i].dates![yesterday] == false) {
//         habits[i].punishScore();
//       }
//     }
//     habits[i].save();
//   }

// }

void updateAppDate() {
  var habitBox = Hive.box<Habit>('habits');
  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  List<Habit> habits = habitBox.values.toList();

  for(int i=0; i<habits.length; i++) {
    DateTime lastDay = habits[i].lastOpenedDate ?? today;

    int difference = today.difference(lastDay).inDays;
    
    if (lastDay != today) {
      if (habits[i].dates![lastDay] == false) {
        habits[i].score = habits[i].score! - difference;
      }
      else {
        if (difference > 1) {
          habits[i].score = habits[i].score! - difference + 1;
        }
        habits[i].save();
      }
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