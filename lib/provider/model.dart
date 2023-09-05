
import 'package:flutter/material.dart';



class Model with ChangeNotifier {


bool _puerto2 = false;

bool get puerto =>_puerto2;

on(){
_puerto2=!_puerto2;
print("estado puerto $_puerto2");
notifyListeners();
}







} 