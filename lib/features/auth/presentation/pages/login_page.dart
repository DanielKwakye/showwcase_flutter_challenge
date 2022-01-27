import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageController createState() => _LoginPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _LoginPageView extends WidgetView<LoginPage, _LoginPageController> {

  const _LoginPageView(_LoginPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(color: backgroundGray,),
        );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _LoginPageController extends State<LoginPage> {
  @override
  Widget build(BuildContext context) => _LoginPageView(this);
}