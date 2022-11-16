import 'package:get/get.dart';
import './details_controller.dart';

class DetailsBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(DetailsController());
    }
}