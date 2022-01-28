import 'package:equatable/equatable.dart';

/// Pokemon item
/// We extends [Equatable] on entities to enable value comparisons on the pokemon object
class Pokemon {

  final String id;
  final String name;
  final String url;
  late bool isFavorite;

  Pokemon({required this.id,required this.name,required this.url, this.isFavorite = false});

  // @override
  // List<Object?> get props => [id, name, url];

  @override
  String toString() {
    return "(id: $id, name: $name, url: $url, isFavorite: $isFavorite)";
  }


}