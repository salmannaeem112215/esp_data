import 'package:esp_remote/api/api_response.dart';
import 'package:esp_remote/headers.dart';
import 'dart:io';

enum FetchingState { idol, loading, completed, error }

class DataController extends GetxController {
  late Socket socket;
  final state = FetchingState.idol.obs;
  final datas = <Data>[].obs;
  final deviceActive = false.obs;

  double get latestTemp {
    if (datas.isEmpty) {
      return 0;
    }
    return datas[0].temperature;
  }

  double get latestPress {
    if (datas.isEmpty) {
      return 0;
    }
    return datas[0].pressure;
  }

  double get latestHumidity {
    if (datas.isEmpty) {
      return 0;
    }
    return datas[0].humidity;
  }

  double get avgTemp {
    if (datas.isEmpty) {
      return 0;
    }
    double avg = 0;
    for (int i = 0; i < datas.length; i++) {
      avg += datas[i].temperature;
    }
    return avg / datas.length;
  }

  double get avgPress {
    if (datas.isEmpty) {
      return 0;
    }
    double avg = 0;
    for (int i = 0; i < datas.length; i++) {
      avg += datas[i].pressure;
    }
    return avg / datas.length;
  }

  double get avgHumidity {
    if (datas.isEmpty) {
      return 0;
    }
    double avg = 0;
    for (int i = 0; i < datas.length; i++) {
      avg += datas[i].humidity;
    }
    return avg / datas.length;
  }

  @override
  void onReady() {
    startStream();
    super.onReady();
  }

  Future<void> startStream() async {
    if (state.value == FetchingState.error ||
        state.value == FetchingState.idol) {
      try {
        final socket = await WebSocket.connect(ApiConfig.dataUrl);
        Get.find<SplashController>().netConnected.value = true;
        final stream = socket.asBroadcastStream();

        stream.listen(
          (message) {
            final apiJ = json.decode(message);
            final apiRes = ApiResponse.fromJson(apiJ);
            if (apiRes.success) {
              if (apiRes.payload.message == "LOAD" ||
                  apiRes.payload.message == "ALL") {
                final ds = apiRes.data as List;
                datas.assignAll(ds.map((e) => Data.fromJson(e)).toList());
              } else if (apiRes.payload.message == "ADD") {
                final ds = apiRes.data as Map<String, dynamic>;
                add(Data.fromJson(ds));
              } else if (apiRes.payload.message == "LATEST") {
                final ds = apiRes.data as List;
                datas.assignAll(ds.map((e) => Data.fromJson(e)).toList());
              }
            } else {
              Get.snackbar('Action Failed',
                  'Following Action Failed  ${apiRes.payload.message}');
            }
          },
          cancelOnError: true,
          onError: (error) {
            ToRoutes.toSplash();
            Get.snackbar('Server Error',
                'Please Make Sure Server is Running. Restart App');
            state.value = FetchingState.error;
          },
        );
        socket.add(json.encode({'action': 'LOAD'}));
        state.value = FetchingState.completed;
        ToRoutes.toHome();
      } catch (e) {
        state.value = FetchingState.error;
        ToRoutes.toSplash();

        Get.snackbar(
            'Server Error', 'Please Make Sure Server is Running. Restart App');
      }
    } else {}
  }

  Data add(Data d) {
    datas.insert(0, d);
    removeExpiredData();
    deviceActive.value = true;
    checkDeviceOffline();
    return d;
  }

  List<Data> getDuration(DateTime latest, DateTime oldest) {
    List<Data> result = [];
    for (int i = 0; i < datas.length; i++) {
      if (datas[i].dateTime.isAfter(oldest) &&
          datas[i].dateTime.isBefore(latest)) {
        result.add(datas[i]);
      } else {
        break;
      }
    }
    return result;
  }

  checkDeviceOffline() {
    Future.delayed(const Duration(seconds: 10)).then((value) {
      final status = datas[0].dateTime.isBefore(
            DateTime.now().subtract(
              const Duration(seconds: 20),
            ),
          );
      if (deviceActive.value != status) {
        deviceActive.value = false;
      }
    });
  }

  void removeExpiredData() {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Calculate the expiry time (1 day ago)
    DateTime expiryTime = currentTime.subtract(const Duration(days: 1));

    for (int i = datas.length - 1; i >= 0; i--) {
      if (datas[i].dateTime.isBefore(expiryTime)) {
        datas.removeAt(i);
      } else {
        break;
      }
    }
  }
}
