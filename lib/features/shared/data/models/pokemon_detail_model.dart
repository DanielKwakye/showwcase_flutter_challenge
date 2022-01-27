import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';

/// Pokemon item detail model
/// For interacting with Pokemon detail API
class PokemonDetailModel extends PokemonDetail {

  const PokemonDetailModel({required id, required name, required url, required firmness})
      : super(id: id, name: name, url: url, firmness: firmness);

  factory PokemonDetailModel.fromJson(Map<String, dynamic> j){
    return PokemonDetailModel(
        id: j['count'],
        name: j['next'],
        url: j['previous'],
        firmness: FirmnessModel.fromJson(j['firmness'])
    );
  }

}

class FirmnessModel extends Firmness {
  const FirmnessModel({required name, required url}): super(name: name, url: url);

  factory FirmnessModel.fromJson(Map<String, dynamic> j){
    return FirmnessModel(
        name: j['name'],
        url: j['url'],
    );
  }

}