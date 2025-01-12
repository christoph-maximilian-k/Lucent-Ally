import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

class Logo extends StatelessWidget {
  final double size;
  final MainAxisAlignment mainAxisAlignment;
  final bool showName;

  const Logo({
    super.key,
    required this.size,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.showName = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SizedBox(
          height: size,
          width: size,
          child: Image.asset(
            'assets/launcher/logo_transparent_gradient.png',
            fit: BoxFit.fill,
          ),
        ),
        if (showName)
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              labels.appName(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
      ],
    );
  }
}
