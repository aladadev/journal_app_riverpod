import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/constants/constants.dart';
import 'package:journal_app/models/note_model.dart';

final futureNoteProvider = FutureProvider<List<NotelModel>>((ref) async {
  final noteCollectionPath =
      FirebaseFirestore.instance.collection(FireBaseConstants.noteCollection);
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    final notesList = await noteCollectionPath
        .where('userID', isEqualTo: currentUser.uid)
        .get()
        .then((value) {
      return value.docs.map((e) => NotelModel.fromMap(e.data()));
    });

    return notesList.toList();
  } else {
    return [];
  }
});

class NoteProvider {
  static Future<bool> addNewNote(NotelModel newNote) async {
    final noteCollection =
        FirebaseFirestore.instance.collection(FireBaseConstants.noteCollection);
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        EasyLoading.show(status: 'Saving note!');
        await noteCollection.doc(newNote.noteDocID).set(newNote.toMap());

        EasyLoading.dismiss();
        return true;
      }
    } catch (error) {
      EasyLoading.showError(error.toString());
      return false;
    }
    return false;
  }

  static Future<bool> deleteNote(String docID) async {
    final noteCollection =
        FirebaseFirestore.instance.collection(FireBaseConstants.noteCollection);
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        EasyLoading.show(status: 'Deleting Note!');
        await noteCollection.doc(docID).delete();

        EasyLoading.dismiss();
        return true;
      }
    } catch (error) {
      EasyLoading.showError(error.toString());
      return false;
    }
    return false;
  }
}
