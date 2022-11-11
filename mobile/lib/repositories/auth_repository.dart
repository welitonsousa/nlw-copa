import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    setToken();
    await _storage.write('token', token);
    return token;
  }

  setToken<T>() {
    final token = _storage.read('token');
    _http.addAuthenticator<T?>((request) async {
      request.headers['Authorization'] = "Bearer $token";
      return request;
    });
  }
}
