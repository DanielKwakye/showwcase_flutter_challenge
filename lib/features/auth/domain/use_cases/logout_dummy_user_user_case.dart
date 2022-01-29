import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/repositories/auth_user_repository.dart';

// Logouts out a user
class LogoutDummyUserUseCase implements UseCase<bool,LogoutUserParams> {

  AuthUserRepository authUserRepository;
  LogoutDummyUserUseCase({required this.authUserRepository});

  @override
  Future<Either<Failure?, bool?>?>? call(LogoutUserParams params) async {
    return await authUserRepository.logoutDummyUser();
  }

}

class LogoutUserParams extends Equatable {
  @override
  List<Object?> get props => [];

}