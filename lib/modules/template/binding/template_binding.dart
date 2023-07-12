import 'package:esp_remote/headers.dart';

class TemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplateController>(
      () => TemplateController(),
    );
  }
}
