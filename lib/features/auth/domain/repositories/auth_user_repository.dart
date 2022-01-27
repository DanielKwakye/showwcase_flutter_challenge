import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// An abstract class of [AuthUserRepository] to decouple the implementation
/// This facilitates unit testing
abstract class AuthUserRepository {
  /// This contract to login as a user
  Future<Either<Failure?, AuthUser?>?>? loginWithDummyUser({required String email, required String password});

  /// This contract check if there is an existing authenticated user
  Future<Either<Failure?, AuthUser?>?>? isUserAuthenticated();

  /// This contract logs an existing user out
  Future<Either<Failure?, bool?>?>? logoutDummyUser();

}