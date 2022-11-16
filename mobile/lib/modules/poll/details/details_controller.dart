import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/widgets/app_banner.dart';
import 'package:mobile/models/guesses_model.dart';
import 'package:mobile/models/pool_model.dart';
import 'package:mobile/repositories/pool_repository.dart';

class DetailsController extends GetxController {
  final pool = Get.arguments as PoolModel;
  final games = <GameModel>[].obs;
  final loading = false.obs;
  final pageController = PageController();
  final pageIndex = 0.obs;
  final _repo = Get.find<PoolRepository>();

  void changePage(int index) => pageIndex.value = index;

  void tapToPage(int index) {
    pageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInCubic,
    );
  }

  Future<void> findGames() async {
    final res = await _repo.findGames(pool.code);
    games.assignAll(res);
  }

  Future<void> guessPoints({
    required int firstTeamPoints,
    required int secondTeamPoints,
    required String gameId,
  }) async {
    try {
      await _repo.guessesPoints(
        firstTeamPoints: firstTeamPoints,
        secondTeamPoints: secondTeamPoints,
        gameId: gameId,
        poolId: pool.id,
      );
      await findGames();
      AppBanner.success(subtitle: 'Seu palpite foi enviado');
    } catch (error) {
      AppBanner.success(subtitle: 'Não foi possível registar seu palpite');
    }
  }

  @override
  void onInit() {
    findGames();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
