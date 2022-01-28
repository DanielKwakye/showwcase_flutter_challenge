import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon_list.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/app_search_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: state.addNewPokemonTapped,),
          body: BlocBuilder(
            bloc: context.read<PokemonBloc>(),
            builder: (ctx, bloc) => Container(
              color: backgroundGray,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 180,
                    title: const Text("Berries"),
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SafeArea(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: kToolbarHeight),
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
                  if(bloc is ErrorState<String>)
                    SliverToBoxAdapter(
                      child: ListTile(
                        leading: const Icon(Icons.error_outline),
                        title: Text(bloc.failure),
                      ),
                    ),

                  if (bloc is SuccessState<PokemonList> && bloc.data.results.isEmpty)
                    const SliverToBoxAdapter(
                        child: ListTile(
                          leading: Icon(Icons.error_outline),
                          title: Text("No pokes found"),
                        )),
                  if (bloc is SuccessState<PokemonList> && bloc.data.results.isNotEmpty)
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (ctx, i) => Container(
                                margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color:  Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(child: Image.network(generatePokemonImageUrl(bloc.data.results[i].id)),),
                                  title: Text(bloc.data.results[i].name),
                                ),
                              ),
                          childCount: bloc.data.results.length,
                    ))

                ],
              ),
            ),
          ),
        );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _HomePageController extends State<HomePage> {

  @override
  Widget build(BuildContext context) => _HomePageView(this);

  void onSearchTextChanged(text) {
    debugPrint(text);
  }

  @override
  void initState() {
    super.initState();
    onWidgetBindingComplete(onComplete: () => context.read<PokemonBloc>().fetchPokes(limit: 20, offset: 0));
  }


  void addNewPokemonTapped() {
  }
}