// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart'
    as _i5;
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/home_page.dart'
    as _i1;
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/pokmon_detail_page.dart'
    as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    PokemonDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<PokemonDetailPageRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.PokemonDetailPage(pokemon: args.pokemon, key: args.key));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(HomePageRoute.name, path: '/'),
        _i3.RouteConfig(PokemonDetailPageRoute.name,
            path: '/pokemon-detail-page')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i3.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.PokemonDetailPage]
class PokemonDetailPageRoute
    extends _i3.PageRouteInfo<PokemonDetailPageRouteArgs> {
  PokemonDetailPageRoute({required _i5.Pokemon pokemon, _i4.Key? key})
      : super(PokemonDetailPageRoute.name,
            path: '/pokemon-detail-page',
            args: PokemonDetailPageRouteArgs(pokemon: pokemon, key: key));

  static const String name = 'PokemonDetailPageRoute';
}

class PokemonDetailPageRouteArgs {
  const PokemonDetailPageRouteArgs({required this.pokemon, this.key});

  final _i5.Pokemon pokemon;

  final _i4.Key? key;

  @override
  String toString() {
    return 'PokemonDetailPageRouteArgs{pokemon: $pokemon, key: $key}';
  }
}
