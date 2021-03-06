import 'package:dartz/dartz.dart';
import 'package:showwcase_flutter_challenge/core/error/failures.dart';
import 'package:showwcase_flutter_challenge/core/usecases/usecase.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/repositories/pokemon_list_repository.dart';

class GetPokemonListUseCase implements UseCase<PokemonList, String?> {

  final PokemonListRepository pokemonListRepository;
  GetPokemonListUseCase({required this.pokemonListRepository});

  @override
  Future<Either<Failure?, PokemonList?>?>? call(params) async {
    return await pokemonListRepository.getPokemonList(url: params);
  }


}
