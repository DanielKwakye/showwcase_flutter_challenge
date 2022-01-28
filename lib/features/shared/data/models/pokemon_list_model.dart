import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// This is the list of pokemons for interacting with remote API
class PokemonListModel extends PokemonList {

  const PokemonListModel({required count, next, previous, required results})
  : super(count: count, next: next, previous: previous, results: results);

  factory PokemonListModel.fromJson(Map<String, dynamic> j){
    final list = j['results'] as List;

    final pokemonList = list.map((e) {
      final jsonUrl = e['url'] as String;
      final String id = jsonUrl.substring(jsonUrl.length - 2, jsonUrl.length - 1);
      return Pokemon(id: id, name: e['name'], url: e['url']);
    }).toList();

    return PokemonListModel(
        count: j['count'],
        next: j['next'],
        previous: j['previous'],
        results: pokemonList
    );
  }

}