import 'package:get/get_connect.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetHttpClient(
      baseUrl: 'http://192.168.64.1:3333',
      allowAutoSignedCert: true,
    )..errorSafety = false);
  }
}
