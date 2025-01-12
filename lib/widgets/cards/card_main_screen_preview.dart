import 'package:flutter/material.dart';

// Models.
import '/data/models/themes/themes.dart';

class CardMainScreenPreview extends StatelessWidget {
  final bool isDark;
  final Function() onTap;

  const CardMainScreenPreview({
    super.key,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final Themes theme = isDark
        ? Themes.darkTheme(
            screenSize: size,
          )
        : Themes.lightTheme(
            screenSize: size,
          );

    return SizedBox(
      width: size.width * 0.3,
      child: Card(
        color: theme.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                Container(
                  height: 10.0,
                  width: 20.0,
                  decoration: BoxDecoration(
                    color: theme.secondary,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: Card(
                        color: theme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(theme.widgetBorderRadius),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 5.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: theme.onPrimary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            Container(
                              height: 5.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: theme.onSecondary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: Card(
                        color: theme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(theme.widgetBorderRadius),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 5.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: theme.onPrimary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            Container(
                              height: 5.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                color: theme.onSecondary,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 30.0,
                  width: double.infinity,
                  child: Card(
                    color: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(theme.widgetBorderRadius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 5.0,
                          width: 20.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: theme.onPrimary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        Container(
                          height: 5.0,
                          width: size.width * 0.2,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: theme.onBackground,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  width: double.infinity,
                  child: Card(
                    color: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(theme.widgetBorderRadius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 5.0,
                          width: 20.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: theme.onPrimary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        Container(
                          height: 5.0,
                          width: size.width * 0.2,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: theme.onBackground,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                  width: double.infinity,
                  child: Card(
                    color: theme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(theme.widgetBorderRadius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 5.0,
                          width: 20.0,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: theme.onPrimary,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        Container(
                          height: 5.0,
                          width: size.width * 0.2,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: theme.onBackground,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
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
