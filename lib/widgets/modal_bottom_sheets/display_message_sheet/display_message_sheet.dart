import 'package:flutter/material.dart';

class DisplayMessageSheet extends StatelessWidget {
  final String? title;
  final String? message;

  const DisplayMessageSheet({
    super.key,
    this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      constraints: BoxConstraints(
        maxHeight: height * 0.9,
        minHeight: height * 0.4,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    title!,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              if (message != null)
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    message!,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
