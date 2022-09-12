import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models.dart';

class QuickHabit extends StatelessWidget {
  const QuickHabit({Key? key}) : super(key: key);

  Widget quickHabitTile() {
  return Container(
    margin: const EdgeInsets.all(20.0),
    height: 80.0,
    width: 80.0,
    color: Colors.green,
    child: const Text('JOGGING'),
    );
  }

  Widget quickHabit() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        quickHabitTile(), quickHabitTile(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return quickHabit();
  }
}


class AddHabit extends StatefulWidget {
  const AddHabit({Key? key}) : super(key: key);

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  final textEditingController = TextEditingController();
  bool pressed = false;
  Box<Habit>? habits;

    @override
  void initState() {
    super.initState();
    habits = Hive.box<Habit>('habits');
  }

  String? get _errorText {
    final fieldValue = textEditingController.text;

    if (fieldValue.isEmpty && pressed) {
      return 'Can\'t be empty';
    }
    return null;
  }

  void addHabit() async {
    var habit = Habit();
    String habitText = textEditingController.text;

    habit.setHabit(habitText);
    habits?.put(habitText, habit);
    //print(habits?.values.map((x) => x.dates).toList());
  }

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
                  controller: textEditingController,
                  cursorColor: const Color(0xFF7525fe),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    fillColor: Colors.deepPurpleAccent,
                    labelText: 'Add Habit',
                    errorText: _errorText,
                    focusedBorder: const OutlineInputBorder(),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffix: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_upward, size: 20),
                      onPressed: () {
                        setState(() {
                          pressed = true;
                        });
                        if (textEditingController.text.isNotEmpty) {
                          addHabit();
                          Navigator.pop(context);
                        }
                        },
              ),
                  ),
                  onChanged: (text) {
                    if (textEditingController.text.isNotEmpty) {
                      setState(() {
                        pressed = false;
                      });
                    }
                  },
                ),
              ),]
        ),
      );
  }
}