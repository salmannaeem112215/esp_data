import 'package:esp_remote/headers.dart';
import 'package:esp_remote/modules/home/view/data_graph.dart';

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
          SizedBox(
            height: 350,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 3, bottom: 3),
                  child: Obx(() {
                    dc.datas.length;
                    dc.deviceActive.value;
                    print('Device Active ${dc.deviceActive.value}');
                    print('CHanged');
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
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, bottom: 3),
                  child: Obx(() {
                    dc.datas.length;
                    return CardTile(
                      icon: IconConfig.temperature,
                      bgColor: ColorConfig.cardColorDark,
                      subText: "Temp C°",
                      isDark: true.obs,
                      textDark: dc.latestTemp.toStringAsFixed(1),
                      textLight: dc.avgTemp.toStringAsFixed(1),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 3, top: 3),
                  child: Obx(() {
                    dc.datas.length;
                    return CardTile(
                      icon: IconConfig.pressure,
                      bgColor: ColorConfig.cardColorDark,
                      subText: 'Pressure Pa',
                      isDark: true.obs,
                      textDark: dc.latestPress.toStringAsFixed(1),
                      textLight: dc.avgPress.toStringAsFixed(1),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3, top: 3),
                  child: Obx(() {
                    dc.datas.length;
                    return CardTile(
                      icon: IconConfig.humidity,
                      bgColor: ColorConfig.cardColorDark,
                      isDark: true.obs,
                      subText: 'Humidity %',
                      textDark: dc.latestHumidity.toStringAsFixed(1),
                      textLight: dc.avgHumidity.toStringAsFixed(1),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            dc.datas.length;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DataGraph(
                  dats: dc.datas,
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
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
    required this.textDark,
    required this.textLight,
    required this.subText,
    this.canTap = true,
    required this.isDark,
  });
  final String icon;
  final Color bgColor;
  final String textDark;
  final String textLight;
  final String subText;
  final bool canTap;
  final RxBool isDark;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Obx(
        () => ElevatedButton(
          onPressed: () => canTap ? isDark.value = !isDark.value : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor.withOpacity(isDark.value ? 1 : 0.7),
            elevation: isDark.value ? 10 : 0.1,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                icon,
                height: 50,
              ),
              const SizedBox(width: 2),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    canTap
                        ? Obx(
                            () => Text(
                              isDark.value ? 'Latest' : 'Avg',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white70,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    Obx(
                      () => Text(
                        isDark.value ? textDark : textLight,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subText,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
