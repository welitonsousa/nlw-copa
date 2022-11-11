import 'package:get/route_manager.dart';
import 'package:mobile/core/router/names.dart';
import 'package:mobile/modules/home/home_bindings.dart';
import 'package:mobile/modules/home/home_page.dart';
import 'package:mobile/modules/poll/find_pool/find_pool_bindings.dart';
import 'package:mobile/modules/poll/find_pool/find_pool_page.dart';
import 'package:mobile/modules/sign_in/sign_in_bindings.dart';
import 'package:mobile/modules/sign_in/sign_in_page.dart';

class Pages {
  static const initial = NamesRouters.SIGN_IN;
  final list = <GetPage>[
    GetPage(
      name: NamesRouters.HOME,
      binding: HomeBindings(),
      page: () => const HomePage(),
    ),
    GetPage(
      name: NamesRouters.SIGN_IN,
      binding: SignInBindings(),
      page: () => const SignInPage(),
    ),
    GetPage(
      name: NamesRouters.FIND_POOL,
      binding: FindPoolBindings(),
      page: () => const FindPoolPage(),
    )
  ];
}
