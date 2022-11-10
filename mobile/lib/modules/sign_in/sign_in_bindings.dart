import 'package:get/get.dart';
import 'package:mobile/repositories/auth_repository.dart';
import './sign_in_controller.dart';

class SignInBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthRepository());
    Get.put(SignInController(repository: Get.find()));
  }
}
