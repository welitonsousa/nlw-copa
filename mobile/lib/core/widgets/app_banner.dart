import 'package:get/get.dart';
import 'package:mobile/core/theme/app_theme.dart';

class AppBanner {
  AppBanner._();

  static void error({String? title, String? subtitle}) {
    Get.snackbar(
      title ?? 'Ops',
      subtitle ?? 'Algo deu errado',
      colorText: AppTheme.colors.white,
      backgroundColor: AppTheme.colors.red500,
    );
  }

  static void success({String? title, String? subtitle}) {
    Get.snackbar(
      title ?? 'Sucesso',
      subtitle ?? 'Operação concluída',
      colorText: AppTheme.colors.white,
      backgroundColor: AppTheme.colors.green500,
    );
  }
}
