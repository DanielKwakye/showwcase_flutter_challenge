import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/data_sources/auth_cache_data_source.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/repositories/auth_user_repository.dart';

/// This the a implementation of the authentication services
/// This works with any data source without affecting the app since it follows a contract
/// In this instance we would use A local caching system as the data source.
class AuthUserRepositoryImpl implements AuthUserRepository {

  AuthCacheDataSource authCacheDataSource;
  AuthUserRepositoryImpl(this.authCacheDataSource);

  @override
  Future<Either<Failure?, AuthUser?>?>? isUserAuthenticated() {

  }

  @override
  Future<Either<Failure?, AuthUser?>?>? loginWithDummyUser({required String email, required String password}) {
    // TODO: implement loginWithDummyUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure?, bool?>?>? logoutDummyUser() {
    // TODO: implement logoutDummyUser
    throw UnimplementedError();
  }



}