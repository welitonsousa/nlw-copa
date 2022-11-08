import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile/modules/poll/create_poll/create_poll_page.dart';
import 'package:mobile/modules/poll/find_poll/find_poll_page.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          CreatePollPage(),
          FindPollPage(),
        ],
      ),
    );
  }
}
