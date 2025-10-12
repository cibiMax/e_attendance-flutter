import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  Future<PermissionStatus> checkStatus(Permission permission) async {
    return await permission.status;
  }

  Future<PermissionStatus> requestStatus(Permission permission) async {
    var res = await permission.request();

    return res;
  }

  Future<void> openSettingsDialog() async {
    await openAppSettings();
  }
}
