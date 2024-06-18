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
      id: json['id'] ?? 0,
      taskName: json['task_name'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.tryParse(json['start_time'] ?? '') ?? DateTime.now(),
      endDate:  DateTime.tryParse(json['end_time'] ?? '') ?? DateTime.now(),
      comments: json['comments'] ?? [],
      files: json['files'] ?? [],
      tableId: json['table_id'] ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [id, taskName, description, startDate, endDate, comments, files, tableId];
}
