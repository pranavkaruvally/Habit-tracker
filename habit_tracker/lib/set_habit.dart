import 'package:flutter/material.dart';

class SetHabit extends StatefulWidget {
  const SetHabit({Key? key}) : super(key: key);

  @override
  State<SetHabit> createState() => _SetHabitState();
}

class _SetHabitState extends State<SetHabit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131a27),
      appBar: AppBar(
        backgroundColor: const Color(0xFF131a27),
        title: const Text("Most Popular Habits"),
        actions: <Widget>[IconButton(
          padding: const EdgeInsets.all(0.0),
          icon: const CircleAvatar(
            backgroundColor: Color(0xFF7424ff),
            child: Icon(
              Icons.add,
              ),
            ),
          tooltip: 'Add new habit',
          onPressed: () => {},
        ),
        const SizedBox(width: 10.0,)],
      ),
      //body: Center(child: Text("Hello World", style: TextStyle(color: Colors.white))),
    );
  }
}