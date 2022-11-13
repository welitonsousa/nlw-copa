import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_input.dart';
import './find_pool_controller.dart';

class FindPoolPage extends GetView<FindPoolController> {
  const FindPoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar por código')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 30),
          Text(
            "Encontre um bolão através de seu código único",
            style: context.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          AppInput(
            label: "Qual o código do bolão?",
            controller: controller.code,
            maxLength: 6,
          ),
          const SizedBox(height: 10),
          Obx(() => AppButton(
                title: "buscar bolão",
                loading: controller.loading,
                onTap: controller.find,
              ))
        ],
      ),
    );
  }
}
