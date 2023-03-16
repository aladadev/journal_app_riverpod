import 'package:flutter/material.dart';
import 'package:journal_app/models/note_model.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({super.key, required this.data});
  final NotelModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          subtitle: Text(data.description),
        ),
      ),
    );
  }
}
