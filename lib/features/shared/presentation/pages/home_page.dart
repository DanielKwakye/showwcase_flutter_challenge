import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:showwcase_flutter_challenge/core/mixin/form_mixin.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';
import 'package:showwcase_flutter_challenge/core/utils/enums.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/images.dart';
import 'package:showwcase_flutter_challenge/core/utils/injector.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';
import 'package:showwcase_flutter_challenge/features/auth/presentation/manager/auth_user_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/favorites_page.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/animated_column_widget.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/app_rounded_button.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/app_search_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/app_text_field.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/list_tile_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageController createState() => _HomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _HomePageView extends WidgetView<HomePage, _HomePageController> {
  const _HomePageView(_HomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  color: Colors.white, child: _addPokemonFormWidget(context));
            },
          );
        },
      ),
      body: BlocBuilder(
        bloc: context.read<PokemonBloc>(),
        builder: (ctx, bloc) {
          return Container(
            color: backgroundGray,
            child: SmartRefresher(
              controller: state._refreshController,
              onRefresh: state._onRefresh,
              enablePullDown: true,
              enablePullUp: true,
              onLoading: state._onLoading,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 180,
                    title: const Text("Pokemon"),
                    floating: true,
                    pinned: true,
                    actions: [
                      IconButton(
                          onPressed: () => state.logout(),
                          icon: const Icon(Icons.logout)),
                      IconButton(
                          onPressed: () =>
                              context.router.push(const FavoritesPageRoute()),
                          icon: const Icon(Icons.favorite))
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: kToolbarHeight),
                            child: AppSearchWidget(
                              onTextChanged: state.onSearchTextChanged,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (bloc is LoadingState)
                    const SliverToBoxAdapter(
                      child: AppListTileShimmer(),
                    ),
                  if (bloc is ErrorState<String>)
                    SliverToBoxAdapter(
                      child: ListTile(
                        leading: const Icon(Icons.error_outline),
                        title: Text(bloc.failure),
                      ),
                    ),

                  if (bloc is SuccessState<PokemonList> &&
                      bloc.data.results.isEmpty)
                    const SliverToBoxAdapter(
                        child: ListTile(
                      leading: Icon(Icons.error_outline),
                      title: Text("No pokes found"),
                    )),
                  if (bloc is SuccessState<PokemonList> &&
                      bloc.data.results.isNotEmpty)
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
                                  bloc.data.results[i].id), errorBuilder: (ctx, t, r) {
                                return Image.asset(appLogo);
                              },),
                            ),
                            title: Text(bloc.data.results[i].name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => context.router.push(
                                        PokemonDetailPageRoute(
                                            pokemon: bloc.data.results[i])),
                                    icon: const Icon(
                                        Icons.remove_red_eye_rounded)),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () => state.addToFavoriteTapped(
                                      bloc.data.results[i]),
                                  icon: bloc.data.results[i].isFavorite
                                      ? const Icon(Icons.favorite)
                                      : const Icon(Icons.favorite_outline),
                                ),
                              ],
                            ),
                            // onTap: () => context.router.push(PokemonDetailPageRoute(pokemon: bloc.data.results[i])),
                          ),
                        );
                      },
                      childCount: bloc.data.results.length,
                    )),
                  // const SliverToBoxAdapter(child: SizedBox(height: 100,),)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _addPokemonFormWidget(BuildContext context) => BlocBuilder(
      bloc: state._pokeBloc,
      builder: (ctx, bloc) {
        return Form(
            child: Container(
          padding: const EdgeInsets.all(20),
          child: AnimatedColumnWidget(
            children: <Widget>[
              const Text(
                'Add new Pokemon',
                style: TextStyle(fontSize: 22),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                'Enter pokemon id',
                keyboardType: TextInputType.number,
                onSave: (value) => state.id = value,
                validator: (value) => state.required(value),
              ),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                'Enter pokemon name',
                onSave: (value) => state.name = value,
                validator: (value) => state.required(value),
              ),
              const SizedBox(
                height: 20,
              ),
              // if(bloc is LoadingState)
              if (bloc is LoadingState)
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
              if (bloc is ErrorState)
                const Text('There is an existing pokemon with the given ID', style: TextStyle(color: Colors.red),),
              if (bloc is ErrorState)
                const SizedBox(
                  height: 10,
                ),
              if (bloc is! LoadingState)
                Builder(builder: (c) {
                  return AppRoundedButton(
                    text: 'Add',
                    onTap: () => state.onAddNewPokemonButtonTapped(c),
                  );
                }),
            ],
          ),
        ));
      });
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _HomePageController extends State<HomePage> with FormMixin {
  String? id, name;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _pokeBloc = getPokemonBloc;

  @override
  Widget build(BuildContext context) => _HomePageView(this);

  void onSearchTextChanged(text) {
    context.read<PokemonBloc>().searchPokemon(text);
  }

  @override
  void initState() {
    super.initState();
    onWidgetBindingComplete(
        onComplete: () =>
            context.read<PokemonBloc>().fetchPokes(limit: 100, offset: 0));
  }

  void addToFavoriteTapped(Pokemon pokemon) {
    if (pokemon.isFavorite) {
      context.read<PokemonBloc>().removePokemonFromFavorite(pokemon);
    } else {
      context.read<PokemonBloc>().addPokemonToFavorite(pokemon);
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    context.read<PokemonBloc>().fetchPokes(limit: 20, offset: 0);
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    _refreshController.loadComplete();
  }

  void onAddNewPokemonButtonTapped(BuildContext ctx) async {
    if (!validateAndSaveOnSubmit(ctx)) {
      return;
    }
    Form.of(ctx)?.save();

    final url = "$kBaseUrl/$id/";
    final pokemon = Pokemon(id: id!, name: name!, url: url);

    final either = await _pokeBloc.addNewPokemon(pokemon);
    if (either == null) return;
    if (either.isRight()) {
      showSnackBar(ctx, "Poke item added");
      context.read<PokemonBloc>().fetchPokes(limit: 100, offset: 0);
      Navigator.of(ctx).pop();
    }
  }

  void logout()  {

    showHandyConfirmDialog(context, content: "You will be logged out of this account", okTapped: () async {

      final either = await context.read<AuthUserBloc>().logoutUser();
      // successful logout
      if(either != null && either.isRight()){
        context.router.replace(const LoginPageRoute());
        return;
      }

      // this code would not get executed if user logout was unsuccessful
      showSnackBar(context, 'unable to user logged out');

    });

  }
}
