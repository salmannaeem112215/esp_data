import 'package:esp_remote/headers.dart';
import './view/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.height < 450 && size.width > 300) {
      return getResponsiveBody(450, size.width);
    } else if (size.height > 450 && size.width < 300) {
      return getResponsiveBody(size.height, 300);
    } else if (size.height < 450 && size.width < 300) {
      return getResponsiveBody(450, 300);
    } else {
      return const CustomScaffold(
        body: Body(),
      );
    }
  }

  CustomScaffold getResponsiveBody(double height, double width) {
    return CustomScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: height,
              width: width,
              child: const Body(),
            ),
          ),
        ),
      ),
    );
  }
}
