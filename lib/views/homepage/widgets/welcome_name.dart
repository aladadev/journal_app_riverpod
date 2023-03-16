import 'package:flutter/material.dart';
import 'package:journal_app/models/profile_model.dart';

class WelcomeName extends StatelessWidget {
  WelcomeName({
    super.key,
    required this.profileModel,
    required this.onPress,
  });
  final ProfileModel profileModel;
  final formkey = GlobalKey<FormState>();
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${profileModel.name}',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 20,
                  ),
            ),
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 15,
                  ),
            ),
          ],
        ),
        IconButton(
          onPressed: onPress,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
