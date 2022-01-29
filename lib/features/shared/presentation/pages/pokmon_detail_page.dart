import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/enums.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/injector.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_detail.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/animated_column_widget.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/list_tile_shimmer.dart';

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
      body:
      Container(
        color: Colors.white,
        child: BlocBuilder(
        bloc: state._pokemonBloc,
        builder: (ctx, bloc){

          // loading state
          if(bloc is LoadingState) {
            return const AppListTileShimmer();
          }

          // loading state
          if(bloc is ErrorState){
            return Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const ListTile(
                leading:  CircleAvatar(child: Icon(Icons.info_outline),),
                title:  Text('Unable to load pokemon detail. This may be due to the fact that this pockmon was generated locally and does not exist on the server'
                  , textAlign: TextAlign.center,
                ),
              ),
            );
          }

          // success state
          if(bloc is SuccessState<PokemonDetail>){
            return SingleChildScrollView(
              child: AnimatedColumnWidget(
                  animateType: AnimateType.slideUp,
                  children: [
                    // detail

                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color:  backgroundGray,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Image.network(generatePokemonImageUrl(widget.pokemon.id)),),
                        title: const Text('Base experience'),
                        trailing: Text("${bloc.data.baseExperience}"),
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color:  backgroundGray,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Image.network(generatePokemonImageUrl(widget.pokemon.id)),),
                        title: const Text('Weight'),
                        trailing: Text("${bloc.data.weight}"),
                      ),
                    ),

                    const Divider(),
                    const Text('Abilities', style: TextStyle(fontSize: 20),),
                    const Divider(),

                    ...bloc.data.abilities.map((e) => Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color:  backgroundGray,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Image.network(generatePokemonImageUrl(widget.pokemon.id)),),
                        title: Text(e.ability.name),
                        subtitle: Text("Is hidden: ${e.isHidden}"),
                        trailing: Text("slot: ${e.slot}"),
                      ),
                    ),),

              //      Form /////
                    const Divider(),
                    const Text('Form', style: TextStyle(fontSize: 20),),
                    const Divider(),

                    ...bloc.data.form.map((e) => Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color:  backgroundGray,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(
                        leading: CircleAvatar(child: Image.network(generatePokemonImageUrl(widget.pokemon.id)),),
                        title: Text(e.name),
                        subtitle: Text(e.url),
                      ),
                    ),)


              ]),
            );
          }

          return Container();

        },),
      )

    );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _PokemonDetailPageController extends State<PokemonDetailPage> {

  final _pokemonBloc = getPokemonBloc;

  @override
  Widget build(BuildContext context) => _PokemonDetailPageView(this);

  @override
  void initState() {

    super.initState();
    onWidgetBindingComplete(onComplete: (){
      _pokemonBloc.getPokeDetail(widget.pokemon);
    });
  }

}