import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expensiv/main.dart';
import 'package:expensiv/widget/internet.dart';
import 'package:flutter/cupertino.dart';

class Internetsarves {
  static bool isopen= false;

  static void lisenConnetion() {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status.contains(ConnectivityResult.none)) {
        WidgetsBinding.instance.addPostFrameCallback((v) {});
        NOinternet.conkorsat();
        isopen = true;
      } else if ((status.contains(ConnectivityResult.mobile) ||
              status.contains(ConnectivityResult.wifi) ||
              status.contains(ConnectivityResult.ethernet)) &&
          isopen == true) {
        WidgetsBinding.instance.addPostFrameCallback((v) {
          if (isopen) {
            Navigator.pop(navigatorkey.currentState!.context);
            isopen = false;
          }
        });
      }
    });
  }
}
