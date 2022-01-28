import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/home_page.dart';
import 'package:auto_route/annotations.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/pages/pokmon_detail_page.dart';

/// flutter packages pub run build_runner build --delete-conflicting-outputs
/// flutter packages pub run build_runner watch --delete-conflicting-outputs
///
/// This auto router automatically generates routes for every Page added
@AdaptiveAutoRouter(
    routes: <AutoRoute>[
      AutoRoute(page: HomePage, initial: true),
      AutoRoute(page: PokemonDetailPage),
    ]
)

class $AppRouter {}