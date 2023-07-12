import 'package:esp_remote/headers.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final dc = Get.find<DataController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 3, bottom: 3),
                child: deviceStatus(dc),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, bottom: 3),
                child: temperatureStatus(dc),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 3, top: 3),
                child: pressureStatus(dc),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 3),
                child: humidityStatus(dc),
              ),
            ],
          ),
          const SizedBox(height: 16),
          graph(dc),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Obx graph(DataController dc) {
    return Obx(() {
      dc.datas.length;
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: DataGraph(
            dats: dc.datas,
          ),
        ),
      );
    });
  }

  Obx humidityStatus(DataController dc) {
    return Obx(() {
      dc.datas.length;
      return CardTile(
        icon: IconConfig.humidity,
        bgColor: ColorConfig.cardColorDark,
        isDark: true.obs,
        subText: 'Humidity %',
        textDark: dc.latestHumidity.toStringAsFixed(1),
        textLight: dc.avgHumidity.toStringAsFixed(1),
      );
    });
  }

  Obx pressureStatus(DataController dc) {
    return Obx(() {
      dc.datas.length;
      return CardTile(
        icon: IconConfig.pressure,
        bgColor: ColorConfig.cardColorDark,
        subText: 'Pressure Pa',
        isDark: true.obs,
        textDark: dc.latestPress.toStringAsFixed(1),
        textLight: dc.avgPress.toStringAsFixed(1),
      );
    });
  }

  Obx temperatureStatus(DataController dc) {
    return Obx(() {
      dc.datas.length;
      return CardTile(
        icon: IconConfig.temperature,
        bgColor: ColorConfig.cardColorDark,
        subText: "Temp C°",
        isDark: true.obs,
        textDark: dc.latestTemp.toStringAsFixed(1),
        textLight: dc.avgTemp.toStringAsFixed(1),
      );
    });
  }

  Obx deviceStatus(DataController dc) {
    return Obx(() {
      dc.datas.length;
      dc.deviceActive.value;
      return CardTile(
        key: UniqueKey(),
        icon: IconConfig.device,
        bgColor: ColorConfig.cardColorLight,
        isDark: dc.deviceActive,
        canTap: false,
        subText: 'Device',
        textDark: dc.deviceActive.value ? 'Active' : 'Offline',
        textLight: dc.deviceActive.value ? 'Active' : 'Offline',
      );
    });
  }
}
