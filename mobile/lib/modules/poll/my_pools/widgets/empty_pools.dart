import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/router/names.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/modules/home/home_controller.dart';

class EmptyPools extends StatelessWidget {
  const EmptyPools({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: context.textTheme.bodyText2
            ?.copyWith(color: AppTheme.colors.gray200),
        children: [
          const TextSpan(
              text:
                  "Você ainda não está participando de nenhum bolão, que tal "),
          TextSpan(
            text: "buscar um por código ",
            style: TextStyle(color: AppTheme.colors.yellow600),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(NamesRouters.FIND_POOL);
              },
          ),
          const TextSpan(text: "ou "),
          TextSpan(
            text: "criar um novo?",
            style: TextStyle(color: AppTheme.colors.yellow600),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.find<HomeController>().tapToPage(0);
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
