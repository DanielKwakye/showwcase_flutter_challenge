import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';

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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text('Favorites'),
              ),
              //SliverList(delegate: delegate)
            ],
          ),
        );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _FavoritesPageController extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) => _FavoritesPageView(this);
}