import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Model with ChangeNotifier {
  late IO.Socket socket;
  bool _puerto2 = false;

  bool get puerto => _puerto2;

  on() {
    _puerto2 = !_puerto2;
    print("estado puerto $_puerto2");
    notifyListeners();
  }

  conectarSocket() {
    try {
      socket = IO.io(
          'http://192.168.0.12:3000',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              //.setExtraHeaders({}) // optional
              .build());
      socket.onConnect((data) => print("conectado a server.."));
    } catch (error) {
      print("no se puede conectar por $error");
    }
  }
}
