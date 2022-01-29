import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

/// Pokemon item detail
/// Inherits pokemon properties
class PokemonDetail extends Pokemon {

  List<Ability> abilities;
  int baseExperience;
  int weight;
  List<NameUrl> form;

  PokemonDetail({
    required id,
    required name,
    required url,
    required this.abilities,
    required this.baseExperience,
    required this.form,
    required this.weight
  }) : super(id: id, name: name, url: url);


}

class Ability {
  final bool isHidden;
  final int slot;
  final NameUrl ability;

  Ability({required this.isHidden, required this.slot, required this.ability});

}

class NameUrl {

  final String name;
  final String url;

  NameUrl({required this.url, required this.name});


}