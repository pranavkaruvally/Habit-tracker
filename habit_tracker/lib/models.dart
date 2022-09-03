import 'package:hive/hive.dart';
import 'dart:math';

part 'models.g.dart';

@HiveType(typeId: 1)
class Habit extends HiveObject {
  @HiveField(0)
  String? habit;

  @HiveField(1, defaultValue: 0)
  int? score;

  @HiveField(2, defaultValue: {})
  Map<DateTime, bool>? dates;

  @HiveField(3)
  int? color;

  int _setColor() {
    final random = Random();
    List<int> colors = [0xFF7424fe, 0xFF2096f2, 0xFFf54337, 0xFF00bcd4];
    int? i;

    i = random.nextInt(colors.length);
    return colors[i];
  }

  void setHabit(habit) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    this.habit = habit;
    dates = {date: false};
    color = _setColor();
    score = 0;
  }

  void addScore() {
    score = score! + 2;
    if (score! > 60){
      delete();
    }
  }

  void reduceScore() {
    score = score! - 2;
  }

  void punishScore() {
    if (score! > 0) {
      score = score! - 1;
    }
  }

  void checkTodaysTask() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    dates![date] = true;
    addScore();
  }

  void uncheckTodaysTask() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);

    dates![date] = false;
    reduceScore();
  }
}