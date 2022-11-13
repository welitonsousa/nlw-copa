import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/widgets/app_banner.dart';
import 'package:mobile/modules/poll/my_pools/my_pools_controller.dart';
import 'package:mobile/repositories/pool_repository.dart';

class FindPoolController extends GetxController {
  final code = TextEditingController();
  final _repo = Get.find<PoolRepository>();
  final _loading = false.obs;

  bool get loading => _loading.value;

  Future<void> find() async {
    final code = this.code.text.trim();
    if (code.length == 6) {
      try {
        _loading.value = true;
        final pool = await _repo.join(code);
        Get.find<MyPoolsController>().pools.add(pool);
        Get.back();
        AppBanner.success(subtitle: 'você entrou no bolão');
      } on Map catch (error) {
        if (error['statusCode'] == 404) {
          AppBanner.error(subtitle: 'Bolão não encontrado');
        } else if (error['statusCode'] == 400) {
          AppBanner.error(subtitle: 'Você já esta participando deste bolão');
        }
      } finally {
        _loading.value = false;
      }
    } else {
      AppBanner.error(subtitle: 'Código invalido');
    }
  }

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }
}
