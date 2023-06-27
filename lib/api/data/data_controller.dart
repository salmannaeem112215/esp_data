import 'package:esp_remote/api/api_response.dart';
import 'package:esp_remote/headers.dart';
import 'dart:io';

enum FetchingState { idol, loading, completed, error }

class DataController extends GetxController {
  late Socket socket;
  final _stream = StreamController<String>.broadcast();
  final state = FetchingState.idol.obs;
  final datas = <Data>[].obs;

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
            print('Error in stream: $error');
            state.value = FetchingState.error;
          },
        );
        socket.add(json.encode({'action': 'LOAD'}));
      } catch (e) {
        state.value = FetchingState.error;
        print('Error on Stream .. Stream Closed $e');
      }
    } else {}
  }

  Data add(Data d) {
    datas.insert(0, d);
    removeExpiredData();
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

  void removeExpiredData() {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Calculate the expiry time (1 day ago)
    DateTime expiryTime = currentTime.subtract(Duration(days: 1));

    for (int i = datas.length - 1; i >= 0; i--) {
      if (datas[i].dateTime.isBefore(expiryTime)) {
        datas.removeAt(i);
        print('Index Remoev');
      } else {
        break;
      }
    }
  }
}
