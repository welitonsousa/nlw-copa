import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/widgets/pool_item.dart';
import 'package:mobile/modules/poll/details/widgets/detail_option.dart';
import 'package:mobile/modules/poll/details/widgets/game_item.dart';
import 'package:share_plus/share_plus.dart';
import './details_controller.dart';

class DetailsPage extends GetView<DetailsController> {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.pool.title),
        actions: [
          IconButton(
            onPressed: () {
              Share.share(controller.pool.code);
            },
            icon: const Icon(Icons.ios_share),
          ),
        ],
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.pool.title,
                            maxLines: 1,
                            style: context.textTheme.headline6,
                          ),
                          Text("Código: ${controller.pool.code}", maxLines: 1),
                        ],
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 50,
                        width: context.width / 2,
                        child: AvataresItem(
                          participants: controller.pool.participants,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.colors.gray800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DetailOption(
                        title: "Seus palpites",
                        selected: controller.pageIndex.value == 0,
                        onTap: () => controller.tapToPage(0),
                      ),
                      DetailOption(
                        title: "Tanking do grupo",
                        selected: controller.pageIndex.value == 1,
                        onTap: () => controller.tapToPage(1),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: controller.changePage,
                    controller: controller.pageController,
                    children: [
                      ListView.builder(
                        itemCount: controller.games.length,
                        itemBuilder: (context, index) {
                          final game = controller.games[index];
                          return GameItem(
                            game: game,
                            confirm: (a, b) async {
                              await controller.guessPoints(
                                firstTeamPoints: a,
                                secondTeamPoints: b,
                                gameId: game.id,
                              );
                            },
                          );
                        },
                      ),
                      Container(color: Colors.red),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
