import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  Future<String?> signIn() async {
    final google = GoogleSignIn();

    await FirebaseAuth.instance.signOut();
    if (await google.isSignedIn()) {
      await google.disconnect();
      await GoogleSignIn().signOut();
    }
    final user = await google.signIn();
    final auth = await user?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    return credential.accessToken;
  }
}
