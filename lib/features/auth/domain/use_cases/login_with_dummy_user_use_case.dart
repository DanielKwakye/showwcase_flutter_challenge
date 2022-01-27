import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/repositories/auth_user_repository.dart';

/// An implementation of Login with dummy user. to be called by the presentation layer of
class LoginWithDummyUserUseCase implements UseCase<AuthUser, Params> {
  AuthUserRepository authUserRepository;
  LoginWithDummyUserUseCase({required this.authUserRepository});

  @override
  Future<Either<Failure?, AuthUser?>?>? call(params)  async {
     return await authUserRepository.loginWithDummyUser(email: params.email, password: params.password);
  }

}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password });

  @override
  List<Object?> get props => [];
}