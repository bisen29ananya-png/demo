import 'app_flavor.dart';

class AppEnv {
  const AppEnv({
    required this.flavor,
    required this.appName,
    required this.baseUrl,
    required this.enableNetworkLogs,
  });

  final AppFlavor flavor;
  final String appName;
  final String baseUrl;
  final bool enableNetworkLogs;

  factory AppEnv.forFlavor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return const AppEnv(
          flavor: AppFlavor.dev,
          appName: 'Movies Demo (DEV)',
          baseUrl: 'https://api.tvmaze.com',
          enableNetworkLogs: true,
        );
      case AppFlavor.uat:
        return const AppEnv(
          flavor: AppFlavor.uat,
          appName: 'Movies Demo (UAT)',
          baseUrl: 'https://api.tvmaze.com',
          enableNetworkLogs: true,
        );
      case AppFlavor.prod:
        return const AppEnv(
          flavor: AppFlavor.prod,
          appName: 'Movies Demo',
          baseUrl: 'https://api.tvmaze.com',
          enableNetworkLogs: false,
        );
    }
  }
}
