import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';

class AddPokemonToFavoriteUseCase implements UseCase<PokemonList, Pokemon>{

  PokemonListRepository pokemonListRepository;
  AddPokemonToFavoriteUseCase(this.pokemonListRepository);

  @override
  Future<Either<Failure?, PokemonList?>?>? call(Pokemon params) async {
      return await pokemonListRepository.addPokemonToFavorite(pokemon: params);
  }

}