import 'package:esp_remote/headers.dart';

class SplashController extends GetxController {
  final netConnected = false.obs;
  void goHome() async {
    await Future.delayed(const Duration(seconds: 1));
    final nc = Get.find<NetworkController>();
    final dc = Get.find<DataController>();

    while (true) {
      if (nc.connectionStatus > 1) {
        dc.startStream();
      } else {
        // net not connected;
        Get.snackbar('Network', 'Please Connect with Wifi or Hotspost');
      }
      Future.delayed(const Duration(seconds: 10));
    }

    // check data recived or not

    // go to Home
  }
}
