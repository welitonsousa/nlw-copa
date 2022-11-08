import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/widgets/app_button.dart';
import 'package:mobile/core/widgets/app_input.dart';
import './create_poll_controller.dart';

class CreatePollPage extends GetView<CreatePollController> {
  const CreatePollPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar novo bolão')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          SvgPicture.asset('assets/images/logo.svg'),
          const SizedBox(height: 30),
          Text(
            "Crie seu próprio bolão da copa\ne compartilhe entre amigos!",
            textAlign: TextAlign.center,
            style: context.textTheme.headline6,
          ),
          const SizedBox(height: 25),
          const AppInput(
            label: "Qual nome do seu bolão?",
          ),
          const SizedBox(height: 8),
          AppButton(
            title: "criar meu bolão",
            onTap: controller.createPoll,
          ),
          const SizedBox(height: 20),
          Text(
            "Após criar seu bolão, você receberá um\ncódigo único que poderá usar para convidar\noutras pessoas.",
            textAlign: TextAlign.center,
            style: context.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
