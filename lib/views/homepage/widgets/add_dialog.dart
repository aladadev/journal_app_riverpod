import 'package:flutter/material.dart';
import 'package:journal_app/models/note_model.dart';

class AddNewDialog extends StatefulWidget {
  const AddNewDialog({
    super.key,
  });

  @override
  State<AddNewDialog> createState() => _AddNewDialogState();
}

class _AddNewDialogState extends State<AddNewDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final newNote = NotelModel(
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                dateTime: DateTime.now(),
                              );
                              Navigator.pop(context, newNote);
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
