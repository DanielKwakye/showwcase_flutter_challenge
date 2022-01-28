import 'package:dartz/dartz_streaming.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

class PokemonMemoryObject {

  List<Pokemon> originalList = [];
  PokemonList? pokemonList = const PokemonList(count: 0, results: []);


  PokemonList? addListItem(Pokemon pokemon){
    pokemonList?.results.add(pokemon);
    originalList.add(pokemon);
    return pokemonList;
  }


  PokemonList? addPokemonToFavorite(Pokemon pokemon){
    final p = pokemonList?.results.firstWhere((element) => element.id == pokemon.id, orElse: () => pokemon);
    p?.isFavorite = true;
    return pokemonList;
  }

  PokemonList? removeFromFavorite(Pokemon pokemon){
    final p = pokemonList?.results.firstWhere((element) => element.id == pokemon.id, orElse: () => pokemon);
    p?.isFavorite = false;
    return pokemonList;
  }

  void setList(PokemonList? pl) {
    pokemonList = pl;
    if(pl == null) return;
    originalList.clear();
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