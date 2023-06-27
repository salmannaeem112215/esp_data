import 'dart:io';

import 'package:esp_remote/headers.dart';

class NetworkController extends GetxController {
  final connectionStatus = 0.obs;
  final ips = '0.0.0.0'.obs;
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  final Connectivity connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((event) {
      _updateConnectionStatus(event);
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return _updateConnectionStatus(result);
  }

  Future updateIps() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.address.isNotEmpty) {
          ips.value = addr.address;
        }
      }
    }
  }

  _updateConnectionStatus(ConnectivityResult? result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        Get.find<SplashController>().netConnected.value = true;
        updateIps();
        break;
      case ConnectivityResult.mobile:
        Get.find<SplashController>().netConnected.value = true;
        connectionStatus.value = 2;
        updateIps();
        break;
      case ConnectivityResult.none:
        Get.find<SplashController>().netConnected.value = false;
        connectionStatus.value = 0;
        break;
      default:
        Get.find<SplashController>().netConnected.value = false;
        Get.snackbar("Network Error", "Failed to Get Network");
        break;
    }
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
    super.onClose();
  }
}
