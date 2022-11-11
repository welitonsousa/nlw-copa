import 'package:get/get.dart';
import 'my_pools_controller.dart';

class FindPollBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(MyPoolsController());
  }
}
