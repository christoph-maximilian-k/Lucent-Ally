import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  // Header.
  final IconData icon;
  final String? title;
  final String? subtitle;

  final bool displayAsColumn;

  const CustomHeader({
    super.key,
    required this.icon,
    this.title,
    this.subtitle,
    this.displayAsColumn = true,
  });

  @override
  Widget build(BuildContext context) {
    // Dispaly content as column.
    if (displayAsColumn) return _columnContent(context: context, icon: icon, title: title, subtitle: subtitle);

    return _rowContent(context: context, icon: icon, title: title, subtitle: subtitle);
  }
}

/// Displaying header as a row.
Widget _rowContent({required BuildContext context, required IconData icon, required String? title, required String? subtitle}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15.0, top: 10.0, bottom: 10.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: Theme.of(context).iconTheme.size,
            color: Theme.of(context).iconTheme.color,
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    ),
  );
}

/// Displaying header as a column.
Widget _columnContent({required BuildContext context, required IconData icon, required String? title, required String? subtitle}) {
  return Column(
    children: [
      const SizedBox(height: 15.0),
      Icon(
        icon,
        size: Theme.of(context).iconTheme.size,
        color: Theme.of(context).iconTheme.color,
      ),
      if (title != null)
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
        ),
      if (subtitle != null)
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Text(
            subtitle,
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ),
      const SizedBox(height: 15.0),
    ],
  );
}
