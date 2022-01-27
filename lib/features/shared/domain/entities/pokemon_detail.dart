import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

/// Pokemon item detail
/// Inherits pokemon properties
class PokemonDetail extends Pokemon {

  final Firmness firmness;
  const PokemonDetail({required id, required name, required url, required this.firmness}) : super(id: id, name: name, url: url);

}

class Firmness extends Equatable {

  final String name;
  final String url;

  const Firmness({required this.name, required this.url});

  @override
  List<Object> get props => [name, url];

}