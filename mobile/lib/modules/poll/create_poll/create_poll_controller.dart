import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/widgets/app_banner.dart';
import 'package:mobile/modules/poll/my_pools/my_pools_controller.dart';
import 'package:mobile/repositories/pool_repository.dart';

class CreatePollController extends GetxController {
  final title = TextEditingController();

  final _repo = Get.find<PoolRepository>();
  final _loading = false.obs;

  bool get loading => _loading.value;

  Future<void> createPoll() async {
    final title = this.title.text.trim();
    if (title.isEmpty) {
      AppBanner.error(subtitle: 'Parece que o nome deste bolão é invalido');
    } else {
      try {
        _loading.value = true;
        final pool = await _repo.createPool(title);
        Get.find<MyPoolsController>().pools.add(pool);
        Get.focusScope?.unfocus();
        this.title.clear();
        AppBanner.success(subtitle: 'Bolão criado com sucesso');
      } catch (error) {
        AppBanner.error(subtitle: 'Não foi possível criar este bolão');
      } finally {
        _loading.value = false;
      }
    }
  }

  @override
  void dispose() {
    title.dispose();
    super.dispose();
  }
}
