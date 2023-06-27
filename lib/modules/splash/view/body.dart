import 'package:esp_remote/headers.dart';
import 'package:esp_remote/modules/splash/view/splash_lower.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            LogoIconConfig.logo,
            height: 150,
          ),
          const SizedBox(height: 12),
          const Text(
            'Esp Data Viewer',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const SplashLower(),
        ],
      ),
    );
  }
}
