import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/models/auth_user_model.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';

/// We create the data source cache to decouple implementation of the caching system.
/// Hence SharedPreference or any local caching system can be used without affecting the app cache structure
abstract class AuthCacheDataSource {

  Future<Either<Failure?, AuthUserModel?>> getUserFromLocalStorage();
  Future<Either<Failure?, AuthUser?>> saveUserToLocalStorage(AuthUserModel authUserModel);
  Future<bool?> removeUserFromStorage();
  Future<bool?> isUserInLocalStorage();

}


/// Implementation of CacheDataSource
/// [AuthCacheDataSource] can be implemented by any data source
/// We would use sharedPreference in this app
/// 
class AuthCacheDataSourceImpl implements AuthCacheDataSource{
  
  SharedPreferences sharedPreferences;
  AuthCacheDataSourceImpl(this.sharedPreferences);

  @override
  Future<Either<Failure?, AuthUserModel?>> getUserFromLocalStorage() async {

    final userString =  sharedPreferences.getString(kUser);
    if(userString == null){
      return Left(CacheFailure());
    }
    return Right(AuthUserModel.fromJson(json.decode(userString)));
  }

  @override
  Future<bool?> isUserInLocalStorage() async {
    return sharedPreferences.containsKey(kUser);
  }

  @override
  Future<bool?> removeUserFromStorage() async {
   return sharedPreferences.clear();
  }

  @override
  Future<Either<Failure?, AuthUser?>> saveUserToLocalStorage(AuthUserModel authUserModel) async {
    removeUserFromStorage();
    final userToJson = authUserModel.toJson();

    final saved =  await sharedPreferences.setString(kUser, json.encode(userToJson));
    if(!saved){
      return Left(CacheFailure());
    }
    final AuthUser authUser = authUserModel;
    return Right(authUser);
  }


  
}