import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final int id;
  final String roleName;

  const Role({required this.id, required this.roleName});

  @override
  List<Object?> get props => [id, roleName];
}
