import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/exceptions.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/network/network_info.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_memory_data_source.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_remote_data_source.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';

class PokemonListRepositoryImpl implements PokemonListRepository{

  PokemonRemoteDataSource pokemonRemoteDataSource;
  NetworkInfo networkInfo;
  PokemonMemoryDataSource pokemonMemoryDataSource;

  PokemonListRepositoryImpl({
    required this.pokemonRemoteDataSource,
    required this.networkInfo,
    required this.pokemonMemoryDataSource
  });

  @override
  Future<Either<Failure?, PokemonList?>?>? addNewPokemon({Pokemon? pokemon}) async {
    final result = await pokemonMemoryDataSource.addPokemonToMemorySource(pokemon!);
    if(result == null){
      return Left(ServerFailure());
    }
    return Right(result);
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? addPokemonToFavorite({Pokemon? pokemon}) async {
     final result = await pokemonMemoryDataSource.addPokemonToFavoriteMemorySource(pokemon!);
     return Right(result);
  }

  /// this method gets pokemons from the api and set it to the remote source
  @override
  Future<Either<Failure?, PokemonList?>?>? getPokemonList({int? offset, int? limit}) async {
    var isConnected = await networkInfo.isConnected;
    if(isConnected == null || !isConnected){
      return Left(ServerFailure());
    }

    try{

      // fetch pokemon from api
      final pokemonModelList = await pokemonRemoteDataSource.getPokemonListFromRemoteSource(offset: offset, limit: limit);

      if(pokemonModelList == null){
        return Left(ServerFailure());
      }

      // set pokemon to remote souce
      pokemonMemoryDataSource.setPokemonListInMemorySource(pokemonModelList);
      return Right(await pokemonMemoryDataSource.getPokemonListFromMemorySource(limit: limit, offset: offset));

    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? searchPokemonList({required String text}) async {
    final result = await pokemonMemoryDataSource.searchPokemonListFromMemorySource(text);
    return Right(result);

  }

  @override
  Future<Either<Failure?, PokemonDetail?>?>? getPokemonDetail({required Pokemon pokemon}) async {
    final result = await pokemonRemoteDataSource.getPokemonDetailRemoteSource(pokemon: pokemon);

    try{
          return Right(result);
        }on ServerException {
            return Left(ServerFailure());
        }
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? removePokemonFromFavorite({Pokemon? pokemon}) async {
    final result = await pokemonMemoryDataSource.removePokemonFavoriteMemorySource(pokemon!);
    return Right(result);
  }

  @override
  Future<Either<Failure?, List<Pokemon>?>?>? getFavoriteList() async {
    final result = await pokemonMemoryDataSource.getPokemonFavoriteListFromMemorySource();
    return Right(result);
  }

}