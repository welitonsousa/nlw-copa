import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/widgets/app_button.dart';
import './find_poll_controller.dart';

class FindPollPage extends GetView<FindPollController> {
  const FindPollPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus bolões')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const AppButton(
            title: "buscar bolão por código",
            icon: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.search),
            ),
          ),
          const Divider(),
          Text.rich(
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
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
                const TextSpan(text: "ou "),
                TextSpan(
                  text: "criar um novo?",
                  style: TextStyle(color: AppTheme.colors.yellow600),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
