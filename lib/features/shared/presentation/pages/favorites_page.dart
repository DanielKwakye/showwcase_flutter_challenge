import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/images.dart';
import 'package:showwcase_flutter_challenge/core/utils/injector.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/list_tile_shimmer.dart';
import 'package:auto_route/auto_route.dart';

class FavoritesPage extends StatefulWidget {

  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageController createState() => _FavoritesPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _FavoritesPageView extends WidgetView<FavoritesPage, _FavoritesPageController> {

  const _FavoritesPageView(_FavoritesPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
            color: backgroundGray,
            child: BlocBuilder(
              bloc: state._pokeman,
              builder: (context, bloc) {
                return CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      title: Text('Favorites'),
                    ),

                    if (bloc is LoadingState)
                    const SliverToBoxAdapter(
                      child: AppListTileShimmer(),
                    ),

                    if (bloc is ErrorState)
                      const SliverToBoxAdapter(
                        child: ListTile(
                          leading: Icon(Icons.error_outline),
                          title: Text('Unable to fetch favortes'),
                        ),
                      ),

                    if (bloc is SuccessState<List<Pokemon>> &&
                        bloc.data.isEmpty)
                      const SliverToBoxAdapter(
                          child: ListTile(
                            leading: Icon(Icons.error_outline),
                            title: Text("No pokes found"),
                          )),

                    if (bloc is SuccessState<List<Pokemon>> &&
                        bloc.data.isNotEmpty)
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (ctx, i) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Image.network(generatePokemonImageUrl(
                                        bloc.data[i].id), errorBuilder: (ctx, t, r) {
                                      return Image.asset(appLogo);
                                    },),
                                  ),
                                  title: Text(bloc.data[i].name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () => context.router.push(
                                              PokemonDetailPageRoute(
                                                  pokemon: bloc.data[i])),
                                          icon: const Icon(
                                              Icons.remove_red_eye_rounded)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () => state.addToFavoriteTapped(
                                            bloc.data[i]),
                                        icon: bloc.data[i].isFavorite
                                            ? const Icon(Icons.favorite)
                                            : const Icon(Icons.favorite_outline),
                                      ),
                                    ],
                                  ),
                                  // onTap: () => context.router.push(PokemonDetailPageRoute(pokemon: bloc.data.results[i])),
                                ),
                              );
                            },
                            childCount: bloc.data.length,
                      )),


                    //SliverList(delegate: delegate)
                  ],
                );
              }
            ),
          ),
   );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _FavoritesPageController extends State<FavoritesPage> {

  final _pokeman =  PokemonBloc(
    getPokemonListUseCase: sl(),
    addNewPokemonUseCase: sl(),
    addPokemonToFavoriteUseCase: sl(),
    removePokemonFromFavoriteUseCase: sl(),
    searchPokemonListUseCase: sl(),
    getPokemonLDetailUseCase: sl(),
     getFavoriteListUseCase: sl()
  );

  @override
  void initState() {
    super.initState();
    onWidgetBindingComplete(onComplete: () => _pokeman.fetchFavoritePokes());
  }

  @override
  Widget build(BuildContext context) => _FavoritesPageView(this);

  void addToFavoriteTapped(Pokemon pokemon)  async {
    if (pokemon.isFavorite) {
      await _pokeman.removePokemonFromFavorite(pokemon);

    } else {
      _pokeman.addPokemonToFavorite(pokemon);
    }

    _pokeman.fetchFavoritePokes();
  }


}