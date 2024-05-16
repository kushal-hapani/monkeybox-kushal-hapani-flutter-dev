import 'package:hive/hive.dart';

part "user_exercise_model.g.dart";

@HiveType(typeId: 0)
class UserExerciseModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String workOutName;

  @HiveField(2)
  final List<String> exerciseId;

  @HiveField(3)
  final DateTime createdAt;

  UserExerciseModel({
    required this.id,
    required this.workOutName,
    required this.createdAt,
    required this.exerciseId,
  });
}
