import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';

class PokemonDetailPage extends StatefulWidget {

  final Pokemon pokemon;
  const PokemonDetailPage({required this.pokemon, Key? key}) : super(key: key);

  @override
  _PokemonDetailPageController createState() => _PokemonDetailPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _PokemonDetailPageView extends WidgetView<PokemonDetailPage, _PokemonDetailPageController> {

  const _PokemonDetailPageView(_PokemonDetailPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color:  Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: ListTile(
          leading: CircleAvatar(child: Image.network(generatePokemonImageUrl(widget.pokemon.id)),),
          title: Text(widget.pokemon.name),
          subtitle: Text(widget.pokemon.url),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _PokemonDetailPageController extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) => _PokemonDetailPageView(this);
}