import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_memory_object.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

abstract class PokemonMemoryDataSource {
  Future<PokemonList?> getPokemonListFromMemorySource({int? limit , int? offset});
  Future<PokemonDetail?> getPokemonDetailMemorySource({int? id});
  Future<PokemonList?> addPokemonToMemorySource(PokemonDetail pokemonDetail);
  Future<PokemonList?> addPokemonToFavoriteMemorySource(PokemonDetail pokemonDetail);
}

class PokemonMemoryDataSourceImpl implements PokemonMemoryDataSource {

  final PokemonMemoryObject pokemonMemoryObject;

  PokemonMemoryDataSourceImpl(this.pokemonMemoryObject);

  @override
  Future<PokemonList?> addPokemonToFavoriteMemorySource(PokemonDetail pokemonDetail) {
    // TODO: implement addPokemonToFavoriteMemorySource
    throw UnimplementedError();
  }

  @override
  Future<PokemonList?> addPokemonToMemorySource(PokemonDetail pokemonDetail) {
    // TODO: implement addPokemonToMemorySource
    throw UnimplementedError();
  }

  @override
  Future<PokemonDetail?> getPokemonDetailMemorySource({int? id}) {
    // TODO: implement getPokemonDetailMemorySource
    throw UnimplementedError();
  }

  @override
  Future<PokemonList?> getPokemonListFromMemorySource({int? limit, int? offset}) {
    // TODO: implement getPokemonListFromMemorySource
    throw UnimplementedError();
  }

}
