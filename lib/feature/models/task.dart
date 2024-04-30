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
