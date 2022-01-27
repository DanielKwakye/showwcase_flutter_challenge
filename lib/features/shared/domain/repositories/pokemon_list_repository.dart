import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// An abstract class of [PokemonListRepository] to decouple the implementation
/// This facilitates unit testing
abstract class PokemonListRepository {
  /// This contract gets the list of pokemon items
  Future<Either<Failure?, PokemonList?>?>? getPokemonList({int? offset = 0, int? limit = 20});

  /// This contract adds a new item to the list of pokemon items
  Future<Either<Failure?, PokemonList?>?>? addNewPokemon({Pokemon pokemon});

  /// This contract search through  the list of pokemon items
  Future<Either<Failure?, PokemonList?>?>? searchPokemonList({required String text});

  /// This contract adds a pokemon item to favorites
  Future<Either<Failure?, PokemonList?>?>? addPokemonToFavorite({Pokemon pokemon});
}