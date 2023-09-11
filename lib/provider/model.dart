import 'dart:convert';

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
    socket = IO.io(
        //"http://localhost:3000",
        //'http://192.168.0.12:443',
         _uri,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            // .setExtraHeaders({"data": "xxx"}) // optional
            //.enableAutoConnect()
            .build());
    print("creando instancia de socket io ");
    socket.close();
  }
  on() {
    _puerto2 = !_puerto2;
    print("estado puerto $_puerto2");
    notifyListeners();
    socket
        .emit("mensajex", {"nombre": "puerto2", "estado": _puerto2.toString()});
  }

  conectarSocket() {
    socket.connect();

    socket.onConnect((data) {
      _estdo_server = true;
      notifyListeners();

      socket.on("mensajex", (data) {
        print("evaluando data ${data}");
        try {
          String nombre = data['nombre'];
          dynamic estado = data['estado'];
          print('Nombre: $nombre');
          print('Estado: $estado');
        } catch (e) {
          print('Error al decodificar JSON: $e');
        }

        if (data['estado'] == "false") {
          _puerto2 = false;
          notifyListeners();
        } else {
          _puerto2 = true;
          notifyListeners();
        }
      });
      print("por finnnnn");
    });
    socket.onConnectError((e) => print("conectado a server..$e "));

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
