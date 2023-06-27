import 'package:esp_remote/headers.dart';
import 'package:esp_remote/modules/splash/view/connecting_server.dart';
import 'package:esp_remote/modules/splash/view/net_not_connected.dart';
import 'package:esp_remote/modules/splash/view/server_connected.dart';
import 'package:esp_remote/modules/splash/view/server_not_connected.dart';

class SplashLower extends StatelessWidget {
  const SplashLower({super.key});

  @override
  Widget build(BuildContext context) {
    final sc = Get.find<SplashController>();
    final dc = Get.find<DataController>();
    return Obx(
      () => !sc.netConnected.value
          ? const NetNotConnected()
          : dc.state.value == FetchingState.completed
              ? const ServerConnected()
              : dc.state.value == FetchingState.error
                  ? const ServerNotConnected()
                  : const ServerConnecting(),
    );
  }
}
