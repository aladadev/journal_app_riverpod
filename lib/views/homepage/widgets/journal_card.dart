import 'package:flutter/material.dart';
import 'package:journal_app/views/homepage/widgets/card_title.dart';

class JournalCard extends StatelessWidget {
  const JournalCard({
    super.key,
    required this.title,
    required this.dateTime,
    required this.description,
    required this.onTap,
    required this.onDelete,
  });
  final String title;
  final DateTime dateTime;
  final String description;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color.fromARGB(255, 30, 209, 80),
        elevation: 10,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardTitle(
                      title: title, dateTime: dateTime, onDelete: onDelete),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                    softWrap: false,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    softWrap: false,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
