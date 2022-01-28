import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

class PokemonMemoryObject {

  late PokemonList pokemonList;
  late List<Pokemon> pokemonFavoriteList;

  static final PokemonMemoryObject _singleton = PokemonMemoryObject._internal();
  factory PokemonMemoryObject() => _singleton;

  PokemonMemoryObject._internal(){
    pokemonList = const PokemonList(count: 0, results: []);
    pokemonFavoriteList = [];
  }// private constructor

  void addListItem(Pokemon pokemon){
    pokemonList.results.add(pokemon);
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

}