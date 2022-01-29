import 'package:equatable/equatable.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';

/// Pokemon item detail model
/// For interacting with Pokemon detail API
class PokemonDetailModel extends PokemonDetail {

   PokemonDetailModel(
       {
         required id,
         required name,
         required url,
         required abilities,
         required baseExperience,
         required form,
         required weight
       })
      : super(id: id, name: name, url: url, abilities: abilities,
     baseExperience: baseExperience, form: form, weight: weight
   );

   factory PokemonDetailModel.fromJson(Pokemon pokemon, Map<String, dynamic> json){

     final abilitiesJson = json['abilities'] as List;
     final formsJson = json['forms'] as List;

     List<Ability> abilities = abilitiesJson.map((e) => AbilityModel.fromJson(e)).toList();
     List<NameUrl> forms = formsJson.map((e) => NameUrlModel.fromJson(e)).toList();

     return PokemonDetailModel(
         id: pokemon.id,
         name: pokemon.name,
         url: pokemon.url,
         abilities: abilities,
         baseExperience: json['base_experience'] as int,
         form: forms,
         weight: json['weight']  as int
     );


   }

}



class AbilityModel extends Ability {

  AbilityModel({required isHidden, required slot, required ability})
    :super(isHidden: isHidden, ability: ability, slot: slot)
  ;

  factory AbilityModel.fromJson(Map<String, dynamic> json){
    return AbilityModel(
      isHidden: json['is_hidden'] as bool,
      slot: json['slot'] as int,
      ability: NameUrlModel.fromJson(json['ability'])
    );
  }

  @override
  String toString() {
    return "isHidden: $isHidden, slot: $slot";
  }


}

class NameUrlModel extends NameUrl {

  NameUrlModel({required url, required name}): super(url: url, name: name);

  factory NameUrlModel.fromJson(Map<String, dynamic> json){
    return NameUrlModel(url: json['url'] as String, name: json['name'] as String);
  }

  @override
  String toString() {
    return "name: $name, slot: $url";
  }

}

