import 'package:permission_handler/permission_handler.dart';

class Permissoniservice {

 static Future<void> requestAllPermissions() async {
    await camerapermisson();
    await gallerypermisson();
  }

  static Future<void> gallerypermisson() async {
    try {
      var status = await Permission.photos.status;
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.limited) {
        return;
      }

      if (status != PermissionStatus.permanentlyDenied) {
        status = await Permission.photos.request();
        if (status == PermissionStatus.granted ||
            status == PermissionStatus.limited) {
          return;
        }
      }
      return;
    } catch (e) {
      print('permissino xato $e');
    }
  }

  static Future<void> camerapermisson() async {
    try {
      var status = await Permission.camera.status;
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.limited) {
        return;
      }
      if (status != PermissionStatus.permanentlyDenied) {
        status = await Permission.camera.request();
        if (status == PermissionStatus.granted ||
            status == PermissionStatus.limited) {
          return;
        }
      }
      return;
    } catch (e) {
      print('permissino xato $e');
    }
  }
}
