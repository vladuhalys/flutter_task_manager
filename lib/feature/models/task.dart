import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String taskName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> comments;
  final List<String> files;
  final int tableId;

  const Task(
      {required this.id,
      required this.taskName,
      required this.description,
      required this.comments,
      required this.files,
      required this.tableId,
      required this.startDate,
      required this.endDate});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      taskName: json['task_name'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['start_time'] as String),
      endDate: DateTime.parse(json['end_time'] as String),
      comments: (json['comments'] as List).map((e) => e as String).toList(),
      files: (json['files'] as List).map((e) => e as String).toList(),
      tableId: json['table_id'] as int,
    );
  }

  @override
  List<Object?> get props =>
      [id, taskName, description, startDate, endDate, comments, files, tableId];
}
