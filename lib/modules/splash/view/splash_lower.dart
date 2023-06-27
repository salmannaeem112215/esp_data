import 'package:esp_remote/headers.dart';

class SplashLower extends StatelessWidget {
  const SplashLower({super.key});

  @override
  Widget build(BuildContext context) {
    final sc = Get.find<SplashController>();
    return Obx(
      () => !sc.netConnected.value
          ? const Text('Please Connect Net')
          : Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ElevatedButton(
                onPressed: () {
                  DataSocketApi().stream;
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    backgroundColor: const Color.fromARGB(255, 58, 58, 58),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: const Text(
                  'View Data',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
    );
  }
}
