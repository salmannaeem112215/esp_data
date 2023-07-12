import 'package:esp_remote/headers.dart';
import 'package:intl/intl.dart';

class DataGraph extends StatelessWidget {
  final List<Data> dats;

  const DataGraph({required this.dats, super.key});

  @override
  Widget build(BuildContext context) {
    // Add null values for missing intervals
    final gm = adjustDataWithNulls(dats);
    final adjustedDats = gm.data.reversed.toList();

    return SafeArea(
      child: LineChart(
        LineChartData(
          minY: gm.min - 5,
          maxY: gm.max + 5,
          lineTouchData: lineTouchData(),
          lineBarsData: [temperatureLineBar(adjustedDats)],
          titlesData: sideTilesData(),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }

  FlTitlesData sideTilesData() {
    return FlTitlesData(
        topTitles: const AxisTitles(
          drawBelowEverything: true,
        ),
        rightTitles: const AxisTitles(
          drawBelowEverything: true,
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, d) => const SizedBox(),
          ),
        ),
        leftTitles: AxisTitles(
          axisNameWidget: const Text(
            'Temperature (C°)',
          ),
          axisNameSize: 30,
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, d) => Text(
              value.toStringAsFixed(0),
              maxLines: 1,
            ),
          ),
        ));
  }

  LineChartBarData temperatureLineBar(List<Data?> adjustedDats) {
    return LineChartBarData(
      spots: adjustedDats
          .asMap()
          .map((index, data) => MapEntry(
                index,
                FlSpot(index.toDouble(), data?.temperature ?? 0),
              ))
          .values
          .toList(),
      preventCurveOverShooting: true,
      isCurved: true,
      color: ColorConfig.cardColorDark,
      dotData: const FlDotData(show: false),
      curveSmoothness: 0.5,
      belowBarData: BarAreaData(show: true),
    );
  }

  LineTouchData lineTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: ColorConfig.cardColorDark.withOpacity(0.9),
        getTooltipItems: (List<LineBarSpot> touchedSpots) {
          return touchedSpots.map((LineBarSpot touchedSpot) {
            final spotData = touchedSpot;
            final dateTime =
                dats[dats.length - 1 - spotData.x.toInt()].dateTime;
            String formattedTime = DateFormat('hh:mm a').format(dateTime);
            return LineTooltipItem(
              '${spotData.y.toStringAsFixed(1)} C°\n$formattedTime',
              const TextStyle(color: Colors.white),
            );
          }).toList();
        },
      ),
    );
  }

  GraphModel adjustDataWithNulls(List<Data> dats) {
    final adjustedDats = <Data?>[];
    double min = 0;
    double max = 0;
    double avg = 0;
    double total = 0;
    if (dats.isEmpty) {
      return GraphModel(data: adjustedDats, avg: avg, min: min, max: max);
    }

    adjustedDats.add(dats.first);
    min = dats[0].temperature;
    max = dats[0].temperature;
    total = dats[0].temperature;

    for (int i = 1; i < dats.length; i++) {
      final previousData = dats[i - 1];
      final currentData = dats[i];
      final timeDifference =
          currentData.dateTime.difference(previousData.dateTime);

      // Add null values for missing intervals
      if (timeDifference.inSeconds > 5) {
        final numMissingPoints = (timeDifference.inSeconds ~/ 5) - 1;
        for (int j = 0; j < numMissingPoints; j++) {
          adjustedDats.add(null);
        }
      }

      adjustedDats.add(currentData);
      if (min > dats[i].temperature) {
        min = dats[i].temperature;
      }
      if (max < dats[i].temperature) {
        max = dats[i].temperature;
      }
      total += dats[i].temperature;
    }
    final gm = GraphModel(
        data: adjustedDats, avg: total / dats.length, min: min, max: max);
    return gm;
  }

  double getMinTemperature(List<Data?> dats) {
    return dats.fold(double.infinity, (min, data) {
      if (data?.temperature != null && data!.temperature < min) {
        return data.temperature;
      }
      return min;
    });
  }

  double getMaxTemperature(List<Data?> dats) {
    return dats.fold(double.negativeInfinity, (max, data) {
      if (data?.temperature != null && data!.temperature > max) {
        return data.temperature;
      }
      return max;
    });
  }
}

class GraphModel {
  List<Data?> data;
  double avg;
  double min;
  double max;

  GraphModel(
      {required this.data,
      required this.avg,
      required this.min,
      required this.max});
}
