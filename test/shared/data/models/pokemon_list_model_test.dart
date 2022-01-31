import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/models/pokemon_list_model.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

import '../../../fixtures/fixture_reader.dart';

void main(){
  
  /// init state
  setUpAll(() {
    
  });
  
  test('should return a valid model when pokemon json data is fetched', () async {
  
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('pokemon_list.json'));

      // act
      final pokemonList = PokemonListModel.fromJson(jsonMap);

      // assert
      expect(pokemonList.count, 1118);
  
    });
  

}