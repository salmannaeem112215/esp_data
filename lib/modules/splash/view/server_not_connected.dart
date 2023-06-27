import 'package:esp_remote/headers.dart';

class ServerNotConnected extends StatelessWidget {
  const ServerNotConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Unable to connect with Server!',
                textAlign: TextAlign.center,
                style: kTextLarge,
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              onTap: () => Get.find<DataController>().startStream(),
              text: 'Try Again',
            ),
          ],
        ));
  }
}
