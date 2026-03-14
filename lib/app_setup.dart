import 'package:flutter/widgets.dart';

import 'package:demo/app.dart';
import 'package:demo/core/injection/service_locator.dart';
import 'package:demo/core/env/app_env.dart';

Future<void> appSetup({required AppEnv env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(env);

  runApp(App(env: env));
}
