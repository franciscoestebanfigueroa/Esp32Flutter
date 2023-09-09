import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Model with ChangeNotifier {
  late IO.Socket socket;
  bool _puerto2 = false;
  bool _estdo_server = false;

  bool get puerto => _puerto2;
  bool get estado_server => _estdo_server;
  String _uri = 'https://server-ia2.onrender.com';

  Model() {
    try {
      socket = IO.io(
          //"http://localhost:3000",
          //'http://192.168.0.12:3000',
          _uri,
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              //.setExtraHeaders({}) // optional
              .enableAutoConnect()
              .build());

      socket.close();
      print("creando instancia de socket io");
    } catch (e) {
      print(e);
    }
  }
  on() {
    socket
        .emit("mensajex", {"nombre": "Led 2", "estado": "_puerto2.toString()"});

    _puerto2 = !_puerto2;
    print("estado puerto $_puerto2");
    notifyListeners();
  }

  conectarSocket() {
    socket.connect();
    _estdo_server = true;

    socket.onConnect((data) {
      print("conectado a server.. $data");

      socket.on("mensajex", (data) {
        print("escucho cambios");
        print(data);
        print(data["nombre"]);
        print(data["estado"]);
        if (data["estado"].toString() == "true") {
          print("llego true");
          _puerto2 = true;
          notifyListeners();
        } else {
          _puerto2 = false;
          notifyListeners();
        }
      });
    });

    socket.onDisconnect((data) {
      _estdo_server = false;
      print("se apago el server");
      notifyListeners();
    });
  }

  desconectar() {
    if (_estdo_server) {
      print("desconectando..");
      socket.disconnect();
      _estdo_server = false;
    } else {
      print("ya esta deconectado");
    }
    notifyListeners();
  }
}
