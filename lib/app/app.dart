import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showwcase_flutter_challenge/core/utils/injector.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
    
class MyApp extends StatelessWidget {

  final _appRouter = AppRouter();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: PokemonBloc(
          getPokemonListUseCase: sl(),
          addNewPokemonUseCase: sl(),
          addPokemonToFavoriteUseCase: sl(),
          searchPokemonListUseCase: sl())),
      ],
      child: Builder(builder: (ctx) {
          return MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        }),
    );
    
  }
}