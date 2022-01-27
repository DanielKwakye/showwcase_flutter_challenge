import 'package:equatable/equatable.dart';

/// This is a typical model for user of the sytstem
class AuthUser extends Equatable {

  final String name;
  final String email;
  final String password;

  const AuthUser({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];


}