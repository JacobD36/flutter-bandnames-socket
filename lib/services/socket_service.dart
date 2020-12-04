import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    IO.Socket socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    /*IO.Socket socket = IO.io('http://192.168.1.17:3000', 
      IO.OptionBuilder()
        .setTransports(['websocket']) // for Flutter or Dart VM
        .enableAutoConnect()  // disable auto-connection
        .build()
    );*/

    socket.onConnect((_) {
     print('connect');
    });

    socket.onDisconnect((_) => print('disconnect'));
  }
}