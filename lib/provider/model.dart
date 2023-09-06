import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Model with ChangeNotifier {
  late IO.Socket socket;
  bool _puerto2 = false;
  bool _estdo_server=false;

  bool get puerto => _puerto2;
  bool get estado_server=>_estdo_server;

  on() {

    socket.emit("mensajex",{"nombre":"Led 2","estado":_puerto2});


    _puerto2 = !_puerto2;
    print("estado puerto $_puerto2");
    notifyListeners();
  }

    

  conectarSocket() {
   
    try {
      socket = IO.io(
          "http://localhost:3000",        
          //'http://192.168.0.12:3000',
          IO.OptionBuilder()
              .setTransports(['websocket']) // for Flutter or Dart VM
              //.setExtraHeaders({}) // optional
              .build());
      socket.onConnect((data){
      _estdo_server=true;

      notifyListeners();      
      print("conectado a server..");}
       
       );
    } catch (error) {
      print("no se puede conectar por $error");
      _estdo_server=false;

    }
    socket.onDisconnect((data) {
       _estdo_server=false;
        print("se apago el server");
      notifyListeners();
      
       });

      
  }

desconectar(){
  
  if(_estdo_server){
    print("desconectando..");
socket.disconnect();
  _estdo_server=false;

  }else{
    print("ya esta deconectado");
  }
  notifyListeners();
}
}
