import 'package:flutter/material.dart';

class CustomNotification extends StatefulWidget {
  final String notification;
  final Duration duration;

  const CustomNotification({
    super.key,
    required this.notification,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> position;

  @override
  void initState() {
    super.initState();

    // Init the controller.
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Init the position.
    position = Tween<Offset>(begin: const Offset(0.0, -4.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Convenience variables.
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      // * This is needed to prevent unwanted modal sheet dismissing if user starts dragging down starting on notification.
      onVerticalDragStart: (details) => {},
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SlideTransition(
            position: position,
            child: Material(
              elevation: 6.0,
              shadowColor: Theme.of(context).colorScheme.shadow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: width * 0.4,
                ),
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Material(
                    color: Theme.of(context).colorScheme.primary,
                    child: Text(
                      widget.notification,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
