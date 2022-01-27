import 'package:equatable/equatable.dart';
/// This class has been created handle general failures in the app
/// Its shared accross the app
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
/// Failure from retrieving remote storage data resource
class ServerFailure extends Failure {}
/// Failure from retrieving local storage data resource
class CacheFailure extends Failure {}
