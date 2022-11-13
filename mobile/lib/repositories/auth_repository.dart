import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/core/router/names.dart';

class AuthRepository {
  final _storage = GetStorage();
  final _http = Get.find<GetHttpClient>();

  Future<String?> signIn() async {
    final google = GoogleSignIn();

    if (await google.isSignedIn()) {
      await google.disconnect();
      await GoogleSignIn().signOut();
    }
    final user = await google.signIn();
    final auth = await user?.authentication;

    final res = await _http.post('/users', body: {
      "access_token": auth?.accessToken,
    });

    final token = res.body['token'];
    await _storage.write('token', token);
    return token;
  }

  void setToken<T>() {
    final token = _storage.read<String?>('token');
    _http.maxRedirects = 1;
    _http.sendUserAgent = true;
    _http.addRequestModifier<T?>((request) {
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
    _http.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        _storage.erase();
        Get.offAllNamed(NamesRouters.SIGN_IN);
      }
      return response;
    });
  }
}
