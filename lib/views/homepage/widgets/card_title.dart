import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardTitle extends StatelessWidget {
  const CardTitle({
    super.key,
    required this.title,
    required this.dateTime,
  });
  final String title;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('EEE, MMM d, ' 'yy').format(dateTime)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Name',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
      ],
    );
  }
}
