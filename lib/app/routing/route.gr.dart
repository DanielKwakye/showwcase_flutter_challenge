// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:showwcase_flutter_challenge/features/auth/presentation/pages/login_page.dart'
    as _i4;
import 'package:showwcase_flutter_challenge/features/shared/domain/entities/pokemon.dart'
    as _i7;
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/favorites_page.dart'
    as _i3;
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/home_page.dart'
    as _i1;
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/pokmon_detail_page.dart'
    as _i2;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomePageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    PokemonDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<PokemonDetailPageRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.PokemonDetailPage(pokemon: args.pokemon, key: args.key));
    },
    FavoritesPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.FavoritesPage());
    },
    LoginPageRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i4.LoginPage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomePageRoute.name, path: '/'),
        _i5.RouteConfig(PokemonDetailPageRoute.name,
            path: '/pokemon-detail-page'),
        _i5.RouteConfig(FavoritesPageRoute.name, path: '/favorites-page'),
        _i5.RouteConfig(LoginPageRoute.name, path: '/login-page')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomePageRoute extends _i5.PageRouteInfo<void> {
  const HomePageRoute() : super(HomePageRoute.name, path: '/');

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i2.PokemonDetailPage]
class PokemonDetailPageRoute
    extends _i5.PageRouteInfo<PokemonDetailPageRouteArgs> {
  PokemonDetailPageRoute({required _i7.Pokemon pokemon, _i6.Key? key})
      : super(PokemonDetailPageRoute.name,
            path: '/pokemon-detail-page',
            args: PokemonDetailPageRouteArgs(pokemon: pokemon, key: key));

  static const String name = 'PokemonDetailPageRoute';
}

class PokemonDetailPageRouteArgs {
  const PokemonDetailPageRouteArgs({required this.pokemon, this.key});

  final _i7.Pokemon pokemon;

  final _i6.Key? key;

  @override
  String toString() {
    return 'PokemonDetailPageRouteArgs{pokemon: $pokemon, key: $key}';
  }
}

/// generated route for
/// [_i3.FavoritesPage]
class FavoritesPageRoute extends _i5.PageRouteInfo<void> {
  const FavoritesPageRoute()
      : super(FavoritesPageRoute.name, path: '/favorites-page');

  static const String name = 'FavoritesPageRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginPageRoute extends _i5.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login-page');

  static const String name = 'LoginPageRoute';
}
