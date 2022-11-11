import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/router/names.dart';
import 'package:mobile/core/router/pages.dart';
import 'package:mobile/core/theme/app_theme.dart';
import 'core/bindings/app_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([Firebase.initializeApp(), GetStorage.init()]);
  final token = GetStorage().read('token');
  runApp(MyApp(logged: token != null));
}

class MyApp extends StatelessWidget {
  final bool logged;
  const MyApp({Key? key, required this.logged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme().dark,
      initialRoute: logged ? NamesRouters.HOME : NamesRouters.SIGN_IN,
      getPages: Pages().list,
      enableLog: false,
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
