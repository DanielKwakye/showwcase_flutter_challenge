import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/repositories/auth_user_repository.dart';

class IsUserAuthenticatedUseCase extends UseCase<AuthUser, Params> {

  AuthUserRepository authUserRepository;
  IsUserAuthenticatedUseCase({required this.authUserRepository});

  @override
  Future<Either<Failure?, AuthUser?>?>? call(Params params) {
    return authUserRepository.isUserAuthenticated();
  }

}

class Params extends Equatable {
  @override
  List<Object?> get props => [];

}