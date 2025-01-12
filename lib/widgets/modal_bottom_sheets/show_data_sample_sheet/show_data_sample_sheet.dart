import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Config.
import '/config/app_icons.dart';

// Labels.
import '/main.dart';

// Cubits.
import '/widgets/modal_bottom_sheets/show_data_sample_sheet/cubit/show_data_sample_sheet_cubit.dart';

class ShowDataSampleSheet extends StatelessWidget {
  const ShowDataSampleSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowDataSampleSheetCubit, ShowDataSampleSheetState>(
      listenWhen: (previous, current) {
        // * This is needed because there is a bug that sometimes triggers events twice unintentionally.
        // * The result is that if a close event is triggered twice, pop is called on the wrong context and
        // * routing gets fucked up somehow. So for lack of another fix, use this hack to ignore the event if
        // * previous event was already a close event.
        if (previous.status == ShowDataSampleSheetStatus.close && current.status == ShowDataSampleSheetStatus.close) return false;

        return true;
      },
      listener: (context, state) {
        // * Close modal bottom sheet.
        if (state.status == ShowDataSampleSheetStatus.close) Navigator.of(context).pop();
      },
      // * Do not rebuild widget if status was set to close to improve UX.
      buildWhen: (context, state) => state.status != ShowDataSampleSheetStatus.close,
      builder: (context, state) {
        // Access height.
        final double height = MediaQuery.of(context).size.height;

        return SizedBox(
          height: height * 0.5,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.csvTable.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DataTable(
                        columns: List.generate(
                          state.csvTable.first.length,
                          (int index) => DataColumn(
                            label: Text(
                              state.csvTable.first[index].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                        rows: List.generate(
                          // Change to "state.csvTable.length - 1", to show all rows.
                          // * This ternary condition is needed because otherwise if a table with less then 5 rows is loaded a out of bound index error occurrs.
                          state.csvTable.length - 1 <= 20 ? state.csvTable.length - 1 : 20,
                          (int indexRow) => DataRow(
                            cells: List.generate(
                              state.csvTable.first.length,
                              (int cellIndex) {
                                // Skip the first row (header) by adjusting indexRow + 1.
                                final String data = state.csvTable[indexRow + 1][cellIndex].toString();

                                return DataCell(
                                  Text(
                                    data,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        top: 20.0,
                        bottom: 35.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            AppIcons.info,
                            color: Theme.of(context).primaryIconTheme.color,
                            size: 25.0,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            labels.dataPreview(shownRows: 20),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
