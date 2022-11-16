import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/router/names.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/pool_item.dart';
import 'package:mobile/modules/poll/my_pools/widgets/empty_pools.dart';
import 'my_pools_controller.dart';

class MyPoolsPage extends GetView<MyPoolsController> {
  const MyPoolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus bolões')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            AppButton(
              title: "buscar bolão por código",
              onTap: () {
                Get.toNamed(NamesRouters.FIND_POOL);
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.search),
              ),
            ),
            const Divider(),
            Obx(_content),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    if (controller.pools.isEmpty) return const EmptyPools();
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.pools.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: PoolItem(pool: controller.pools[index]),
            onTap: () => Get.toNamed(
              NamesRouters.POOL_DETAILS,
              arguments: controller.pools[index],
            ),
          );
        },
      ),
    );
  }
}
