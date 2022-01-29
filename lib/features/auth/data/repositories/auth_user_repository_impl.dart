import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/exceptions.dart';
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
  Future<Either<Failure?, AuthUser?>?>? isUserAuthenticated() async {
       try{

        final result =  await authCacheDataSource.isUserInLocalStorage();
        if(result == null){
          return Left(CacheFailure());
        }
        return Right(result);

       }on CacheException {
         return Left(CacheFailure());
       }
  }

  @override
  Future<Either<Failure?, AuthUser?>?>? loginWithDummyUser({required String email, required String password}) async {
    try{

      if(email != 'user@showwcase.com' && password != '123456'){
        return Left(CacheFailure());
      }

      final authUser =  await authCacheDataSource.saveUserInLocalStorage(email: email, password: password);
      return Right(authUser);

    }on CacheException {
        return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure?, bool?>?>? logoutDummyUser() async {
     final removed = await authCacheDataSource.removeUserFromLocalStorage();
     try{

       if(removed == null || !removed){
        return Left(CacheFailure());
       }

       return Right(removed);

     }on CacheException {
       return Left(CacheFailure());
     }
  }



}