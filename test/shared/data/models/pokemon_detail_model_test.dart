import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/models/pokemon_detail_model.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

import '../../../fixtures/fixture_reader.dart';

void main(){

  /// init state
  setUpAll(() {

  });

  test('should return a valid model when pokemon detail json data is fetched', () async {

    // arrange
    final pokemon = Pokemon(id: '1', name: 'test', url: 'test-url', isFavorite: true);
    final Map<String, dynamic> jsonMap = json.decode(fixture('pokemon_detail.json'));

    // act
    final pokemonDetail = PokemonDetailModel.fromJson(pokemon, jsonMap);

    // assert
    expect(pokemonDetail.weight, 1000);

  });


}