import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';

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
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(

                  ),
                ),
              )
            ],
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
}