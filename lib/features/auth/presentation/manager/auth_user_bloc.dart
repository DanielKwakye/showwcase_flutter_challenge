import 'package:bloc/bloc.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/login_with_dummy_user_use_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/logout_dummy_user_user_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/get_pokemon_list_use_case.dart';

class AuthUserBloc extends Cubit<BlocState> {

  final LoginWithDummyUserUseCase loginWithDummyUserUseCase;
  final LogoutDummyUserUseCase logoutDummyUserUseCase;
  final IsUserAuthenticatedUseCase isUserAuthenticatedUseCase;

  AuthUserBloc({
    required this.logoutDummyUserUseCase,
    required this.loginWithDummyUserUseCase,
    required this.isUserAuthenticatedUseCase
  }) : super(BlocState.initialState());



}