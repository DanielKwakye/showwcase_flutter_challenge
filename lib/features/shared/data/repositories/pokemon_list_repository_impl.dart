import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/exceptions.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/network/network_info.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_memory_data_source.dart';
import 'package:showwcase_flutter_challenge/features/shared/data/data_sources/pokemon_remote_data_source.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
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
  Future<Either<Failure?, PokemonList?>?>? addNewPokemon({Pokemon? pokemon}) {

  }

  @override
  Future<Either<Failure?, PokemonList?>?>? addPokemonToFavorite({Pokemon? pokemon}) {
    // TODO: implement addPokemonToFavorite
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure?, PokemonList?>?>? getPokemonList({int? offset = 0, int? limit = 20}) async {
    var isConnected = await networkInfo.isConnected;
    if(isConnected == null || !isConnected){
      return Left(ServerFailure());
    }

    try{

      final pokemonModelList = await pokemonRemoteDataSource.getPokemonListFromRemoteSource(offset: offset, limit: limit);

      if(pokemonModelList == null){
        return Left(ServerFailure());
      }

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

}