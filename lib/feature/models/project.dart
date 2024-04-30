import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final int id;
  final String projectName;
  final int ownerId;

  const Project(
      {required this.id, required this.projectName, required this.ownerId});

  @override
  List<Object?> get props => [id, projectName, ownerId];
}
