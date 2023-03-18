import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/models/note_model.dart';
import 'package:journal_app/providers/note_provider.dart';

class AddNewDialog extends ConsumerStatefulWidget {
  const AddNewDialog({
    super.key,
  });

  @override
  ConsumerState<AddNewDialog> createState() => _AddNewDialogState();
}

class _AddNewDialogState extends ConsumerState<AddNewDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SimpleDialog(
        backgroundColor: const Color.fromARGB(255, 206, 77, 77),
        title: const Text(
          'Add a new note',
          textAlign: TextAlign.center,
        ),
        titleTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 20,
            ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Form(
              key: formKey,
              child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'There must be a title!';
                            }
                            return null;
                          },
                          controller: titleController,
                          decoration: InputDecoration(
                            label: const Text('Title'),
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter some description';
                            }
                            return null;
                          },
                          controller: descriptionController,
                          maxLines: 10,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: const Text('Description'),
                            labelStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final newNote = NotelModel(
                                noteDocID: currentUser!.uid +
                                    DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString(),
                                userID: currentUser!.uid,
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                dateTime: DateTime.now(),
                              );

                              await NoteProvider.addNewNote(newNote)
                                  .then((value) {
                                ref.invalidate(futureNoteProvider);
                                Navigator.pop(context);
                              });
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: Text(
                            'Add',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
