import 'package:esp_remote/headers.dart';

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
