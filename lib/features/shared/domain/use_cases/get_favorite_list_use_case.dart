import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';

class GetFavoriteListUseCase implements UseCase<List<Pokemon>, void>{

  final PokemonListRepository pokemonListRepository;
  GetFavoriteListUseCase(this.pokemonListRepository);

  @override
  Future<Either<Failure?, List<Pokemon>?>?>? call(void params) async {
    return pokemonListRepository.getFavoriteList();
  }

}
