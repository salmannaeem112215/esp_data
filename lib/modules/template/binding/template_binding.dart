import 'package:esp_remote/headers.dart';

import '../controller/template_controller.dart';

class TemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplateController>(
      () => TemplateController(),
    );
  }
}
