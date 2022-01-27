import 'package:equatable/equatable.dart';

/// Pokemon item
/// We extends [Equatable] on entities to enable value comparisons on the pokemon object
class Pokemon extends Equatable {

  final String id;
  final String name;
  final String url;

  const Pokemon({required this.id,required this.name,required this.url});

  @override
  List<Object?> get props => [id, name, url];


}