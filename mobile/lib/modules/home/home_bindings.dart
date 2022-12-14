import 'package:get/get.dart';
import 'package:mobile/modules/poll/create_poll/create_poll_controller.dart';
import 'package:mobile/modules/poll/my_pools/my_pools_controller.dart';
import 'package:mobile/repositories/auth_repository.dart';
import 'package:mobile/repositories/pool_repository.dart';
import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(PoolRepository());

    Get.put(CreatePollController());
    Get.put(MyPoolsController());
    Get.put(HomeController());
  }
}
