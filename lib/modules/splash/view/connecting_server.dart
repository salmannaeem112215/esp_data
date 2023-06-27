import 'package:esp_remote/headers.dart';

class ServerConnecting extends StatelessWidget {
  const ServerConnecting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  color: ColorConfig.yellowDark,
                )),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Connecting With Server',
                textAlign: TextAlign.center,
                style: kTextLarge,
              ),
            ),
          ],
        ));
  }
}
