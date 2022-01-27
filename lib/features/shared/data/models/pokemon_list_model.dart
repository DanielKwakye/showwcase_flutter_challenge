import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// This is the list of pokemons for interacting with remote API
class PokemonListModel extends PokemonList {

  const PokemonListModel({required count, next, previous, required results})
  : super(count: count, next: next, previous: previous, results: results);

  factory PokemonListModel.fromJson(Map<String, dynamic> j){
    return PokemonListModel(
        count: j['count'],
        next: j['next'],
        previous: j['previous'],
        results: j['results']
    );
  }

}