import 'package:get/get.dart';
import 'package:mobile/models/pool_model.dart';
import 'package:mobile/repositories/pool_repository.dart';

class FindPollController extends GetxController {
  final _repo = Get.find<PoolRepository>();
  final pools = <PoolModel>[].obs;

  Future<void> findPools() async {
    final res = await _repo.findMyPools();
    pools.assignAll(res);
  }

  @override
  void onInit() {
    findPools();
    super.onInit();
  }
}
