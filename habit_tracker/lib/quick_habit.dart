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

class AddHabit extends StatefulWidget {
  const AddHabit({Key? key}) : super(key: key);

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130 + MediaQuery.of(context).viewInsets.bottom,
        decoration: const BoxDecoration(
          color: Color(0xFF131a27),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Column(
          children: [Container(
                color: Colors.white,
                child: TextField(
                  cursorColor: const Color(0xFF7525fe),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.deepPurpleAccent,
                    labelText: 'Add Habit',
                    focusedBorder: const OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffix: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_upward, size: 20),
                      onPressed: () => {},
              ),
                  ),
                ),
              ),]
        ),
      );
  }
}