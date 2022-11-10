import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'package:mobile/modules/poll/create_poll/create_poll_page.dart';
import 'package:mobile/modules/poll/find_poll/find_poll_page.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => _NavigatorBar(
          index: controller.pageIndex.value,
          onTap: controller.tapToPage,
        ),
      ),
      body: PageView(
        onPageChanged: controller.changePage,
        controller: controller.pageController,
        children: const [
          CreatePollPage(),
          FindPollPage(),
        ],
      ),
    );
  }
}

class _NavigatorBar extends StatelessWidget {
  final Function(int) onTap;
  final int index;

  const _NavigatorBar({required this.onTap, required this.index});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.colors.gray800,
      selectedItemColor: AppTheme.colors.yellow500,
      currentIndex: index,
      onTap: onTap,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.plusCircleOutline),
          label: "Novo bolão",
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.soccer),
          label: "Meus bolões",
        ),
      ],
    );
  }
}
