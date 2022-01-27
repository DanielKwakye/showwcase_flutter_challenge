import 'package:bloc/bloc.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
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



}