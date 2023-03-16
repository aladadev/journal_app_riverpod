import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/constants/constants.dart';
import 'package:journal_app/models/profile_model.dart';

final profileFromDatabase = FutureProvider<ProfileModel?>((ref) {
  final firebaseCollectionPath =
      FirebaseFirestore.instance.collection(FireBaseConstants.userProfile);
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    return firebaseCollectionPath
        .where('uid', isEqualTo: currentUser.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return ProfileModel.fromMap(value.docs.first.data());
      } else {
        return null;
      }
    });
  }
  return null;
});

class FireStoreProvider {
  // add new user info to database when someone register
  static Future<bool> addNewUser(ProfileModel profile) async {
    final fireBaseCollectionPath =
        FirebaseFirestore.instance.collection(FireBaseConstants.userProfile);
    try {
      EasyLoading.show(status: 'Saving User');
      await fireBaseCollectionPath.doc(profile.uid).set(
            profile.toMap(),
          );
      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.showError(error.toString());
      return false;
    }
  }

  static Future<bool> updateUser(ProfileModel profile) async {
    final fireBaseCollectionPath =
        FirebaseFirestore.instance.collection(FireBaseConstants.userProfile);
    try {
      EasyLoading.show(status: 'Updating Profile');
      await fireBaseCollectionPath.doc(profile.uid).update(profile.toMap());
      EasyLoading.dismiss();
      return true;
    } catch (error) {
      EasyLoading.showError(error.toString());
      return false;
    }
  }
}
