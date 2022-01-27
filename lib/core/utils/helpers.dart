import 'dart:async';

import 'package:flutter/material.dart';

onWidgetBindingComplete({required Function() onComplete}) {
  WidgetsBinding.instance
      ?.addPostFrameCallback((_) => Timer(const Duration(seconds: 1), onComplete));
}