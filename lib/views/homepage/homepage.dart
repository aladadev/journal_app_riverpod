import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journal_app/providers/auth_provider.dart';
import 'package:journal_app/providers/firestore_provider.dart';
import 'package:journal_app/providers/note_provider.dart';
import 'package:journal_app/views/homepage/card_single_page.dart';
import 'package:journal_app/views/homepage/widgets/add_dialog.dart';
import 'package:journal_app/views/homepage/widgets/journal_card.dart';
import 'package:journal_app/views/homepage/widgets/welcome_name.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final notesList = ref.watch(futureNoteProvider);
    final profileGetter = ref.watch(profileFromDatabase);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 18, 20),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 20,
              // ),
              profileGetter.when(
                data: (data) {
                  if (data != null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: WelcomeName(
                        profileModel: data,
                        onPress: () async {
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const AddNewDialog();
                            },
                          ));
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return const AddNewDialog();
                          //   },
                          // );
                        },
                      ),
                    );
                  } else {
                    return const Text('Error in ProfileGetter.when');
                  }
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),
              notesList.when(
                data: (data) {
                  if (data.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return JournalCard(
                            title: data[index].title,
                            dateTime: data[index].dateTime,
                            description: data[index].description,
                            onDelete: () async {
                              await NoteProvider.deleteNote(
                                      data[index].noteDocID)
                                  .then((value) =>
                                      ref.invalidate(futureNoteProvider));
                            },
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return CardDetails(data: data[index]);
                                },
                              ));
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const Text('empty list');
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // const JournalCard(),
              IconButton(
                onPressed: () async {
                  await AuthProvider.signOut();
                },
                icon: const Icon(
                  Icons.accessibility_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
