import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showwcase_flutter_challenge/core/error/exceptions.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/models/auth_user_model.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';

/// We create the data source cache to decouple implementation of the caching system.
/// Hence SharedPreference or any local caching system can be used without affecting the app cache structure
abstract class AuthCacheDataSource {

  Future<AuthUserModel?> saveUserInLocalStorage({required String email, required String password});
  Future<bool?> removeUserFromLocalStorage();
  Future<AuthUser?> isUserInLocalStorage();

}


/// Implementation of CacheDataSource
/// [AuthCacheDataSource] can be implemented by any data source
/// We would use sharedPreference in this app
/// 
class AuthCacheDataSourceImpl implements AuthCacheDataSource{
  
  SharedPreferences sharedPreferences;
  AuthCacheDataSourceImpl(this.sharedPreferences);

  @override
  Future<AuthUserModel?> saveUserInLocalStorage({required String email, required String password}) async {

    final authUser = AuthUserModel(name: 'Dummy', email: email, password:  password);
    final encodedUser = json.encode(authUser.toJson());
    final saved =  await sharedPreferences.setString(kUser, encodedUser);
    if(!saved){
      throw CacheException();
    }

    return authUser;
  }

  @override
  Future<AuthUser?> isUserInLocalStorage() async {
     final userString =  sharedPreferences.getString(kUser);
     if(userString == null){
       throw CacheException();
     }

     final decodedUser = json.decode(userString) as Map<String, dynamic>;
     final authUser = AuthUserModel.fromJson(decodedUser);
     return authUser;
  }

  @override
  Future<bool?> removeUserFromLocalStorage() async {
   final removed = await sharedPreferences.clear();
   if(!removed){
     throw CacheException();
   }

   return removed;

  }

  
}