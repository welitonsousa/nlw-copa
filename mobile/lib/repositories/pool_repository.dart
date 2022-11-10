import 'package:get/get_connect.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile/models/pool_model.dart';

class PoolRepository {
  final _http = Get.find<GetHttpClient>();

  /// return the pool code
  Future<String> createPool(String title) async {
    final response = await _http.post('/pools', body: {"title": title});
    if (response.hasError) throw response.body;
    return response.body['code'];
  }

  /// return the list of pools of user sinned
  Future<List<PoolModel>> findMyPools() async {
    final response = await _http.get('/pools');
    if (response.hasError) throw response.body;
    return response.body['pools'].map<PoolModel>(PoolModel.fromMap).toList();
  }
}
