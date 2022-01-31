import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/data_sources/auth_cache_data_source.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/models/auth_user_model.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';

class MockAuthCacheDataSource extends Mock implements AuthCacheDataSource {}

void main(){

  late MockAuthCacheDataSource mockAuthCacheDataSource;
  late AuthUserRepositoryImpl authUserRepositoryImpl;
  const tEmail = 'user@showwcase.com';
  const tInvalidEmail = 'invalid@showwcase.com';
  const tInvalidPassword = 'password';
  const tPassword = '123456';
  const tAuthUser =  AuthUserModel(name: 'Dummy', email: tEmail, password: tPassword);

  /// init state
  setUpAll(() {
    mockAuthCacheDataSource = MockAuthCacheDataSource();
    authUserRepositoryImpl = AuthUserRepositoryImpl(mockAuthCacheDataSource);
  });

  test('should return authenticated user when login is successful', () async {

      // arrange
      when(mockAuthCacheDataSource.saveUserInLocalStorage(email: tEmail, password: tPassword))
          .thenAnswer((realInvocation) async => tAuthUser);

      // act
      final either = await authUserRepositoryImpl.loginWithDummyUser(email: tEmail, password: tPassword);

      // assert
      // verify that mockAuthCacheDataSource.saveUserInLocalStorage was called
      verify(mockAuthCacheDataSource.saveUserInLocalStorage(email: tEmail, password: tPassword));
      expect(either, const Right(tAuthUser)); // expecting that the result after running loginWithDummyUser returns the authenticated user


    });


  test('should return CacheFailure when invalid email and password is entered', () async {

      // arrange
      when(mockAuthCacheDataSource.saveUserInLocalStorage(email: tInvalidEmail, password: tInvalidPassword))
        .thenAnswer((realInvocation) async => tAuthUser);

      // act
      final either = await authUserRepositoryImpl.loginWithDummyUser(email: tInvalidEmail, password: tInvalidPassword);

      // assert
      // verify that there were no interactions with saveUserInLocalStorage because the email is wrong
      verifyZeroInteractions(mockAuthCacheDataSource);
      expect(either, Left(CacheFailure())); // should fail cus the email and password are incorrect

    });

}