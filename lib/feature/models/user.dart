import 'package:equatable/equatable.dart';

class ModelUser extends Equatable {
  final int id;
  final String userName;
  final int roleId;

  const ModelUser(
      {required this.id, required this.userName, required this.roleId});

  @override
  List<Object?> get props => [id, userName, roleId];
}
