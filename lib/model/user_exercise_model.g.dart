// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserExerciseModelAdapter extends TypeAdapter<UserExerciseModel> {
  @override
  final int typeId = 0;

  @override
  UserExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserExerciseModel(
      id: fields[0] as String,
      workOutName: fields[1] as String,
      createdAt: fields[3] as DateTime,
      exerciseId: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserExerciseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.workOutName)
      ..writeByte(2)
      ..write(obj.exerciseId)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
