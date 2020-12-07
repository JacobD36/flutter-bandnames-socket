import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}
class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket _socket;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io('http://10.0.2.2:3000', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
      print('Conectado');
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
      print('Desconectado');
    });

    this._socket.on('nuevo-mensaje', (payload) {
      print('Nuevo-Mensaje');
      print('Nombres: ${payload['nombre']}');
      print('Apellidos: ${payload['apellidos']}');
      print('Mensaje: ${payload['mensaje']}');
      print(payload.containsKey('mensaje2') ? 'Mensaje2: ${payload['mensaje2']}' : 'Mensaje2: No existe');
    });
  }
}