import 'package:esp_remote/headers.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(NetworkController(), permanent: true);
    Get.put(SplashController(), permanent: true);
    Get.put(DataController(), permanent: true);
  }
}
