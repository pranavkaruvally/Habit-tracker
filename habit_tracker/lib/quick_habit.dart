import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models.dart';

class QuickHabit extends StatelessWidget {
  const QuickHabit({Key? key}) : super(key: key);
  Widget quickHabitTile({String heading="YP", String habitText="Yoga Practice", int color=0xff01bcd5}) {
  return Container(
    margin: const EdgeInsets.only(left: 10.0, right: 10, top: 50, bottom: 50),
    height: 200.0,
    width: 140.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Color(color),
    ),
    child: Stack(
      children: [
        Align(
              alignment: const Alignment(-0.99, -0.4),
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Text(heading,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900)),
              )),
        Align(
              alignment: const Alignment(-0.99, 0.6),
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Text(habitText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
              )),
      ],
    ),
    );
  }

  Widget quickHabit() {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        quickHabitTile(heading: 'YP', habitText: 'Yoga Practice', color: 0xff2197f2), quickHabitTile(heading: 'GE', habitText: 'Get Up Early', color: 0xfff44336), quickHabitTile(heading: 'NS', habitText: 'No Sugar', color: 0xff01bcd5),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: quickHabit(),
    );
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