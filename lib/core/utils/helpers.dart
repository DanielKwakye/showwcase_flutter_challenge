import 'dart:async';

import 'package:flutter/material.dart';

onWidgetBindingComplete({required Function() onComplete}) {
  WidgetsBinding.instance
      ?.addPostFrameCallback((_) => Timer(const Duration(seconds: 1), onComplete));
}

String generatePokemonImageUrl(String id) => 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';