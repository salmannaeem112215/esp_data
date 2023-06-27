import 'package:esp_remote/headers.dart';

class ToRoutes {
  static void toSplash() {
    Get.toNamed(AppPages.splash);
  }

  static void toHome() {
    Get.toNamed(AppPages.home);
  }
}
