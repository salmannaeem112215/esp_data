import 'package:esp_remote/headers.dart';

class AppPages {
  static const String home = '/home';
  static const String splash = '/splash';
  static const String initial = splash;

  static void initialBinding() {}

  static List<GetPage> routes() => [
        GetPage(
          name: home,
          page: () => const HomeScreen(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: splash,
          page: () => const SplashScreen(),
          binding: SplashBinding(),
        )
      ];
}
