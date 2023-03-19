import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  static final authStateProvider = StreamProvider<User?>((ref) {
    return FirebaseAuth.instance.authStateChanges();
  });

  // Register Authentication Method
  static Future<User?> registerAuth(
      {required String name,
      required String email,
      required String password,
      required String confirmpass}) async {
    try {
      EasyLoading.show(status: 'Registering!');

      final UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      EasyLoading.showSuccess('Account Created!');
      return userCred.user;
    } catch (error) {
      EasyLoading.showError(error.toString());

      return null;
    }
  }

  //Login Authentication Method
  static Future<User?> loginAuth(
      {required String email, required String password}) async {
    try {
      EasyLoading.show(status: 'Connecting!');
      final userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      EasyLoading.showSuccess('Success!');
      return userCred.user;
    } catch (error) {
      EasyLoading.showError(error.toString());
      return null;
    }
  }

  // LogOut Method
  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      EasyLoading.showSuccess('Logged Out!');
    } catch (error) {
      EasyLoading.showError(error.toString());
    }
  }

  //Google Sign In Methods

  static Future<User?> signInWithGoogle() async {
    // shows the google sign in dialog
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //obtain auth detauls from the request

    if (googleUser != null) {
      try {
        EasyLoading.show(status: 'Google Sign In....');
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final signInCred =
            await FirebaseAuth.instance.signInWithCredential(credential);
        EasyLoading.showSuccess('Success!');
        return signInCred.user;
      } catch (error) {
        EasyLoading.showError(error.toString());
        return null;
      }
    } else {
      return null;
    }
  }
}
