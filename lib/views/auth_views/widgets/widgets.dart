import 'package:flutter/material.dart';

class AlreadyUserChecker extends StatelessWidget {
  const AlreadyUserChecker({
    super.key,
    required this.firstString,
    required this.secondString,
    required this.onPress,
  });
  final String firstString, secondString;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstString),
        GestureDetector(
          onTap: onPress,
          child: Text(
            secondString,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
