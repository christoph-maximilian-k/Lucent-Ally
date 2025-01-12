import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Widgets.
import '/widgets/customs/custom_loading_spinner.dart';

// Models.
import '/data/models/references/field_to_entry/field_to_entry.dart';
import '/data/models/field_types/date_of_birth_data/date_of_birth_data.dart';
import '/data/models/field_identifications/field_identification.dart';
import '/data/models/model_entries/model_entries.dart';

class CustomNextBirthdayInfoChart extends StatefulWidget {
  final ModelEntries modelEntries;
  final double? cardHeight;
  final double? cardWidth;

  final String chartTitle;

  // * On chart tap.
  final Function()? onTap;

  // * Future.
  final Function() loadNextBirthdays;

  // * Info line.
  final String? chartInfoLine;

  const CustomNextBirthdayInfoChart({
    super.key,
    required this.modelEntries,
    this.cardHeight,
    this.cardWidth,
    required this.chartTitle,
    this.onTap,
    required this.loadNextBirthdays,
    this.chartInfoLine,
  });

  @override
  State<CustomNextBirthdayInfoChart> createState() => _CustomNextBirthdayInfoChartState();
}

class _CustomNextBirthdayInfoChartState extends State<CustomNextBirthdayInfoChart> {
  late Future<List<FieldToEntry>> _loadNextBirthday;

  /// This function can be used to reload chart data.
  void _reloadChartData() {
    // Update the future and trigger a rebuild.
    setState(() {
      _loadNextBirthday = widget.loadNextBirthdays();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNextBirthday = widget.loadNextBirthdays();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0, bottom: 5.0),
                  child: Text(
                    widget.chartTitle,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 15.0),
                FutureBuilder<List<FieldToEntry>>(
                  future: _loadNextBirthday,
                  builder: (context, snapshot) {
                    // Show loading indication.
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                        child: Center(
                          child: CustomLoadingSpinner(
                            onlySpinner: true,
                            paddingRight: 15.0,
                          ),
                        ),
                      );
                    }

                    // Show failure.
                    if (snapshot.hasError || snapshot.hasData == false || snapshot.data == null) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                labels.basicLabelsGenericError(),
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10.0),
                              IconButton(
                                icon: const Icon(
                                  AppIcons.refresh,
                                  size: 25.0,
                                ),
                                onPressed: () => _reloadChartData(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    // ##################################################
                    // Loading data succeeded
                    // ##################################################

                    // Convenience variable.
                    final List<FieldToEntry> data = snapshot.data!;

                    // Show empty message.
                    if (data.isEmpty) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              labels.noUpcomingBirthday(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: widget.cardHeight ?? 170.0,
                      width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.8,
                      child: ListView.builder(
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // Convenience variables.
                          final FieldIdentification? fieldIdentification = widget.modelEntries.getFieldIdentificationById(
                            fieldId: data[index].field!.fieldId,
                          );

                          final String entryName = data[index].entryName;
                          final String fieldLabel = fieldIdentification?.label ?? labels.basicLabelsUnknownField();
                          final DateOfBirthData dateOfBirth = data[index].field!.dateOfBirthData!;
                          final String age = dateOfBirth.getAgeAsLabel;

                          // Populate widget.
                          return Container(
                            width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.7,
                            margin: const EdgeInsets.only(right: 10.0),
                            decoration: dateOfBirth.getHasBirthday
                                ? const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [Colors.deepOrange, Colors.deepPurple],
                                    ),
                                  )
                                : BoxDecoration(
                                    border: Border.all(
                                      color: Colors.teal, // Color of the outline
                                      width: 2.0, // Width of the outline
                                    ),
                                    borderRadius: BorderRadius.circular(12.0), // Rounded corners
                                  ),
                            child: Container(
                              width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.7,
                              margin: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (dateOfBirth.getHasBirthday)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        labels.birthdayIsToday(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: Theme.of(context).textTheme.displayMedium!.fontSize,
                                        ),
                                      ),
                                    ),
                                  // * Entry name.
                                  Row(
                                    children: [
                                      const SizedBox(width: 15.0),
                                      SizedBox(
                                        width: 90.0,
                                        child: Text(
                                          labels.basicLabelsEntry(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          entryName,
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // * Feld name.
                                  Row(
                                    children: [
                                      const SizedBox(width: 15.0),
                                      SizedBox(
                                        width: 90.0,
                                        child: Text(
                                          labels.basicLabelsField(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          fieldLabel,
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // * Birthday date.
                                  Row(
                                    children: [
                                      const SizedBox(width: 15.0),
                                      SizedBox(
                                        width: 90.0,
                                        child: Text(
                                          labels.basicLabelsDate(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          dateOfBirth.getFormattedDate,
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // * Days until.
                                  Row(
                                    children: [
                                      const SizedBox(width: 15.0),
                                      SizedBox(
                                        width: 90.0,
                                        child: Text(
                                          labels.basicLabelsDaysUntil(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          dateOfBirth.getDaysUntilBirthday.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  // * Age.
                                  Row(
                                    children: [
                                      const SizedBox(width: 15.0),
                                      SizedBox(
                                        width: 95.0,
                                        child: Text(
                                          labels.basicLabelsCurrentAge(),
                                          style: Theme.of(context).textTheme.displayMedium,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          age,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.right,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ),
                                      const SizedBox(width: 15.0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                if (widget.chartInfoLine != null)
                  Container(
                    width: widget.cardWidth ?? MediaQuery.of(context).size.width * 0.8,
                    margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          AppIcons.info,
                          size: 12,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        const SizedBox(width: 15.0),
                        Expanded(
                          child: Text(
                            widget.chartInfoLine!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.labelSmall!.color,
                              fontSize: 8,
                            ),
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
