import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// This use case abstract class enforces that every use case implements the call method
abstract class UseCase<Type, Params> {
  Future<Either<Failure?, Type?>?>? call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
