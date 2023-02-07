import 'package:flutter/material.dart';
import 'src/shared/injector/injector.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(
    const App(),
  );
}
