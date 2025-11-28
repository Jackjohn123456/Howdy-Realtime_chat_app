import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  final _secureStorage = FlutterSecureStorage();
  late IO.Socket _socket;
  IO.Socket get socket => _socket;

  SocketService._internal() {
    // initSocketService();
  }

  Future<void> initSocketService() async {
    debugPrint("Initializing Socket");
    final String token = await _secureStorage.read(key: "token") ?? "";
    _socket = IO.io(
        "http://10.0.2.2:6000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'Authorization':'Bearer $token'})
          .build()
    );
    _socket.onConnectError((data) {
      debugPrint("Connect Error: $data");
    });

    _socket.connect();

    _socket.onConnect((data) {
       debugPrint("socket id::::");
       debugPrint(_socket.id);
    },);

    _socket.onDisconnect((data) {
      debugPrint("socket Disconnected ");
    },);
  }
}