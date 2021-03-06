import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_memory_object.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

abstract class PokemonMemoryDataSource {
  Future<PokemonList?> getPokemonListFromMemorySource();
  Future<List<Pokemon>?> getPokemonFavoriteListFromMemorySource();
  Future<PokemonList?> setPokemonListInMemorySource(PokemonList? pokemonList, {bool freshData = true});
  Future<PokemonList?> addPokemonToMemorySource(Pokemon pokemon);
  Future<PokemonList?> addPokemonToFavoriteMemorySource(Pokemon pokemon);
  Future<PokemonList?> removePokemonFavoriteMemorySource(Pokemon pokemon);
  Future<PokemonList?> searchPokemonListFromMemorySource(String text);
}

class PokemonMemoryDataSourceImpl implements PokemonMemoryDataSource {

  final PokemonMemoryObject pokemonMemoryObject;
  PokemonMemoryDataSourceImpl(this.pokemonMemoryObject);

  @override
  Future<PokemonList?> addPokemonToFavoriteMemorySource(Pokemon pokemon)  async {
    return  pokemonMemoryObject.addPokemonToFavorite(pokemon);
  }

  @override
  Future<PokemonList?> removePokemonFavoriteMemorySource(Pokemon pokemon)  async {
    return  pokemonMemoryObject.removeFromFavorite(pokemon);
  }

  @override
  Future<PokemonList?> addPokemonToMemorySource(Pokemon pokemon) async {
    return  pokemonMemoryObject.addListItem(pokemon);
  }


  @override
  Future<PokemonList?> getPokemonListFromMemorySource() async {
    return pokemonMemoryObject.getList();
  }

  @override
  Future<PokemonList?> setPokemonListInMemorySource(PokemonList? pokemonList, {bool freshData = true}) async {
    pokemonMemoryObject.setList(pokemonList, freshData: freshData);
    return pokemonList;
  }

  @override
  Future<PokemonList?> searchPokemonListFromMemorySource(String text) async {
    return pokemonMemoryObject.searchList(text);
  }

  @override
  Future<List<Pokemon>?> getPokemonFavoriteListFromMemorySource() async {
    return pokemonMemoryObject.getFavoriteList();
  }

}
