import 'package:expensiv/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class Homeprovider extends ChangeNotifier {
   List<Map> category = [
    {'icon': Assets.icons.oquy, 'title': 'HOME'},
    {'icon': Assets.icons.vilka,'title': 'FOOD'},
    {'icon': Assets.icons.moshina, 'title': 'TRANSIT'},
    {'icon': Assets.icons.oqsumka,'title': 'SHOP'},
    {'icon': Assets.icons.oqchaqmo, 'title': 'BILLS'},
    {'icon': Assets.icons.uchnuq, 'title': 'MORE'},
  ];

  int coteindex = 0;
   void cotealmash(int index) {
    coteindex = index;
    notifyListeners();
  }
}