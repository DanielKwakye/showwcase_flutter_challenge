import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

/// This is the list of pokemons per page
class PokemonList extends Equatable {

  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  const PokemonList({required this.count, this.next, this.previous, required this.results});

  @override
  List<Object?> get props => [];

}