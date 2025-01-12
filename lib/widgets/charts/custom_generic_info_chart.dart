import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Config.
import '/config/app_icons.dart';

// User.
import '/main.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';
import '/widgets/customs/custom_drop_down_button.dart';

class CustomGenericInfoChart extends StatefulWidget {
  final double? cardHeight;
  final double? cardWidth;

  final String chartTitle;
  final String subtitle;

  // * Static chart replacement message.
  final String staticChartReplacementMessage;

  // * Menu.
  final Function()? onMenuPressed;

  // * Relaod indicators.
  final bool triggerReload;
  final List<dynamic> reloadIndicators;

  // * On chart tap.
  final Function()? onTap;

  // * Drop Down Buttons.
  final List<CustomDropDownButton> dropDownButtons;

  // * Futures.
  final String firstFutureTitle;
  final IconData firstFutureIcon;
  final Function() firstFuture;

  final String? secondFutureTitle;
  final IconData? secondFutureIcon;
  final Function()? secondFuture;

  final String? thirdFutureTitle;
  final IconData? thirdFutureIcon;
  final Function()? thirdFuture;

  final String? fourthFutureTitle;
  final IconData? fourthFutureIcon;
  final Function()? fourthFuture;

  // * Info line.
  final String? chartInfoLine;

  const CustomGenericInfoChart({
    super.key,
    this.cardHeight,
    this.cardWidth,
    required this.chartTitle,
    this.subtitle = '',
    // * Static chart replacement message.
    required this.staticChartReplacementMessage,
    this.onTap,
    required this.firstFutureTitle,
    required this.firstFutureIcon,
    required this.firstFuture,
    this.dropDownButtons = const [],
    this.triggerReload = false,
    this.reloadIndicators = const [],
    this.onMenuPressed,
    this.secondFutureTitle,
    this.secondFutureIcon,
    this.secondFuture,
    this.thirdFutureTitle,
    this.thirdFutureIcon,
    this.thirdFuture,
    this.fourthFutureTitle,
    this.fourthFutureIcon,
    this.fourthFuture,
    this.chartInfoLine,
  });

  @override
  State<CustomGenericInfoChart> createState() => _CustomGenericInfoChartState();
}

class _CustomGenericInfoChartState extends State<CustomGenericInfoChart> {
  late Future<dynamic> _firstFuture;
  late Future<dynamic> _secondFuture;
  late Future<dynamic> _thirdFuture;
  late Future<dynamic> _fourthFuture;

  @override
  void initState() {
    super.initState();
    if (widget.staticChartReplacementMessage.isEmpty) {
      _firstFuture = widget.firstFuture();

      if (widget.secondFuture != null) _secondFuture = widget.secondFuture!();
      if (widget.thirdFuture != null) _thirdFuture = widget.thirdFuture!();
      if (widget.fourthFuture != null) _fourthFuture = widget.fourthFuture!();
    }
  }

  @override
  void didUpdateWidget(covariant CustomGenericInfoChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.staticChartReplacementMessage.isEmpty) {
      // * A reload should be triggered.
      if (widget.triggerReload) _reloadAllFutures();

      // * In a case where triggerReload is set to true, make sure that reload indicators are ignored.
      if (widget.triggerReload == false) {
        if (widget.reloadIndicators.isNotEmpty && listEquals(oldWidget.reloadIndicators, widget.reloadIndicators) == false) _reloadAllFutures();
      }
    }
  }

  /// This function can be used to reload all futures.
  void _reloadAllFutures() {
    // Update the future and trigger a rebuild.
    setState(() {
      _firstFuture = widget.firstFuture();

      if (widget.secondFuture != null) _secondFuture = widget.secondFuture!();
      if (widget.thirdFuture != null) _thirdFuture = widget.thirdFuture!();
      if (widget.fourthFuture != null) _fourthFuture = widget.fourthFuture!();
    });
  }

  // Helper to calcualte height.
  double calculateHeight() {
    double height = widget.cardHeight ?? 210.0;

    if (widget.chartInfoLine != null) height = height + 25.0;
    if (widget.dropDownButtons.isNotEmpty) height = height + 50.0;
    if (widget.subtitle.isNotEmpty) height = height + 24.0;

    return height;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: calculateHeight(),
      width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
      child: Card(
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  height: 45.0,
                  width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: widget.onMenuPressed != null ? widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9 * 0.6 : null,
                          child: Text(
                            widget.chartTitle,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ),
                      if (widget.onMenuPressed != null)
                        IconButton(
                          icon: const Icon(
                            AppIcons.moreOptions,
                          ),
                          onPressed: () => widget.onMenuPressed!(),
                        ),
                    ],
                  ),
                ),
                if (widget.subtitle.isNotEmpty)
                  Container(
                    width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Text(
                          widget.subtitle,
                          style: Theme.of(context).textTheme.displaySmall,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                // * DropDownButtons.
                if (widget.dropDownButtons.isNotEmpty)
                  Container(
                    width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: widget.dropDownButtons,
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 150.0,
                  width: 300.0,
                  child: widget.staticChartReplacementMessage.isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              widget.staticChartReplacementMessage,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Wrap(
                            spacing: 5.0,
                            runSpacing: 5.0,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.center,
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    // * First future.
                                    _chipBuilder(
                                        context: context,
                                        title: widget.firstFutureTitle,
                                        future: _firstFuture,
                                        icon: widget.firstFutureIcon,
                                        color: user.isLightTheme? Colors.grey[200]! : const Color.fromARGB(255, 107, 130, 141),
                                        onReload: () => setState(() {
                                              _firstFuture = widget.firstFuture();
                                            })),
                                    // * Second future.
                                    if (widget.secondFuture != null)
                                      _chipBuilder(
                                        context: context,
                                        title: widget.secondFutureTitle!,
                                        future: _secondFuture,
                                        icon: widget.secondFutureIcon!,
                                        color: user.isLightTheme? Colors.grey[200]! : const Color.fromARGB(255, 107, 130, 141),
                                        onReload: () => setState(() {
                                          _secondFuture = widget.secondFuture!();
                                        }),
                                      ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    // * Third future.
                                    if (widget.thirdFuture != null)
                                      _chipBuilder(
                                        context: context,
                                        title: widget.thirdFutureTitle!,
                                        future: _thirdFuture,
                                        icon: widget.thirdFutureIcon!,
                                        color: user.isLightTheme? Colors.grey[200]! : const Color.fromARGB(255, 107, 130, 141),
                                        onReload: () => setState(() {
                                          _thirdFuture = widget.thirdFuture!();
                                        }),
                                      ),

                                    // * Fourth future.
                                    if (widget.fourthFuture != null)
                                      _chipBuilder(
                                        context: context,
                                        title: widget.fourthFutureTitle!,
                                        future: _fourthFuture,
                                        icon: widget.fourthFutureIcon!,
                                        color: user.isLightTheme? Colors.grey[200]! : const Color.fromARGB(255, 107, 130, 141),
                                        onReload: () => setState(() {
                                          _fourthFuture = widget.fourthFuture!();
                                        }),
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                ),
                const SizedBox(height: 5.0),
                if (widget.chartInfoLine != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Icon(
                          AppIcons.info,
                          size: 12,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          widget.chartInfoLine!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.labelSmall!.color,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _chipBuilder({required String title, required Color color, required IconData icon, required BuildContext context, required Future<dynamic> future, required Function()? onReload}) {
  return Container(
    constraints: const BoxConstraints(
      minWidth: 120.0,
    ),
    margin: const EdgeInsets.all(3.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15.0), // Rounded corners
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18.0,
                color: Colors.black,
              ),
              const SizedBox(width: 15.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3.0),
          FutureBuilder<dynamic>(
            future: future,
            builder: (context, snapshot) {
              // Show loading indication.
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  height: 22.0,
                  width: 22.0,
                  child: CustomLoadingSpinner(
                    onlySpinner: true,
                    color: Colors.black,
                  ),
                );
              }

              // Show failure.
              if (snapshot.hasError || snapshot.hasData == false || snapshot.data == null) {
                return InkWell(
                  onTap: () => onReload!(),
                  child: const SizedBox(
                    height: 22.0,
                    width: 22.0,
                    child: Icon(
                      AppIcons.refresh,
                      size: 22.0,
                      color: Colors.black,
                    ),
                  ),
                );
              }

              // ##################################################
              // Loading data succeeded
              // ##################################################

              // Convenience variable.
              final dynamic data = snapshot.data!;

              return Container(
                constraints: const BoxConstraints(minWidth: 28.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: Colors.black, // Border color
                    width: 1.5, // Border width
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(
                      '$data',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 5.0),
        ],
      ),
    ),
  );
}
