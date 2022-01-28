import 'package:bloc/bloc.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/add_new_pokemon_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/add_pokemon_to_favorite_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/get_pokemon_list_use_case.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/use_cases/search_pokemon_list_use_case.dart';

class PokemonBloc extends Cubit<BlocState> {

  final GetPokemonListUseCase getPokemonListUseCase;
  final AddPokemonToFavoriteUseCase addPokemonToFavoriteUseCase;
  final AddNewPokemonUseCase addNewPokemonUseCase;
  final SearchPokemonListUseCase searchPokemonListUseCase;

  PokemonBloc({
    required this.getPokemonListUseCase,
    required this.addNewPokemonUseCase,
    required this.addPokemonToFavoriteUseCase,
    required this.searchPokemonListUseCase,
  }) : super(BlocState.initialState());


  /// This method attempts to fetch pokemons from the pokemon API
  void fetchPokes({int limit = 20, int offset = 0}) async {

    // Notify UI that app is fetching list of pokemons
    emit(BlocState.loadingState());
    final either = await getPokemonListUseCase.call(Params(limit: limit, offset: offset));
    
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


}