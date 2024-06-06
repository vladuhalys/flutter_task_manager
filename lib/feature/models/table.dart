import 'package:equatable/equatable.dart';

class ModelTable extends Equatable {
  final int id;
  final String tableName;
  final int projectId;

  const ModelTable(
      {required this.id, required this.tableName, required this.projectId});

  factory ModelTable.fromJson(Map<String, dynamic> json) {
    return ModelTable(
      id: json['id'] as int,
      tableName: json['table_name'] as String,
      projectId: json['project_id'] as int,
    );
  }

  @override
  List<Object?> get props => [id, tableName, projectId];
}
