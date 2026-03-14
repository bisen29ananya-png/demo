import 'package:flutter_test/flutter_test.dart';

import 'package:demo/app.dart';
import 'package:demo/core/injection/service_locator.dart';
import 'package:demo/core/env/app_env.dart';
import 'package:demo/core/env/app_flavor.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    await configureDependencies(AppEnv.forFlavor(AppFlavor.dev));
  });

  testWidgets('App builds and shows tabs', (WidgetTester tester) async {
    await tester.pumpWidget(App(env: AppEnv.forFlavor(AppFlavor.dev)));
    await tester.pumpAndSettle();

    // Default initial tab is Movies.
    expect(find.text('Movies'), findsWidgets);
  });
}
