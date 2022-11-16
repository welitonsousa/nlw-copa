import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile/models/guesses_model.dart';
import 'package:mobile/models/pool_model.dart';

class PoolRepository {
  final _http = Get.find<GetHttpClient>();

  /// return the pool code
  Future<PoolModel> createPool(String title) async {
    final response = await _http.post('/pools-signed', body: {"title": title});
    if (response.hasError) throw response.body;
    return PoolModel.fromMap(response.body['pool']);
  }

  /// return the list of pools of user sinned
  Future<List<PoolModel>> findMyPools() async {
    final response = await _http.get('/pools');
    if (response.hasError) throw response.body;
    return response.body['pools'].map<PoolModel>(PoolModel.fromMap).toList();
  }

  /// join in the pool with code
  Future<PoolModel> join(String code) async {
    final response = await _http.get('/pools/$code/join');
    if (response.hasError) throw response.body;
    return PoolModel.fromMap(response.body['pool']);
  }

  // return all games with guesses of user
  Future<Iterable<GameModel>> findGames(String code) async {
    final res = await _http.get('/pools/$code/games');
    if (res.hasError) throw res.body;
    return res.body['games'].map<GameModel>(GameModel.fromMap);
  }

  Future<void> guessesPoints({
    required int firstTeamPoints,
    required int secondTeamPoints,
    required String poolId,
    required String gameId,
  }) async {
    final res = await _http.post('/pools/$poolId/games/$gameId/guesses',
        body: json.encode({
          "firstTeamPoints": (firstTeamPoints),
          "secondTeamPoints": (secondTeamPoints)
        }));
    if (res.hasError) throw res.body;
  }
}
