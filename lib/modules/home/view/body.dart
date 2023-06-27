import 'package:esp_remote/headers.dart';
import 'package:flutter/rendering.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final dc = Get.find<DataController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: CardTile(
                  icon: IconConfig.device,
                  bgColor: ColorConfig.cardColorLight,
                  isDark: true,
                  subText: 'Device',
                  text: 'Active',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CardTile(
                  icon: IconConfig.temperature,
                  bgColor: ColorConfig.cardColorDark,
                  subText: 'Temp- C',
                  text: '37.3',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: CardTile(
                  icon: IconConfig.pressure,
                  bgColor: ColorConfig.cardColorDark,
                  subText: 'Pressure- Pa',
                  text: '12131.23',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CardTile(
                  icon: IconConfig.humidity,
                  bgColor: ColorConfig.cardColorDark,
                  isDark: false,
                  subText: 'Humidity - %',
                  text: '123123',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(dc.datas[0].pressure.toString()),
        ],
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  const CardTile({
    super.key,
    required this.icon,
    this.bgColor = Colors.blueGrey,
    this.isDark = true,
    required this.text,
    required this.subText,
  });
  final String icon;
  final Color bgColor;
  final bool isDark;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor.withOpacity(isDark ? 1 : 0.7),
          elevation: isDark ? 10 : 0.1,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.asset(
                icon,
                height: 75,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
