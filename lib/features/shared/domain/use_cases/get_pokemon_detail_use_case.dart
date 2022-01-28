import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';

class GetPokemonLDetailUseCase implements UseCase<PokemonDetail, Pokemon> {

  final PokemonListRepository pokemonListRepository;
  GetPokemonLDetailUseCase(this.pokemonListRepository);

  @override
  Future<Either<Failure?, PokemonDetail?>?>? call(Pokemon params) {

  }

}