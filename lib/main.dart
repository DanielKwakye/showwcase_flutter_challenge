import 'package:flutter/material.dart';
import 'app/app.dart';
import 'core/utils/injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}


