
import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// An abstract class of [PokemonListRepository] to decouple the implementation of the the list of pokemons
/// This facilitates unit testing
abstract class PokemonListRepository {
  //Future<Either<Failure?, List<PokemonList>?>?>? getPokemonList({required int? offset, int? limit = 20});
}