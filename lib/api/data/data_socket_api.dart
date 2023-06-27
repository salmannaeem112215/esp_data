import 'package:esp_remote/headers.dart';

class DataSocketApi {
  DataSocketApi()
      : _api = WebSocketChannel.connect(Uri.parse(ApiConfig.dataUrl));

  final WebSocketChannel _api;

  Stream<String> get stream => _api.stream.map((event) => event);

  ValueChanged<String> get send => _api.sink.add;
}
