import 'package:esp_remote/headers.dart';

class DataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataController>(
      () => DataController(),
    );
  }
}
