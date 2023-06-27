import 'package:esp_remote/headers.dart';

class NetNotConnected extends StatelessWidget {
  const NetNotConnected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: 50,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'This App use Internet. Please connect device with internet',
              textAlign: TextAlign.center,
              style: kTextLarge,
            ),
          ),
        ],
      ),
    );
  }
}
