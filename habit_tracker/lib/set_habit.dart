import 'package:flutter/material.dart';

Widget calendarTile({date, weekDay}) {
  return Container(
          margin: const EdgeInsets.all(10.0),
          height: 80,
          width: 80,
          child: Card(
            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),),
            color: const Color(0xFF131a27),
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  Container(margin: const EdgeInsets.all(5.0), child: Text("$date", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                  Container(margin: const EdgeInsets.all(5.0), child: Text("$weekDay", style: const TextStyle(color: Colors.white, fontSize: 15))),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        );
}

int date(int index) {
  final thisDay = DateTime.now();
  final concernedDay = thisDay.add(Duration(hours:24*index));
  return concernedDay.day;
}

String week(int index) {
  const List<String> weeks = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  final thisDay = DateTime.now();
  final concernedDay = thisDay.add(Duration(hours:24*index));
  return weeks[concernedDay.weekday-1];
}

Widget calendar() {
  return Container(
    height: 95,
    color: const Color(0xFF1b232e),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) => calendarTile(date: date(index), weekDay: week(index)),
      // children: <Widget>[
      //   calenderTile(date:2, weekDay:'Tue'),
      //   calenderTile(date:3, weekDay:'Wed'),
      //           ],
              ),);
}


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
      body: Center(child: calendar()),
    );
  }
}