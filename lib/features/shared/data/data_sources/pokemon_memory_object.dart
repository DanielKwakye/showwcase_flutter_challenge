import 'package:dartz/dartz_streaming.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

class PokemonMemoryObject {

  List<Pokemon> originalList = [];
  PokemonList? pokemonList = const PokemonList(count: 0, results: []);
  List<Pokemon> pokemonFavoriteList = [];


  void addListItem(Pokemon pokemon){
    pokemonList?.results.add(pokemon);
  }


  void addPokemonToFavorite(Pokemon pokemon){
    pokemonFavoriteList.add(pokemon);
  }

  void removeFromFavorite(Pokemon pokemon){
    pokemonFavoriteList.remove(pokemon);
  }

  void clearAllFavorites(){
    pokemonFavoriteList.clear();
  }

  void setList(PokemonList? pl) {
    pokemonList = pl;
    if(pl == null) return;
    originalList.addAll(pl.results);
  }

  PokemonList? getList() {
    return pokemonList;
  }

  PokemonList? searchList(String text) {

    if(text.isEmpty) {
      pokemonList?.results.clear();
      pokemonList?.results.addAll(originalList);
      return pokemonList;
    }

    var list = originalList.where((element) => element.name.contains(text) || element.id.contains(text));
    pokemonList?.results.clear();
    pokemonList?.results.addAll(list);
    return pokemonList;
  }

}