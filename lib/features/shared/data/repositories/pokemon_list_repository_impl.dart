import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/network/network_info.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_remote_data_source.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository{

  PokemonRemoteDataSource pokemonRemoteDataSource;
  NetworkInfo networkInfo;

  PokemonListRepositoryImpl({required this.pokemonRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure?, PokemonList?>?>? addNewPokemon({Pokemon? pokemon}) {
    // TODO: implement addNewPokemon
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? addPokemonToFavorite({Pokemon? pokemon}) {
    // TODO: implement addPokemonToFavorite
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? getPokemonList({int? offset = 0, int? limit = 20}) {
    // TODO: implement getPokemonList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? searchPokemonList({required String text}) {
    // TODO: implement searchPokemonList
    throw UnimplementedError();
  }

}