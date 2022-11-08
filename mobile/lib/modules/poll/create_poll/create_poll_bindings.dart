import 'package:get/get.dart';
import './create_poll_controller.dart';

class CreatePollBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(CreatePollController());
    }
}