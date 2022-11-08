import 'package:get/get.dart';
import './find_poll_controller.dart';

class FindPollBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(FindPollController());
    }
}