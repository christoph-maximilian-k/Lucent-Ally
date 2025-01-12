import 'package:flutter/material.dart';
import 'dart:async';

/// Use this widget to delay function triggering.
class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? timer;

  /// [Debouncer] constructor
  Debouncer({this.milliseconds = 300});

  /// Perform a function after set milliseconds.
  /// * Cancels previous ```action``` execution if ```run``` gets called again.
  run({required VoidCallback action}) {
    if (timer != null) timer!.cancel();

    timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
