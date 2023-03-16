import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      EasyLoading.showSuccess('Logged Out!');
    } catch (error) {
      EasyLoading.showError(error.toString());
    }
  }
}
