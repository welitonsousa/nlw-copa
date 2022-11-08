import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/widgets/app_banner.dart';

class CreatePollController extends GetxController {
  final pollName = TextEditingController();

  Future<void> createPoll() async {
    if (pollName.text.trim().isEmpty) {
      AppBanner.error(subtitle: 'Parece que o nome deste bolão é invalido.');
    } else {}
  }

  @override
  void dispose() {
    pollName.dispose();
    super.dispose();
  }
}
