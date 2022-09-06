// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 1;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit()
      ..habit = fields[0] as String?
      ..score = fields[1] == null ? 0 : fields[1] as int?
      ..dates =
          fields[2] == null ? {} : (fields[2] as Map?)?.cast<DateTime, bool>()
      ..color = fields[3] as int?
      ..lastOpenedDate = fields[4] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.habit)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.dates)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.lastOpenedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
