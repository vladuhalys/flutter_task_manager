import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String taskName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<dynamic> comments;
  final List<dynamic> files;
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
  
  Task.empty()
      : id = 0,
        taskName = '',
        description = '',
        comments = [],  
        files = [],
        tableId = 0,
        startDate = DateTime.now(),
        endDate = DateTime.now();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      taskName: json['task_name'] ?? '',
      description: json['description'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      comments: json['comments'] ?? [],
      files: json['files'] ?? [],
      tableId: json['table_id'] ?? 0,
    );
  }

  @override
  List<Object?> get props =>
      [id, taskName, description, startDate, endDate, comments, files, tableId];
}
