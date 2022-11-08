import 'package:get/get.dart';
import 'package:mobile/modules/poll/create_poll/create_poll_controller.dart';
import 'package:mobile/modules/poll/find_poll/find_poll_controller.dart';
import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(CreatePollController());
    Get.put(FindPollController());
    Get.put(HomeController());
  }
}