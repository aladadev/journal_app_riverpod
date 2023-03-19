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

class GoogleandMobileSign extends StatelessWidget {
  const GoogleandMobileSign({
    super.key,
    this.onGoogleTap,
    this.onPhoneIconTap,
  });

  final Function()? onGoogleTap;
  final Function()? onPhoneIconTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: onGoogleTap,
          child: Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              fit: BoxFit.cover),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          onPressed: onPhoneIconTap,
          icon: const Icon(
            Icons.phone_android_rounded,
            size: 40,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }
}
