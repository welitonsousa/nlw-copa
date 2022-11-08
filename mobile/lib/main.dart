import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/router/names.dart';
import 'package:mobile/core/router/pages.dart';
import 'package:mobile/core/theme/app_theme.dart';

Future<void> main() async {
  const a =
      '{"last_message_id": 4699, "buttons": [{"buttonId": 0, "buttonText": {"displayText": "🚀 Gostaria de saber mais sobre o FastZap"}, "type": 1}, {"buttonId": 1, "buttonText": {"displayText": "💬Estou precisando de ajuda"}, "type": 1}, {"buttonId": 2, "buttonText": {"displayText": "⚙️Suporte Técnico"}, "type": 1}, {"buttonId": 3, "buttonText": {"displayText": "💳Financeiro"}, "type": 1}]}';
  final b = jsonDecode(a);
  print(b['last_message_id']);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme().dark,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? NamesRouters.SIGN_IN
          : NamesRouters.SIGN_IN,
      getPages: Pages().list,
      debugShowCheckedModeBanner: false,
    );
  }
}
