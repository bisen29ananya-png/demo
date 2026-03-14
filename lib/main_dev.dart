import 'package:demo/app_setup.dart';
import 'package:demo/core/env/app_env.dart';
import 'package:demo/core/env/app_flavor.dart';

Future<void> main() async {
  await appSetup(env: AppEnv.forFlavor(AppFlavor.dev));
}
