import 'package:get/get.dart';
import 'package:mobile/core/router/names.dart';
import 'package:mobile/repositories/auth_repository.dart';

class SignInController extends GetxController {
  SignInController({required AuthRepository repository})
      : _repository = repository;

  final AuthRepository _repository;

  Future<void> signIn() async {
    final token = await _repository.signIn();
    if (token != null) Get.offAndToNamed(NamesRouters.HOME);
  }
}
