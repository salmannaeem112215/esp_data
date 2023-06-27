import 'package:esp_remote/headers.dart';

class SplashController extends GetxController {
  final nc = Get.find<NetworkController>();
  final netConnected = false.obs;
  void goHome() async {
    await Future.delayed(const Duration(seconds: 1));
    // check Internet Avalidity
    print('Connection Status netConnected ${netConnected.value}');

    // check data recived or not

    // go to Home
  }
}
