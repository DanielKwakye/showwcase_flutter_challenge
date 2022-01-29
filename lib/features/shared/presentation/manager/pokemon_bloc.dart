import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/add_new_pokemon_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/add_pokemon_to_favorite_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/get_favorite_list_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/get_pokemon_detail_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/get_pokemon_list_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/remove_pokemon_from_favorite_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/search_pokemon_list_use_case.dart';

class PokemonBloc extends Cubit<BlocState> {

  final GetPokemonListUseCase getPokemonListUseCase;
  final AddPokemonToFavoriteUseCase addPokemonToFavoriteUseCase;
  final RemovePokemonFromFavoriteUseCase removePokemonFromFavoriteUseCase;
  final AddNewPokemonUseCase addNewPokemonUseCase;
  final SearchPokemonListUseCase searchPokemonListUseCase;
  final GetPokemonLDetailUseCase getPokemonLDetailUseCase;
  final GetFavoriteListUseCase getFavoriteListUseCase;

  PokemonBloc({
    required this.getPokemonListUseCase,
    required this.addNewPokemonUseCase,
    required this.addPokemonToFavoriteUseCase,
    required this.removePokemonFromFavoriteUseCase,
    required this.searchPokemonListUseCase,
    required this.getPokemonLDetailUseCase,
    required this.getFavoriteListUseCase,
  }) : super(BlocState.initialState());


  /// This method attempts to fetch pokemons from the pokemon API
  void fetchPokes({String? url}) async {

    // Notify UI that app is fetching list of pokemons
    emit(BlocState.loadingState());
    final either = await getPokemonListUseCase.call(url);

    either?.fold((l) {

      // Notify UI that there was an error whiles fetch the data from the server
      emit(BlocState.errorState(failure: l.toString()));

    }, (r)  {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'No pokes found'));
      } else {
        // Notify UI of the pokemon data received from the server
        emit(BlocState<PokemonList>.successState(data: r));
      }

    });
  }

  /// This method gets a poke detail from the server
  /// This emits Failure or PokemonDetail object
  void getPokeDetail(Pokemon pokemon) async {

    emit(BlocState.loadingState());
    final either = await getPokemonLDetailUseCase.call(pokemon);

    either?.fold((l) {
      // Notify UI that there was an error whiles checking the server
      emit(BlocState<String>.errorState(failure: 'Unable to fetch detail'));
    }, (r) {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'Unable to fetch detail'));
      } else {
        // Notify UI of the pokemon data received from the server

        emit(BlocState<PokemonDetail>.successState(data: r));

      }

    });

  }

  /// This method  searches from the pokemon memory source
  /// This method emits [PokemonList] when search is found
  void searchPokemon(String text) async {

    // Notify UI that app is fetching list of pokemons
    emit(BlocState.loadingState());
    final either = await searchPokemonListUseCase.call(text);

    either?.fold((l) {

      // Notify UI that there was an error whiles fetch the data from the server
      emit(BlocState.errorState(failure: l.toString()));

    }, (r)  {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'No pokes found'));
      } else {
        // Notify UI of the pokemon data received from the server
        emit(BlocState<PokemonList>.successState(data: r));
      }

    });
  }

  /// This adds to pokemon favorite
  void addPokemonToFavorite(Pokemon pokemon) async {

    emit(BlocState.loadingState());
    final either = await addPokemonToFavoriteUseCase.call(pokemon);


    either?.fold((l) {

      // Notify UI that there was an error whiles fetch the data from the server
      emit(BlocState.errorState(failure: l.toString()));

    }, (r) {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'No pokes found'));
      } else {
        // Notify UI of the pokemon data received from the server

        emit(BlocState<PokemonList>.successState(data: r));
      }

    });


  }

  /// This removes to pokemon fromfavorite
  Future<void> removePokemonFromFavorite(Pokemon pokemon) async {

    emit(BlocState.loadingState());
    final either = await removePokemonFromFavoriteUseCase.call(pokemon);


    either?.fold((l) {

      // Notify UI that there was an error whiles fetch the data from the server
      emit(BlocState.errorState(failure: l.toString()));

    }, (r) {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'No pokes found'));
      } else {
        // Notify UI of the pokemon data received from the server

        emit(BlocState<PokemonList>.successState(data: r));
      }

    });


  }

  /// fetchFavoritePokes
  void fetchFavoritePokes() async {

    emit(BlocState.loadingState());
    final either = await getFavoriteListUseCase(null);


    either?.fold((l) {

      // Notify UI that there was an error whiles fetch the data from the server
      emit(BlocState.errorState(failure: l.toString()));

    }, (r) {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'No pokes found'));
      } else {
        // Notify UI of the pokemon data received from the server

        emit(BlocState<List<Pokemon>>.successState(data: r));
      }

    });


  }


  /// This removes to pokemon from favorite
  Future<Either<Failure?, PokemonList?>?> addNewPokemon(Pokemon pokemon) async {

    emit(BlocState.loadingState());
    final either = await addNewPokemonUseCase.call(pokemon);


    either?.fold((l) {

      // Notify UI that there was an error whiles fetch the data from the server
      emit(BlocState.errorState(failure: l.toString()));

    }, (r) {

      if (r == null) {
        emit(BlocState<String>.errorState(failure: 'No pokes found'));
      } else {
        // Notify UI of the pokemon data received from the server

        emit(BlocState<PokemonList>.successState(data: r));

      }

    });

    return either;


  }


}