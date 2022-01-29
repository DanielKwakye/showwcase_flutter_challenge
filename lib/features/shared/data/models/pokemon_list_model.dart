import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// This is the list of pokemons for interacting with remote API
class PokemonListModel extends PokemonList {

  PokemonListModel({required count, next, previous, required results})
  : super(count: count, next: next, previous: previous, results: results);

  factory PokemonListModel.fromJson(Map<String, dynamic> j){
    final list = j['results'] as List;

    final pokemonList = list.map((e) {
      final jsonUrl = e['url'] as String;
      final aStr = jsonUrl.replaceAll(RegExp(r'[^0-9]'),'').substring(1); // '23'
      return Pokemon(id: aStr, name: e['name'], url: e['url']);
    }).toList();

    return PokemonListModel(
        count: j['count'],
        next: j['next'],
        previous: j['previous'],
        results: pokemonList
    );
  }

  @override
  String toString() {
    return "count:$count next: $next, previous: $previous";
  }

}