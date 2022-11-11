import 'package:get/get.dart';
import './find_pool_controller.dart';

class FindPoolBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(FindPoolController());
    }
}