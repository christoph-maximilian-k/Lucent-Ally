import 'package:flutter/material.dart';

class CustomHorizontalDivider extends StatelessWidget {
  final double? marginAll;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;

  const CustomHorizontalDivider({
    super.key,
    this.marginAll,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginAll != null
          ? EdgeInsets.all(marginAll!)
          : EdgeInsets.only(
              top: marginTop,
              bottom: marginBottom,
              left: marginLeft,
              right: marginRight,
            ),
      height: 0.2,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
