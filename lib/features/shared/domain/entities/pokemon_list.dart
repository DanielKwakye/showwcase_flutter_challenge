import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

/// This is the list of pokemons per page
class PokemonList {

  final int count;
  String? next;
  String? previous;
  final List<Pokemon> results;

  PokemonList({required this.count, this.next, this.previous, required this.results});

}