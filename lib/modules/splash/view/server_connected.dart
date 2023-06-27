import 'package:esp_remote/headers.dart';

class ServerConnected extends StatelessWidget {
  const ServerConnected({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: CustomButton(
        onTap: () => ToRoutes.toHome(),
        text: 'View Data',
      ),
    );
  }
}
