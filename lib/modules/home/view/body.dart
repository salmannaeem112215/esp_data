import 'package:esp_remote/headers.dart';

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
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Obx(() {
                  dc.datas.length;
                  return CardTile(
                    icon: IconConfig.device,
                    bgColor: ColorConfig.cardColorLight,
                    isDark: dc.deviceActive.value ? true : false,
                    subText: 'Device',
                    text: dc.deviceActive.value ? 'Active' : 'Offline',
                  );
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() {
                  dc.datas.length;
                  return CardTile(
                    icon: IconConfig.temperature,
                    bgColor: ColorConfig.cardColorDark,
                    subText: 'Temp- C',
                    text: dc.latestTemp,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Obx(() {
                  dc.datas.length;
                  return CardTile(
                    icon: IconConfig.pressure,
                    bgColor: ColorConfig.cardColorDark,
                    subText: 'Pressure- Pa',
                    text: dc.latestPress,
                  );
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Obx(() {
                  dc.datas.length;
                  return CardTile(
                    icon: IconConfig.humidity,
                    bgColor: ColorConfig.cardColorDark,
                    isDark: true,
                    subText: 'Humidity - %',
                    text: dc.latestHumidity,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
