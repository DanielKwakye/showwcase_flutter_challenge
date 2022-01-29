import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showwcase_flutter_challenge/app/routing/auth_guard.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/injector.dart';
import 'package:showwcase_flutter_challenge/features/auth/presentation/manager/auth_user_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
    
class MyApp extends StatelessWidget {

  final _appRouter = AppRouter(authGuard: AuthGuard());
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getPokemonBloc),
        BlocProvider.value(value:  getAuthBloc)
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
    
  }
}