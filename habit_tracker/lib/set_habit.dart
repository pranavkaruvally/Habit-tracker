import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'quick_habit.dart';
import 'models.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  Widget calendarTile({date, weekDay, bool today=false}) {
  return Container(
          margin: const EdgeInsets.all(10.0),
          height: 80,
          width: 80,
          child: Card(
            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),),
            color: today ? const Color(0xFF737ae8) : const Color(0xFF131a27),
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(child: Container()),
                  Container(margin: const EdgeInsets.all(5.0), child: Text("$date", style: TextStyle(color: today ? Colors.white : const Color(0xFF737479), fontSize: 20, fontWeight: today ? FontWeight.w900 : FontWeight.w600))),
                  Container(margin: const EdgeInsets.all(5.0), child: Text("$weekDay", style: TextStyle(color: today ? Colors.white : const Color(0xFF737479), fontSize: 15, fontWeight: today ? FontWeight.w800 : FontWeight.normal))),
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
        itemBuilder: (context, index) {
          if (index == 0) {
            return calendarTile(date: date(index), weekDay: week(index), today: true);
          }
          else {
            return calendarTile(date: date(index), weekDay: week(index));
          }
        }
        // children: <Widget>[
        //   calenderTile(date:2, weekDay:'Tue'),
        //   calenderTile(date:3, weekDay:'Wed'),
        //           ],
            ),);
    }

  @override
  Widget build(BuildContext context) {
    return calendar();
  }
}

class MyHabitTile extends StatefulWidget {
  const MyHabitTile({Key? key, required this.habit, required this.color, required this.habitObject}) : super(key: key);
  final String habit;
  final int color;
  final Habit habitObject;
  @override
  State<MyHabitTile> createState() => _MyHabitTileState();
}

class _MyHabitTileState extends State<MyHabitTile> {
  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  @override
  Widget build(BuildContext context) {
    return ListTile(
    leading: IconButton(
      icon: !(widget.habitObject.dates![date] ?? false)
        ? const Icon(Icons.check_circle_outlined, color: Color(0xFF898a8c), size: 35,)
        : Icon(Icons.check_circle_rounded, color: Color(widget.color), size: 35,),
      onPressed: ()  {
        setState(() {
          if (widget.habitObject.dates![date] ?? false) {
            widget.habitObject.dates![date]=false;
            widget.habitObject.uncheckTodaysTask();
          } 
          else {
            widget.habitObject.dates![date]=true;
            widget.habitObject.checkTodaysTask();
          }
          widget.habitObject.save();
        });
        // var habits = Hive.box<Habit>('habits');
        // print(habits.values.map((x) => x.score));
      },
    ),
    title: Text(widget.habit, style: const TextStyle(color: Colors.white)),
    trailing: IconButton(
      icon: const Icon(Icons.clear_outlined, color: Colors.white),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Delete?"),
              content: const Text("Do you really want to delete?"),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("No"),),
                TextButton(
                  onPressed: () {
                    widget.habitObject.delete();
                    Navigator.of(context).pop();
                    },
                    child: const Text("Yes"),),
              ],
            );
        }
      )
        //widget.habitObject.delete();
      ),
      subtitle: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 1,
            width: MediaQuery.of(context).size.width * 0.6 * (widget.habitObject.score!.toInt()/60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(widget.color)
              ),
              ),
          const Expanded(child: SizedBox()),
        ],
      ),
  );
  }
}

// Widget myHabits() {
//   return ListView(
//     children: const<Widget>[MyHabitTile(habit: "Learn 5 new words"), MyHabitTile(habit: "Get up Early"), MyHabitTile(habit: "Create an App a day")],
//   );
// }

class MyHabits extends StatefulWidget {
  const MyHabits({Key? key}) : super(key: key);

  @override
  State<MyHabits> createState() => _MyHabitsState();
}

class _MyHabitsState extends State<MyHabits> {
  List<dynamic>? habitList;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: Hive.box<Habit>('habits').listenable(),
    builder: (context, box, widget) {
      habitList = box.values.toList();
      return ListView.builder(
        itemCount: habitList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return MyHabitTile(
            habit: habitList![index].habit.toString(),
            color: habitList![index].color,
            habitObject: habitList![index],
          );
        },
      );
    }
    );
  }
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
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            builder: (context) => const AddHabit(),
            //isScrollControlled: true,
          ),
        ),
        const SizedBox(width: 10.0,)],
      ),
      body: Column(children: const <Widget>[Expanded(child: QuickHabit()), Calendar(), Expanded(child: MyHabits())]),
    );
  }
}