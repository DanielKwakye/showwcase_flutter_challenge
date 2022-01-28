import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:showwcase_flutter_challenge/core/error/exceptions.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/models/pokemon_detail_model.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/models/pokemon_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';

/// This contract ensures that what ever client use to access the remote api with return these methods
abstract class PokemonRemoteDataSource {
  Future<PokemonList?> getPokemonListFromRemoteSource({int? limit , int? offset});
  Future<PokemonDetail?> getPokemonDetailRemoteSource({int? id});
}


class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {

  final http.Client client;
  PokemonRemoteDataSourceImpl({required this.client});


  @override
  Future<PokemonDetailModel?> getPokemonDetailRemoteSource({int? id}) async {
    if(id == null){
      return throw(ServerException());
    }

    Uri url = Uri.parse("$kBaseUrl/$id/");

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {

      final body = response.body;

      final clientResponse = json.decode(body);

      debugPrint('clientResponse $clientResponse');

      return PokemonDetailModel.fromJson(clientResponse);

    } else {

      throw ServerException();

    }

  }

  @override
  Future<PokemonListModel?> getPokemonListFromRemoteSource({int? limit, int? offset}) async {

    Uri url = Uri.parse("$kBaseUrl?limit=$limit&offset=$offset");

    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {

      final body = response.body;

      final clientResponse = json.decode(body);

      return PokemonListModel.fromJson(clientResponse);

    } else {

      throw ServerException();

    }

  }

}
