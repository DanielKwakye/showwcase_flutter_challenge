import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

/// Pokemon Model
/// Model for interacting with remote storage
class PokemonModel extends Pokemon {

  const PokemonModel({required id, required name, required url}) : super (id: id, name: name, url: url);

}