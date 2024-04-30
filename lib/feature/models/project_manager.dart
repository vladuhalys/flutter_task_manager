import 'package:equatable/equatable.dart';

class ProjectManager extends Equatable {
  final int id;
  final int userId;
  final int projectId;

  const ProjectManager(
      {required this.id, required this.userId, required this.projectId});

  @override
  List<Object?> get props => [id, userId, projectId];
}
