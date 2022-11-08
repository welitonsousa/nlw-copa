import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/core/widgets/app_button.dart';
import './sign_in_controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: context.widthTransformer(reducedBy: 40),
            ),
            const SizedBox(height: 30),
            AppButton(
              title: "Entrar com google",
              color: AppTheme.colors.white,
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  MdiIcons.google,
                  size: 20,
                  color: AppTheme.colors.white,
                ),
              ),
              backgroundColor: AppTheme.colors.red500,
              onTap: controller.signIn,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Center(
                child: Text(
                  "Não utilizamos nenhuma informação além\n do seu e-mail para criação de sua conta.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
