import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/entities/auth_user.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/login_with_dummy_user_use_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/logout_dummy_user_user_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';


class AuthUserBloc extends Cubit<BlocState> {

  final LoginWithDummyUserUseCase loginWithDummyUserUseCase;
  final LogoutDummyUserUseCase logoutDummyUserUseCase;
  final IsUserAuthenticatedUseCase isUserAuthenticatedUseCase;

  AuthUserBloc({
    required this.logoutDummyUserUseCase,
    required this.loginWithDummyUserUseCase,
    required this.isUserAuthenticatedUseCase
  }) : super(BlocState.initialState());


  Future<Either<Failure?, AuthUser?>?> login({required String email, required String password}) async {

    emit(BlocState.loadingState());
    final either = await loginWithDummyUserUseCase.call(LoginParams(email: email, password: password));

    either?.fold((l) {
      // Notify UI that there was an error whiles checking the server
      emit(BlocState<String>.errorState(failure: 'Login failed'));
    }, (r) {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'Login failed'));
      } else {
        // Notify UI of the pokemon data received from the server

        emit(BlocState<AuthUser>.successState(data: r));

      }

    });

    return either;
  }

  Future<Either<Failure?, AuthUser?>?> isUserAuth({required String email, required String password}) async {
       emit(BlocState.loadingState());

       final either = await isUserAuthenticatedUseCase.call(IsUserAuthParams());

       either?.fold((l) {
         // Notify UI that there was an error whiles checking the server
         emit(BlocState.errorState(failure: 'User is not authenticated'));
       }, (r) {

         if (r == null) {
           emit(BlocState.errorState(failure: 'User is not authenticated'));
         } else {
           // Notify UI of the pokemon data received from the server

           emit(BlocState<AuthUser>.successState(data: r));

         }

       });
  }

  Future<Either<Failure?, bool?>?> logoutUser() async {

    emit(BlocState.loadingState());
    final loggedOut = await logoutDummyUserUseCase.call(LogoutUserParams());
    emit(BlocState.successState(data: loggedOut));
    return loggedOut;

  }

}