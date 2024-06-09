import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String taskName;
  final String description;
  final String tag;
  final int assignedUserId;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> comments;
  final List<String> files;
  final int tableId;

  const Task(
      {required this.id,
      required this.taskName,
      required this.description,
      required this.tag,
      required this.assignedUserId,
      required this.startTime,
      required this.endTime,
      required this.comments,
      required this.files,
      required this.tableId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      taskName: json['task_name'] as String,
      description: json['description'] as String,
      tag: json['tag'] as String,
      assignedUserId: json['assigned_user_id'] as int,
      startTime: DateTime.parse(json['start_time'] as String),
      endTime: DateTime.parse(json['end_time'] as String),
      comments: (json['comments'] as List).map((e) => e as String).toList(),
      files: (json['files'] as List).map((e) => e as String).toList(),
      tableId: json['table_id'] as int,
    );
  }

  @override
  List<Object?> get props => [
        id,
        taskName,
        description,
        tag,
        assignedUserId,
        startTime,
        endTime,
        comments,
        files,
        tableId
      ];
}
