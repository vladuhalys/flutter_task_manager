import 'package:equatable/equatable.dart';

class Table extends Equatable {
  final int id;
  final String tableName;
  final int projectId;
  final int managerId;

  const Table(
      {required this.id,
      required this.tableName,
      required this.projectId,
      required this.managerId});

  @override
  List<Object?> get props => [id, tableName, projectId, managerId];
}
