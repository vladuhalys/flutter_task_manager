import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String projectName;
  final int ownerId;

  const Project(
      {required this.id, required this.projectName, required this.ownerId});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      projectName: json['project_name'] as String,
      ownerId: json['owner_id'] as int,
    );
  }

  @override
  List<Object?> get props => [id, projectName, ownerId];
}
