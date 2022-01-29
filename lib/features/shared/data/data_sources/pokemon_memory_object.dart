import 'package:dartz/dartz_streaming.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

class PokemonMemoryObject {

  List<Pokemon> originalList = [];
  List<Pokemon> addedList = [];
  late PokemonList? pokemonList;


  PokemonList? addListItem(Pokemon pokemon){
    // check if there is an existing pokemon with same ID

        final existingPokemonIndex = pokemonList?.results.indexWhere((element) {
          return element.id == pokemon.id;
        });

        if(existingPokemonIndex == null){
          return null;
        }

        if(existingPokemonIndex != -1){
          return null;
        }

        pokemonList?.results.add(pokemon);
        originalList.add(pokemon);
        addedList.add(pokemon);
        return pokemonList;


  }


  PokemonList? addPokemonToFavorite(Pokemon pokemon){
    final index = pokemonList?.results.indexWhere((element) => element.id == pokemon.id);
    pokemonList?.results[index!].isFavorite = true;
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
    originalList.addAll(addedList);
    pokemonList?.results.clear();
    pokemonList?.results.addAll(originalList);

  }

  PokemonList? getList() {
    return pokemonList;
  }

  List<Pokemon>? getFavoriteList() {
    final list = pokemonList?.results.where((element) => element.isFavorite == true).toList();
    print("list: $list");
    return list;
  }

  PokemonList? searchList(String text) {

    if(text.isEmpty) {
      pokemonList?.results.clear();
      pokemonList?.results.addAll(originalList);
      return pokemonList;
    }

    var list = originalList.where((element) => element.name.contains(text) || element.id == text);
    pokemonList?.results.clear();
    pokemonList?.results.addAll(list);
    return pokemonList;
  }

}