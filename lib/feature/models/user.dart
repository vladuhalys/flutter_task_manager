import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String userName;
  final int roleId;

  const User({required this.id, required this.userName, required this.roleId});

  @override
  List<Object?> get props => [id, userName, roleId];
}
