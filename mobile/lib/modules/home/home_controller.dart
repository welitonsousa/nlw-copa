import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/repositories/auth_repository.dart';

class HomeController extends GetxController {
  final pageController = PageController();
  final pageIndex = 0.obs;

  void changePage(int index) => pageIndex.value = index;

  void tapToPage(int index) {
    pageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInCubic,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    Get.find<AuthRepository>().setToken();
    super.onInit();
  }
}
