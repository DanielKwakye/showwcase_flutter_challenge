import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:showwcase_flutter_challenge/core/network/network_info.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/data_sources/auth_cache_data_source.dart';
import 'package:showwcase_flutter_challenge/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/repositories/auth_user_repository.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/login_with_dummy_user_use_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/logout_dummy_user_user_case.dart';
import 'package:showwcase_flutter_challenge/features/auth/presentation/manager/auth_user_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_remote_data_source.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/repositories/pokemon_list_repository_impl.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/add_new_pokemon_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/add_pokemon_to_favorite_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/get_pokemon_list_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/search_pokemon_list_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => PokemonBloc(
      getPokemonListUseCase: sl(),
      addNewPokemonUseCase: sl(),
      addPokemonToFavoriteUseCase: sl(),
      searchPokemonListUseCase: sl()
  ));
  sl.registerFactory(() => AuthUserBloc(
      isUserAuthenticatedUseCase: sl(),
      loginWithDummyUserUseCase: sl(),
      logoutDummyUserUseCase: sl()
  ));

  // Use cases for pokemon
  sl.registerLazySingleton(() => GetPokemonListUseCase(pokemonListRepository: sl()));
  sl.registerLazySingleton(() => SearchPokemonListUseCase(sl()));
  sl.registerLazySingleton(() => AddNewPokemonUseCase(sl()));
  sl.registerLazySingleton(() => AddPokemonToFavoriteUseCase(sl()));

  // Use cases for authentication
  sl.registerLazySingleton(() => LoginWithDummyUserUseCase(authUserRepository: sl()));
  sl.registerLazySingleton(() => LogoutDummyUserUseCase(authUserRepository: sl()));
  sl.registerLazySingleton(() => IsUserAuthenticatedUseCase(authUserRepository: sl()));

  // // pokemon list Repository
  sl.registerLazySingleton<PokemonListRepository>(() =>
      PokemonListRepositoryImpl(
        pokemonRemoteDataSource: sl(),
        networkInfo: sl()
      )
  );
  // authentication repository
  sl.registerLazySingleton<AuthUserRepository>(() =>
      AuthUserRepositoryImpl(sl())
  );
  //
  // // Data sources
  sl.registerLazySingleton<PokemonRemoteDataSource>(() =>
      PokemonRemoteDataSourceImpl(client: sl())
  );

  sl.registerLazySingleton<AuthCacheDataSource>(() =>
      AuthCacheDataSourceImpl(sl()));

  //
  // //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());

}